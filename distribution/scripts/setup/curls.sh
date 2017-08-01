#!/bin/bash
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
# Setup API Manager
# ----------------------------------------------------------------------------

apim_host=$1
netty_host=$2

validate() {
    if [[ -z  $1  ]]; then
        echo "Please provide arguments. Example: $0 apim_host netty_host"
        exit 1
    fi
}

validate $apim_host
validate $netty_host

base_https_url="https://${apim_host}:9443"
nio_https_url="https://${apim_host}:8243"

# Add -v to debug
curl_command="curl -sk"

#Check whether jq command exsits
if ! command -v jq >/dev/null 2>&1; then
    echo "Please install jq (sudo apt -y install jq)"
    exit 1
fi

confirm() {
    # call with a prompt string or use a default
    read -r -p "${1:-Are you sure?} [y/N] " response
    case $response in
        [yY][eE][sS]|[yY]) 
            true
            ;;
        *)
            false
            ;;
    esac
}

# Import Users
# cookies_file="$(mktemp /tmp/apim-cookies.XXXXXX)"

# curl -sk -c ${cookies_file} ${base_https_url}/carbon/admin/js/csrfPrevention.js > /dev/null
# csrf_token=$(curl -sik -b ${cookies_file} -X POST -H "FETCH-CSRF-TOKEN: 1" ${base_https_url}/carbon/admin/js/csrfPrevention.js | sed -En 's/^X-CSRF-Token:(.*)/\1/p')
# curl -sk -c ${cookies_file} -b ${cookies_file} -d "username=admin&password=admin&X-CSRF-Token=${csrf_token}" ${base_https_url}/carbon/admin/login_action.jsp > /dev/null
# curl -sk -b ${cookies_file} -F "userStore=PRIMARY" -F "usersFile=@users.csv" ${base_https_url}/carbon/user/bulk-import-finish-ajaxprocessor.jsp?X-CSRF-Token=${csrf_token} > /dev/null

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

client_credentials=$($curl_command -u admin:admin -H "Content-Type: application/json" -d "$(client_request)" ${base_https_url}/client-registration/v0.11/register | jq -r '.clientId + ":" + .clientSecret')

get_access_token() {
    local access_token=$($curl_command -d "grant_type=password&username=admin&password=admin&scope=apim:api_$1" -u $client_credentials ${nio_https_url}/token | jq -r '.access_token')
    echo $access_token
}

view_access_token=$(get_access_token view)
create_access_token=$(get_access_token create)
publish_access_token=$(get_access_token publish)

# Create APIs
api_create_request() {
    cat <<EOF
{
   "name": "$1",
   "description": "$2",
   "context": "/$1",
   "version": "1.0.0",
   "provider": "admin",
   "apiDefinition": "{\"swagger\":\"2.0\",\"paths\":{\"\/*\":{\"post\":{\"responses\":{\"200\":{\"description\":\"\"}},\"parameters\":[{\"name\":\"Payload\",\"description\":\"Request Body\",\"required\":false,\"in\":\"body\",\"schema\":{\"type\":\"object\",\"properties\":{\"payload\":{\"type\":\"string\"}}}}]}}},\"info\":{\"title\":\"$1\",\"version\":\"1.0.0.\"}}",
   "isDefaultVersion": false,
   "type": "HTTP",
   "transport":    [
      "https"
   ],
   "tags": ["perf"],
   "tiers": ["Unlimited"],
   "visibility": "PUBLIC",
   "endpointConfig": "{\"production_endpoints\":{\"url\":\"http://${netty_host}:8688/\",\"config\":null},\"sandbox_endpoints\":{\"url\":\"http://${netty_host}:8688/\",\"config\":null},\"endpoint_type\":\"http\"}",
   "gatewayEnvironments": "Production and Sandbox"
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

create_api() {
    local api_name="$1"
    local api_desc="$2"
    local out_sequence="$3"
    # Check whether API exists
    local exisiting_api_id=$($curl_command -H "Authorization: Bearer $view_access_token" ${base_https_url}/api/am/publisher/v0.11/apis?query=name:$api_name\$ | jq -r '.list[0] | .id')
    if [ ! -z  $exisiting_api_id ]; then
        echo "$api_name API already exists with ID $exisiting_api_id"
        if (confirm "Delete $api_name API?"); then
            local delete_api_status=$($curl_command -w "%{http_code}" -H "Authorization: Bearer $create_access_token" -X DELETE  ${base_https_url}/api/am/publisher/v0.11/apis/$exisiting_api_id)
            if [ $delete_api_status -eq 200 ]; then
                echo "$api_name API deteled!"
            else
                echo "Failed to delete $api_name API"
                return
            fi
        else
            return
        fi
    fi
    local api_id=$($curl_command -H "Authorization: Bearer $create_access_token" -H "Content-Type: application/json" -d "$(api_create_request $api_name $api_desc)" ${base_https_url}/api/am/publisher/v0.11/apis | jq -r '.id')
    if [ ! -z $api_id ] && [ ! $api_id = "null" ]; then
        echo "Created $api_name API with ID $api_id"
    else
        echo "Failed to create $api_name API"
        return
    fi 
    echo "Publishing $api_name API"
    local publish_api_status=$($curl_command -w "%{http_code}" -H "Authorization: Bearer $publish_access_token" -X POST "${base_https_url}/api/am/publisher/v0.11/apis/change-lifecycle?apiId=${api_id}&action=Publish")
    if [ $publish_api_status -eq 200 ]; then
        echo "$api_name API Published!"
    else
        echo "Failed to publish $api_name API"
        return
    fi
    if [ ! -z "$out_sequence" ] ; then
        echo "Adding mediation policy"
        local sequence_id=$($curl_command -H "Authorization: Bearer $create_access_token" -H "Content-Type: application/json" -d "$(mediation_policy_request "$out_sequence")" "${base_https_url}/api/am/publisher/v0.11/apis/${api_id}/policies/mediation"  | jq -r '.id')
        if [ ! -z $sequence_id ]; then
            echo "Mediation policy added to $api_name API with ID $sequence_id"
        else
            echo "Failed to add mediation policy to $api_name API"
            return
        fi 
    fi
}

mediation_out_sequence() {
   cat <<EOF
<sequence xmlns=\"http://ws.apache.org/ns/synapse\" name=\"mediation-api-sequence\">
 <payloadFactory media-type=\"json\">
 <format>
{\"payload\":\"\$1\",\"size\":\"\$2\"}
</format>
 <args>
 <arg expression=\"\$.payload\" evaluator=\"json\"></arg>
 <arg expression=\"\$.size\" evaluator=\"json\"></arg>
 </args>
 </payloadFactory>
</sequence>
EOF
}

create_api "echo" "Echo API"
echo -ne "\n"
create_api "mediation" "Mediation API" "$(mediation_out_sequence | tr -d "\n\r")"
