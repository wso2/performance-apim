#!/bin/bash -e
# Copyright 2017 WSO2 Inc. (http://wso2.org)
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
# Create APIs in WSO2 API Manager
# ----------------------------------------------------------------------------

script_dir=$(dirname "$0")
apim_host=""
api_name=""
api_description=""
backend_endpoint_url=""
default_backend_endpoint_type="http"
backend_endpoint_type="$default_backend_endpoint_type"
out_sequence=""

function usage() {
    echo ""
    echo "Usage: "
    echo "$0 -a <apim_host> -n <api_name> -d <api_description> -b <backend_endpoint_url>"
    echo "   [-t <backend_endpoint_type>] [-o <out_sequence>] [-h]"
    echo ""
    echo "-a: Hostname of WSO2 API Manager."
    echo "-n: API Name."
    echo "-d: API Description."
    echo "-b: Backend endpoint URL."
    echo "-t: Backend endpoint type. Default: $default_backend_endpoint_type."
    echo "-o: Out Sequence."
    echo "-h: Display this help and exit."
    echo ""
}

while getopts "a:n:d:b:t:o:h" opt; do
    case "${opt}" in
    a)
        apim_host=${OPTARG}
        ;;
    n)
        api_name=${OPTARG}
        ;;
    d)
        api_description=${OPTARG}
        ;;
    b)
        backend_endpoint_url=${OPTARG}
        ;;
    t)
        backend_endpoint_type=${OPTARG}
        ;;
    o)
        out_sequence=${OPTARG}
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

if [[ -z $apim_host ]]; then
    echo "Please provide the Hostname of WSO2 API Manager."
    exit 1
fi

if [[ -z $api_name ]]; then
    echo "Please provide the API Name."
    exit 1
fi

if [[ -z $api_description ]]; then
    echo "Please provide the API description."
    exit 1
fi

if [[ -z $backend_endpoint_url ]]; then
    echo "Please provide the backend endpoint URL."
    exit 1
fi

if [[ -z $backend_endpoint_type ]]; then
    echo "Please provide the backend endpoint type."
    exit 1
fi

base_https_url="https://${apim_host}:9443"
nio_https_url="https://${apim_host}:8243"

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

client_credentials=$($curl_command -u admin:admin -H "Content-Type: application/json" -d "$(client_request)" ${base_https_url}/client-registration/v0.14/register | jq -r '.clientId + ":" + .clientSecret')

get_access_token() {
    local access_token=$($curl_command -d "grant_type=password&username=admin&password=admin&scope=apim:$1" -u $client_credentials ${nio_https_url}/token | jq -r '.access_token')
    echo $access_token
}

view_access_token=$(get_access_token api_view)
create_access_token=$(get_access_token api_create)
publish_access_token=$(get_access_token api_publish)
subscribe_access_token=$(get_access_token subscribe)

# Find "DefaultApplication" ID
echo "Getting DefaultApplication ID"
application_id=$($curl_command -H "Authorization: Bearer $subscribe_access_token" "${base_https_url}/api/am/store/v0.14/applications?query=DefaultApplication" | jq -r '.list[0] | .applicationId')
if [ ! -z $application_id ] && [ ! $application_id = "null" ]; then
    echo "Found application id for \"DefaultApplication\": $application_id"
else
    echo "Failed to find application id for \"DefaultApplication\""
    exit 1
fi

echo -ne "\n"

generate_keys_request() {
    cat <<EOF
{
    "validityTime": "3600",
    "keyType": "PRODUCTION",
    "accessAllowDomains": ["ALL"]
}
EOF
}

echo "Finding Consumer Key for DefaultApplication"
# Generate Keys
keys_response=$($curl_command -H "Authorization: Bearer $subscribe_access_token" -H "Content-Type: application/json" -d "$(generate_keys_request)" "${base_https_url}/api/am/store/v0.14/applications/generate-keys?applicationId=$application_id")
consumer_key=$(echo $keys_response | jq -r '.consumerKey')
if [ ! -z $consumer_key ] && [ ! $consumer_key = "null" ]; then
    echo "Keys generated for \"DefaultApplication\". Consumer key is $consumer_key"
else
    echo "Failed to generate keys for \"DefaultApplication\""
    # Get Key from application
    keys_response=$($curl_command -H "Authorization: Bearer $subscribe_access_token" "${base_https_url}/api/am/store/v0.14/applications/$application_id")
    consumer_key=$(echo $keys_response | jq -r '.keys[0] | .consumerKey')
    if [ ! -z $consumer_key ] && [ ! $consumer_key = "null" ]; then
        echo "Retrieved keys for \"DefaultApplication\". Consumer key is $consumer_key"
    else
        echo "Failed to retrieve keys for \"DefaultApplication\""
        exit 1
    fi
fi

#Write consumer key to file
mkdir -p "$script_dir/target"
echo $consumer_key >"$script_dir/target/consumer_key"

echo -ne "\n"

# Create APIs
api_create_request() {
    cat <<EOF
{
   "name":"$1",
   "description":"$2",
   "context":"/$1",
   "version":"1.0.0",
   "provider":"admin",
   "thumbnailUri":null,
   "apiDefinition":"{\"swagger\":\"2.0\",\"paths\":{\"/*\":{\"post\":{\"responses\":{\"200\":{\"description\":\"\"}},\"parameters\":[{\"name\":\"Payload\",\"description\":\"Request Body\",\"required\":false,\"in\":\"body\",\"schema\":{\"type\":\"object\",\"properties\":{\"payload\":{\"type\":\"string\"}}}}],\"x-auth-type\":\"Application & Application User\",\"x-throttling-tier\":\"Unlimited\"}}},\"info\":{\"title\":\"echo\",\"version\":\"1.0.0.\"}}",
   "wsdlUri":null,
   "responseCaching":"Disabled",
   "cacheTimeout":300,
   "destinationStatsEnabled":null,
   "isDefaultVersion":false,
   "type":"HTTP",
   "transport":[
      "https"
   ],
   "tags":[
      "perf"
   ],
   "tiers":[
      "Unlimited"
   ],
   "apiLevelPolicy":null,
   "authorizationHeader":null,
   "maxTps":null,
   "visibility":"PUBLIC",
   "visibleRoles":[

   ],
   "visibleTenants":[

   ],
   "endpointConfig":"{\"production_endpoints\":{\"url\":\"${backend_endpoint_url}\",\"config\":null},\"sandbox_endpoints\":{\"url\":\"${backend_endpoint_url}\",\"config\":null},\"endpoint_type\":\"${backend_endpoint_type}\"}",
   "endpointSecurity":null,
   "gatewayEnvironments":"Production and Sandbox",
   "labels":[

   ],
   "sequences":[

   ],
   "subscriptionAvailability":null,
   "subscriptionAvailableTenants":[

   ],
   "additionalProperties":{

   },
   "accessControl":"NONE",
   "accessControlRoles":[

   ]
}
EOF
}

mediation_policy_request() {
    cat <<EOF
{
    "name": "mediation-api-sequence",
    "type": "out",
    "config": "$1"
}
EOF
}

subscription_request() {
    cat <<EOF
{
    "tier": "Unlimited",
    "apiIdentifier": "$1",
    "applicationId": "$application_id"
}
EOF
}

create_api() {
    local api_name="$1"
    local api_desc="$2"
    local out_sequence="$3"
    echo "Creating $api_name API..."
    # Check whether API exists
    local existing_api_id=$($curl_command -H "Authorization: Bearer $view_access_token" ${base_https_url}/api/am/publisher/v0.14/apis?query=name:$api_name\$ | jq -r '.list[0] | .id')
    if [ ! -z $existing_api_id ] && [ ! $existing_api_id = "null" ]; then
        echo "$api_name API already exists with ID $existing_api_id"
        echo -ne "\n"
        if (confirm "Delete $api_name API?"); then
            # Check subscriptions first
            local subscription_id=$($curl_command -H "Authorization: Bearer $subscribe_access_token" "${base_https_url}/api/am/store/v0.14/subscriptions?apiId=$existing_api_id" | jq -r '.list[0] | .subscriptionId')
            if [ ! -z $subscription_id ] && [ ! $subscription_id = "null" ]; then
                echo "Subscription found for $api_name API. Subscription ID is $subscription_id"
                # Delete subscription
                local delete_subscription_status=$($curl_command -w "%{http_code}" -o /dev/null -H "Authorization: Bearer $subscribe_access_token" -X DELETE "${base_https_url}/api/am/store/v0.14/subscriptions/$subscription_id")
                if [ $delete_subscription_status -eq 200 ]; then
                    echo "Subscription $subscription_id deleted!"
                    echo -ne "\n"
                else
                    echo "Failed to delete subscription $subscription_id"
                    echo -ne "\n"
                    return
                fi
            else
                echo "No suscriptions found for $api_name API"
                echo -ne "\n"
            fi

            local delete_api_status=$($curl_command -w "%{http_code}" -o /dev/null -H "Authorization: Bearer $create_access_token" -X DELETE "${base_https_url}/api/am/publisher/v0.14/apis/$existing_api_id")
            if [ $delete_api_status -eq 200 ]; then
                echo "$api_name API deleted!"
                echo -ne "\n"
            else
                echo "Failed to delete $api_name API"
                echo -ne "\n"
                return
            fi
        else
            return
        fi
    fi
    local api_id=$($curl_command -H "Authorization: Bearer $create_access_token" -H "Content-Type: application/json" -d "$(api_create_request $api_name $api_desc)" ${base_https_url}/api/am/publisher/v0.14/apis | jq -r '.id')
    if [ ! -z $api_id ] && [ ! $api_id = "null" ]; then
        echo "Created $api_name API with ID $api_id"
        echo -ne "\n"
    else
        echo "Failed to create $api_name API"
        echo -ne "\n"
        return
    fi
    echo "Publishing $api_name API"
    local publish_api_status=$($curl_command -w "%{http_code}" -H "Authorization: Bearer $publish_access_token" -X POST "${base_https_url}/api/am/publisher/v0.14/apis/change-lifecycle?apiId=${api_id}&action=Publish")
    if [ $publish_api_status -eq 200 ]; then
        echo "$api_name API Published!"
        echo -ne "\n"
    else
        echo "Failed to publish $api_name API"
        echo -ne "\n"
        return
    fi
    if [ ! -z "$out_sequence" ]; then
        echo "Adding mediation policy to $api_name API"
        local sequence_id=$($curl_command -H "Authorization: Bearer $create_access_token" -H "Content-Type: application/json" -d "$(mediation_policy_request "$out_sequence")" "${base_https_url}/api/am/publisher/v0.14/apis/${api_id}/policies/mediation" | jq -r '.id')
        if [ ! -z $sequence_id ] && [ ! $sequence_id = "null" ]; then
            echo "Mediation policy added to $api_name API with ID $sequence_id"
            echo -ne "\n"
        else
            echo "Failed to add mediation policy to $api_name API"
            echo -ne "\n"
            return
        fi
        echo "Updating $api_name API to set mediation policy..."
        local api_details=""
        n=0
        until [ $n -ge 50 ]; do
            sleep 10
            #Get API
            api_details="$($curl_command -H "Authorization: Bearer $view_access_token" "${base_https_url}/api/am/publisher/v0.14/apis/${api_id}" || echo "")"
            if [ -n "$api_details" ]; then
                # Update API with sequence
                echo "Updating $api_name API to set mediation policy..."
                api_details=$(echo "$api_details" | jq -r '.sequences |= [{"name":"mediation-api-sequence","type":"out"}]')
                break
            fi
            n=$(($n + 1))
        done
        n=0
        until [ $n -ge 50 ]; do
            sleep 10
            local updated_api="$($curl_command -H "Authorization: Bearer $create_access_token" -H "Content-Type: application/json" -X PUT -d "$api_details" "${base_https_url}/api/am/publisher/v0.14/apis/${api_id}")"
            local updated_api_id=$(echo "$updated_api" | jq -r '.id')
            if [ ! -z $updated_api_id ] && [ ! $updated_api_id = "null" ]; then
                echo "Mediation policy is set to $api_name API with ID $updated_api_id"
                break
            fi
            n=$(($n + 1))
        done
        if [ -z $updated_api_id ] || [ $updated_api_id = "null" ]; then
            echo "Failed to set mediation policy to $api_name API"
            return 1
        fi
    fi
    echo "Subscribing $api_name API to DefaultApplication"
    local subscription_id=$($curl_command -H "Authorization: Bearer $subscribe_access_token" -H "Content-Type: application/json" -d "$(subscription_request $api_id)" "${base_https_url}/api/am/store/v0.14/subscriptions" | jq -r '.subscriptionId')
    if [ ! -z $subscription_id ] && [ ! $subscription_id = "null" ]; then
        echo "Successfully subscribed $api_name API to DefaultApplication. Subscription ID is $subscription_id"
        echo -ne "\n"
    else
        echo "Failed to subscribe $api_name API to DefaultApplication"
        echo -ne "\n"
        return
    fi
}

create_api "$api_name" "$api_description" "$out_sequence"
