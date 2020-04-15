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
# Generate Tokens for WSO2 API Manager
# ----------------------------------------------------------------------------

script_dir=$(dirname "$0")
tokens_count=""

function usage() {
    echo ""
    echo "Usage: "
    echo "$0 -t <tokens_count>"
    echo ""
    echo "-t: Count of the Tokens."
    echo "-h: Display this help and exit."
    echo ""
}

while getopts "t:h" opt; do
    case "${opt}" in
    t)
        tokens_count=${OPTARG}
        ;;
    h)
        usage
        exit 0
        ;;
    \?)
        usage
        exit 1
        ;;
    esac
done
shift "$((OPTIND - 1))"

if [[ -z $tokens_count ]]; then
    echo "Please provide the Token count"
    exit 1
fi

consumer_key_file="$script_dir/target/consumer_key"

if [[ ! -f $consumer_key_file ]]; then
    echo "Couldn't find consumer_key file in target"
    exit 1
fi

consumer_key=$(cat $consumer_key_file)

echo "Using Consumer Key: $consumer_key"

get_random_string() {
    # Get length as the parameter
    local random_string=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w $1 | head -n 1)
    echo "$random_string"
}

mkdir -p "$script_dir/target"
tokens_file="$script_dir/target/tokens.csv"
sql_file="$script_dir/target/tokens.sql"

if [[ -f $tokens_file ]]; then
    mv $tokens_file /tmp
fi
if [[ -f $sql_file ]]; then
    mv $sql_file /tmp
fi

echo "Generating Tokens.........."

for ((c = 1; c <= $tokens_count; c++)); do
    TOKEN_ID="$(get_random_string 36)"
    ACCESS_TOKEN_KEY="$(get_random_string 36)"
    REFRESH_TOKEN_KEY="$(get_random_string 36)"
    TOKEN_SCOPE_HASH="$(get_random_string 32)"
    ACCESS_TOKEN_HASH=$(echo -n $ACCESS_TOKEN_KEY | shasum -a 256 | cut -d " " -f 1)
    REFRESH_TOKEN_HASH==$(echo -n $REFRESH_TOKEN_KEY | shasum -a 256 | cut -d " " -f 1)
    ACCESS_TOKEN_HASH_JSON="{\"hash\":\"$ACCESS_TOKEN_HASH\",\"algorithm\":\"SHA-256\"}"
    REFRESH_TOKEN_HASH_JSON="{\"hash\":\"$ACCESS_TOKEN_HASH\",\"algorithm\":\"SHA-256\"}"

    NOW=$(date +"%Y-%m-%d %H:%M:%S")
    echo "INSERT INTO IDN_OAUTH2_ACCESS_TOKEN (TOKEN_ID, ACCESS_TOKEN, REFRESH_TOKEN, CONSUMER_KEY_ID, AUTHZ_USER, \
        TENANT_ID, USER_DOMAIN, TIME_CREATED, REFRESH_TOKEN_TIME_CREATED, VALIDITY_PERIOD, \
        REFRESH_TOKEN_VALIDITY_PERIOD, TOKEN_SCOPE_HASH, TOKEN_STATE, USER_TYPE, GRANT_TYPE, SUBJECT_IDENTIFIER, \
        ACCESS_TOKEN_HASH,REFRESH_TOKEN_HASH, IDP_ID) \
        SELECT '$TOKEN_ID','$ACCESS_TOKEN_KEY','$REFRESH_TOKEN_KEY',ID,'admin',-1234,'PRIMARY', \
        '$NOW','$NOW',99999999000,99999999000,'$TOKEN_SCOPE_HASH', \
        'ACTIVE','APPLICATION_USER','password','admin@carbon.super','$ACCESS_TOKEN_HASH_JSON', \
        '$REFRESH_TOKEN_HASH_JSON' , 1 \
        FROM IDN_OAUTH_CONSUMER_APPS WHERE CONSUMER_KEY='$consumer_key';" >>$sql_file
    echo INSERT INTO "IDN_OAUTH2_ACCESS_TOKEN_SCOPE (TOKEN_ID, TOKEN_SCOPE, TENANT_ID) \
        VALUES ('$TOKEN_ID','default',-1234);" >>$sql_file
    echo $ACCESS_TOKEN_KEY >>$tokens_file
    echo -ne "Generated Tokens Count: ${c}\r"
done
echo "COMMIT;" >>$sql_file

echo "Token Generation Completed.........."
