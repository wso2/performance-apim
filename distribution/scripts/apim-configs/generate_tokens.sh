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
# Generate Tokens for WSO2 API Manager
# ----------------------------------------------------------------------------

tokens_count=$1

if [[ -z  $tokens_count  ]]; then
    echo "Please specify the number of tokens to generate. Example: $0 tokens_count"
    exit 1
fi

get_random_string() {
    # Get length as the parameter
    local random_string=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w $1 | head -n 1)
    echo "$random_string"
}

get_token() {
    local token=$(echo "$(get_random_string 8)-$(get_random_string 4)-$(get_random_string 4)-$(get_random_string 4)-$(get_random_string 12)")
    echo "$token"
}

mkdir -p target
tokens_file="target/tokens.csv"
sql_file="target/tokens.sql"

echo "Genearating Tokens.........."

for (( c=1; c <= $tokens_count; c++ ))
do
    TOKEN_ID="$(get_token)"
    ACCESS_TOKEN_KEY="$(get_token)"
    REFRESH_TOKEN_KEY="$(get_token)"
    AUTHZ_USER="$(get_random_string 6)"
    TOKEN_SCOPE_HASH="$(get_random_string 32)"
    NOW=$(date +"%Y-%m-%d %H:%M:%S")
    echo INSERT INTO "IDN_OAUTH2_ACCESS_TOKEN (TOKEN_ID, ACCESS_TOKEN, REFRESH_TOKEN, CONSUMER_KEY_ID, AUTHZ_USER, \
        TENANT_ID, USER_DOMAIN, TIME_CREATED, REFRESH_TOKEN_TIME_CREATED, VALIDITY_PERIOD, \
        REFRESH_TOKEN_VALIDITY_PERIOD, TOKEN_SCOPE_HASH, TOKEN_STATE, USER_TYPE, GRANT_TYPE, SUBJECT_IDENTIFIER) \
        VALUES ('$TOKEN_ID','$ACCESS_TOKEN_KEY','$REFRESH_TOKEN_KEY',1,'$AUTHZ_USER',-1234,'PRIMARY', \
        '$NOW','$NOW',99999999000,99999999000,'$TOKEN_SCOPE_HASH', \
        'ACTIVE','APPLICATION_USER','password',NULL);" >> $sql_file
    echo INSERT INTO "IDN_OAUTH2_ACCESS_TOKEN_SCOPE (TOKEN_ID, TOKEN_SCOPE, TENANT_ID) \
        VALUES ('$TOKEN_ID','default',-1234);" >> $sql_file
    echo $ACCESS_TOKEN_KEY >> $tokens_file
    echo -ne "Generated Tokens Count: ${c}\r"
done

echo "Token Genearation Completed.........."
