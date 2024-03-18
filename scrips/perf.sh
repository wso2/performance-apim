#!/bin/bash -e
# Copyright 2024 WSO2 LLC. (http://wso2.org)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

apim_host=$1
backend_host=$2

curl_command="curl -sk"
base_https_url="https://${apim_host}:9443"
scopes="apim:admin apim:api_create apim:api_delete apim:api_generate_key apim:api_import_export apim:api_product_import_export apim:api_publish apim:api_view apim:app_import_export apim:client_certificates_add apim:client_certificates_update apim:client_certificates_view apim:comment_view apim:comment_write apim:document_create apim:document_manage apim:ep_certificates_add apim:ep_certificates_update apim:ep_certificates_view apim:mediation_policy_create apim:mediation_policy_manage apim:mediation_policy_view apim:common_operation_policy_manage apim:pub_alert_manage apim:publisher_settings apim:shared_scope_manage apim:subscription_block apim:subscription_view apim:threat_protection_policy_create apim:threat_protection_policy_manage openid service_catalog:service_view service_catalog:service_write apim:subscribe apim:app_manage"
backend_endpoint_url="ws://${backend_host}:8888/ws"
api_name="echoAPI"


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
    "callbackUrl":"www.google.lk",
    "clientName":"rest_api_publisher",
    "owner":"admin",
    "grantType":"client_credentials password refresh_token",
    "saasApp":true
}
EOF
}

app_request() {
    cat <<EOF
{ 
   "name":"PerformanceTestAPP",
   "throttlingPolicy":"Unlimited",
   "description":"PerformanceTestAPP",
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
   "additionalProperties":{ 
      "application_access_token_expiry_time":"999999",
      "user_access_token_expiry_time":"999999"
   },
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

# Websocket API payload
api_create_request() {
    cat <<EOF
{ 
   "name":"${api_name}",
   "description":"echo API",
   "context":"echoapi",
   "version":"1.0.0",
   "provider":"admin",
   "type":"WS",
   "policies":[ 
      "AsyncUnlimited"
   ],
   "endpointConfig":{ 
      "endpoint_type":"ws",
      "sandbox_endpoints":{ 
         "url":"${backend_endpoint_url}"
      },
      "production_endpoints":{ 
         "url":"${backend_endpoint_url}"
      }
   },
   "operations":[ 
      { 
         "target":"/*",
         "verb":"SUBSCRIBE",
         "throttlingPolicy":"Unlimited"
      },
      { 
         "target":"/*",
         "verb":"PUBLISH",
         "throttlingPolicy":"Unlimited"
      }
   ]
}
EOF
}

subscription_request() {
    cat <<EOF
{ 
   "apiId":"$1",
   "applicationId":"$application_id",
   "throttlingPolicy":"AsyncUnlimited"
}
EOF
}

token_request() {
    cat <<EOF
{ 
   "grantType":"client_credentials",
}
EOF
}


client_credentials=$($curl_command -u admin:admin -H "Content-Type: application/json" -d "$(client_request)" ${base_https_url}/client-registration/v0.17/register | jq -r '.clientId + ":" + .clientSecret')

echo "client_credentials: $client_credentials"


access_token=$($curl_command -u $client_credentials -d "grant_type=password&username=admin&password=admin&scope=${scopes}" ${base_https_url}/oauth2/token | jq -r '.access_token')

echo "access_token: $access_token"

echo "Getting PerformanceTestAPP ID"
application_id=$($curl_command -H "Authorization: Bearer $access_token" "${base_https_url}/api/am/devportal/v3/applications?query=PerformanceTestAPP" | jq -r '.list[0] | .applicationId')

if [ ! -z $application_id ] && [ ! $application_id = "null" ]; then
    echo "Found application id for \"PerformanceTestAPP\": $application_id"
else
    echo "Creating \"PerformanceTestAPP\" application"
    application_id=$($curl_command -X POST -H "Authorization: Bearer $access_token" -H "Content-Type: application/json" -d "$(app_request)" "${base_https_url}/api/am/devportal/applications" | jq -r '.applicationId')
    if [ ! -z $application_id ] && [ ! $application_id = "null" ]; then
        echo "Found application id for \"PerformanceTestAPP\": $application_id"
    else
        echo "Failed to find application id for \"PerformanceTestAPP\""
        exit 1
    fi
fi

keys_response=$($curl_command -H "Authorization: Bearer $access_token" "${base_https_url}/api/am/devportal/v3/applications/$application_id/keys/PRODUCTION")
consumer_key=$(echo $keys_response | jq -r '.consumerKey')
consumer_secret=$(echo $keys_response | jq -r '.consumerSecret')
if [ ! -z $consumer_key ] && [ ! $consumer_key = "null" ]; then
    echo "Keys already generated for \"PerformanceTestAPP\". Consumer key is $consumer_key"
else
    echo "Keys not generated for \"PerformanceTestAPP\". Generating keys"
    # temp fix
    get_keymanager=$($curl_command -H "Authorization: Bearer $access_token" "${base_https_url}/api/am/devportal/v3/key-managers")

    # Generate Keys
    keys_response=$($curl_command -H "Authorization: Bearer $access_token" -H "Content-Type: application/json" -d "$(generate_keys_request)" "${base_https_url}/api/am/devportal/v3/applications/$application_id/generate-keys")
    consumer_key=$(echo $keys_response | jq -r '.consumerKey')
    consumer_secret=$(echo $keys_response | jq -r '.consumerSecret')
    if [ ! -z $consumer_key ] && [ ! $consumer_key = "null" ]; then
        echo "Keys generated for \"PerformanceTestAPP\". Consumer key is $consumer_key"
    else
        echo "Failed to generate keys for \"PerformanceTestAPP\""
        # Get Key from application
        keys_response=$($curl_command -H "Authorization: Bearer $access_token" "${base_https_url}/api/am/devportal/v3/applications/$application_id")
        consumer_key=$(echo $keys_response | jq -r '.keys[0] | .consumerKey')
        consumer_secret=$(echo $keys_response | jq -r '.consumerSecret')
        if [ ! -z $consumer_key ] && [ ! $consumer_key = "null" ]; then
            echo "Retrieved keys for \"PerformanceTestAPP\". Consumer key is $consumer_key"
        else
            echo "Failed to retrieve keys for \"PerformanceTestAPP\""
            exit 1
        fi
    fi
fi

echo "consumer_key: $consumer_key"
echo "consumer_secret: $consumer_secret"
token_creds=$(echo -n $consumer_key:$consumer_secret | base64)
echo "token_creds: $token_creds"

existing_api_id=$($curl_command -H "Authorization: Bearer $access_token" ${base_https_url}/api/am/publisher/v4/apis?query=name:$api_name | jq -r '.list[0] | .id')
if [ ! -z $existing_api_id ] && [ ! $existing_api_id = "null" ]; then
    echo "$api_name API already exists with ID $existing_api_id"
    echo -ne "\n"
    if (confirm "Delete $api_name API?"); then
        # Check subscriptions first
        subscription_id=$($curl_command -H "Authorization: Bearer $access_token" "${base_https_url}/api/am/devportal/v3/subscriptions?apiId=$existing_api_id" | jq -r '.list[0] | .subscriptionId')
        if [ ! -z $subscription_id ] && [ ! $subscription_id = "null" ]; then
            echo "Subscription found for $api_name API. Subscription ID is $subscription_id"
            # Delete subscription
            delete_subscription_status=$($curl_command -w "%{http_code}" -o /dev/null -H "Authorization: Bearer $access_token" -X DELETE "${base_https_url}/api/am/devportal/v3/subscriptions/$subscription_id")
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

        delete_api_status=$($curl_command -w "%{http_code}" -o /dev/null -H "Authorization: Bearer $access_token" -X DELETE "${base_https_url}/api/am/publisher/v4/apis/$existing_api_id")
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

api_id=$($curl_command -H "Authorization: Bearer $access_token" -H "Content-Type: application/json" -d "$(api_create_request)" ${base_https_url}/api/am/publisher/v4/apis | jq -r '.id')

echo "api_id: $api_id"

rev_id=$($curl_command -H "Authorization: Bearer $access_token" -H "Content-Type: application/json" -X POST -d '{"description": "first revision"}' ${base_https_url}/api/am/publisher/v4/apis/${api_id}/revisions | jq -r '.id')
revisionUuid=$($curl_command -H "Authorization: Bearer $access_token" -H "Content-Type: application/json" -X POST -d '[{"name": "Default", "vhost": "localhost" ,"displayOnDevportal": true}]' ${base_https_url}/api/am/publisher/v4/apis/${api_id}/deploy-revision?revisionId=${rev_id} | jq -r '.[0] | .revisionUuid')

publish_api_status=$($curl_command -w "%{http_code}" -o /dev/null -H "Authorization: Bearer $access_token" -X POST "${base_https_url}/api/am/publisher/v4/apis/change-lifecycle?action=Publish&apiId=${api_id}")
if [ $publish_api_status -eq 200 ]; then
    echo "Echo API Published!"
    echo -ne "\n"
fi

subscription_id=$($curl_command -H "Authorization: Bearer $access_token" -H "Content-Type: application/json" -d "$(subscription_request $api_id)" "${base_https_url}/api/am/devportal/v3/subscriptions" | jq -r '.subscriptionId')
if [ ! -z $subscription_id ] && [ ! $subscription_id = "null" ]; then
    echo "Successfully subscribed $api_name API to PerformanceTestAPP. Subscription ID is $subscription_id"
    echo -ne "\n"
fi

gateway_token=$($curl_command -H "Authorization: Basic $token_creds" -d "grant_type=client_credentials" "${base_https_url}/oauth2/token" | jq -r '.access_token')
echo "gateway_token: $gateway_token"
