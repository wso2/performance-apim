#!/bin/bash -e
# Copyright (c) 2022, WSO2 LLC (http://wso2.org)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# ----------------------------------------------------------------------------
# Create APPs in WSO2 API Manager
# ----------------------------------------------------------------------------

script_dir=$(dirname "$0")
apim_host=""
no_of_apps=0
token_type="JWT"

function usage() {
    echo ""
    echo "Usage: "
    echo "$0 -a <apim_host> -n <no_of_apps> -k <token_type> [-h]"
    echo ""
    echo "-a: Hostname of WSO2 API Manager."
    echo "-n: Number of applications."
    echo "-k: Token type."
    echo "-h: Display this help and exit."
    echo ""
}

while getopts "a:n:k:h" opt; do
    case "${opt}" in
    a)
        apim_host=${OPTARG}
        ;;
    n)
        no_of_apps=${OPTARG}
        ;;
    k)
        token_type=${OPTARG}
        ;;
    h)
        usage
        exit 0
        ;;
    \?)
        usage
        exit 1
        ;;
    *)
        opts+=("-${opt}")
        [[ -n "$OPTARG" ]] && opts+=("$OPTARG")
        ;;
    esac
done
shift "$((OPTIND - 1))"

base_https_url="https://${apim_host}"

curl_command="curl -sk"

#Check whether jq command exsits
if ! command -v jq >/dev/null 2>&1; then
    echo "Please install jq."
    exit 1
fi

confirm() {
    # call with a prompt string or use a default
    read -r -p "${1:-Are you sure?} [y/N] " response
    case $response in
    [yY][eE][sS] | [yY])
        true
        ;;
    *)
        false
        ;;
    esac
}

# Register Client and Get Access Token
client_request() {
    cat <<EOF
{
    "callbackUrl": "wso2.org",
    "clientName": "setup_apim_script",
    "tokenScope": "Production",
    "owner": "admin",
    "grantType": "password refresh_token",
    "saasApp": true
}
EOF
}

# Create application request payload
app_request() {
    cat <<EOF
{ 
   "name":"app$1",
   "throttlingPolicy":"Unlimited",
   "description":"application$1",
   "tokenType":"JWT",
   "attributes":{ 
   }
}
EOF
}

generate_keys_request() {
    cat <<EOF
{ 
   "keyType":"PRODUCTION",
   "grantTypesToBeSupported":[ 
      "refresh_token",
      "password",
      "client_credentials",
      "urn:ietf:params:oauth:grant-type:jwt-bearer"
   ],
   "callbackUrl":"wso2.org"
}
EOF
}

client_credentials=$($curl_command -u "admin:admin" -H "Content-Type: application/json" -d "$(client_request)" ${base_https_url}/client-registration/v0.17/register | jq -r '.clientId + ":" + .clientSecret')

get_access_token() {
    local access_token=$($curl_command -d "grant_type=password&username=admin&password=admin&scope=apim:$1" -u "$client_credentials" ${base_https_url}/oauth2/token | jq -r '.access_token')
    echo $access_token
}

get_admin_access_token() {
    local access_token=$($curl_command -d "grant_type=password&username=admin&password=admin&scope=apim:admin+apim:api_create+apim:api_delete+apim:api_generate_key+apim:api_import_export+apim:api_product_import_export+apim:api_publish+apim:api_view+apim:app_import_export+apim:client_certificates_add+apim:client_certificates_update+apim:client_certificates_view+apim:comment_view+apim:comment_write+apim:document_create+apim:document_manage+apim:ep_certificates_add+apim:ep_certificates_update+apim:ep_certificates_view+apim:mediation_policy_create+apim:mediation_policy_manage+apim:mediation_policy_view+apim:common_operation_policy_manage+apim:pub_alert_manage+apim:publisher_settings+apim:shared_scope_manage+apim:subscription_block+apim:subscription_view+apim:threat_protection_policy_create+apim:threat_protection_policy_manage+openid+service_catalog:service_view+service_catalog:service_write" -u $client_credentials ${base_https_url}/oauth2/token | jq -r '.access_token')
    echo $access_token
}

view_access_token=$(get_access_token api_view)
create_access_token=$(get_access_token api_create)
publish_access_token=$(get_access_token api_publish)
subscribe_access_token=$(get_access_token subscribe)
app_access_token=$(get_access_token app_manage)
mediation_policy_create_token=$(get_access_token mediation_policy_create) 
sub_manage_token=$(get_access_token sub_manage) 
admin_token=$(get_admin_access_token)
# temp fix
get_keymanager=$($curl_command -H "Authorization: Bearer $app_access_token" "${base_https_url}/api/am/devportal/v2/key-managers")
# To add subscriber to AM_SUBSCRIBER table. Else, application addition will give an error.
application_id=$($curl_command -H "Authorization: Bearer $subscribe_access_token" "${base_https_url}/api/am/devportal/v2/applications?query=app1" | jq -r '.list[0] | .applicationId')

mkdir -p "$script_dir/target"
## Creating an empty csv file to store the consumer key and consumer secrets of the applications
echo -n "" > "$script_dir/target/client_credentials.csv"

echo "Creating applications"
echo -ne "\n"
count=1
 
#Iterate the loop until count is less than or equal to no_of_apps
while [ $count -le $no_of_apps ]
do
    application_id=$($curl_command -X POST -H "Authorization: Bearer $app_access_token" -H "Content-Type: application/json" -d "$(app_request $count)" "${base_https_url}/api/am/devportal/v2/applications" | jq -r '.applicationId')
    if [ ! -z $application_id ] && [ ! $application_id = "null" ]; then
        echo "Found application id for \"app$count\": $application_id"
    else
        echo "Failed to find application id for \"app$count\""
        exit 1
    fi

    echo "Generating keys for app"$count""

    # Generate Keys
    keys_response=$($curl_command -H "Authorization: Bearer $app_access_token" -H "Content-Type: application/json" -d "$(generate_keys_request)" "${base_https_url}/api/am/devportal/v2/applications/$application_id/generate-keys")
    consumer_key=$(echo $keys_response | jq -r '.consumerKey')
    consumer_secret=$(echo $keys_response | jq -r '.consumerSecret')

    if [ ! -z $consumer_key ] && [ ! $consumer_key = "null" ]; then
        echo "Keys generated for \"app$count\". Consumer key is $consumer_key"
    else
        echo "Failed to generate keys for \"app$count\""
        # Get Key from application
        keys_response=$($curl_command -H "Authorization: Bearer $subscribe_access_token" "${base_https_url}/api/am/devportal/v2/applications/$application_id")
        consumer_key=$(echo $keys_response | jq -r '.keys[0] | .consumerKey')
        if [ ! -z $consumer_key ] && [ ! $consumer_key = "null" ]; then
            echo "Retrieved keys for \"app$count\". Consumer key is $consumer_key"
        else
            echo "Failed to retrieve keys for \"app$count\""
            exit 1
        fi
    fi
    echo "$consumer_key,$consumer_secret" >> "$script_dir/target/client_credentials.csv"
    echo -ne "\n"

    # increment the value
    count=`expr $count + 1`
done

echo -ne "\n"

