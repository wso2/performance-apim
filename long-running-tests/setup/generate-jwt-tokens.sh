#!/bin/bash
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
# Generate JWT Tokens
# ----------------------------------------------------------------------------

script_dir=$(dirname "$0")
apim_host=""
tokens_count=""
consumer_key=""
tokens_file=""
jwt_tokens_file=""
client_keys_file=""

function usage() {
    echo ""
    echo "Usage: "
    echo "$0 -a <apim_host> -t <tokens_count>"
    echo ""
    echo "-a: Hostname of WSO2 API Manager."
    echo "-t: Count of the tokens."
    echo "-h: Display this help and exit."
    echo ""
}

while getopts "a:t:h" opt; do
    case "${opt}" in
    a)
        apim_host=${OPTARG}
        ;;
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

jwt_tokens_file="$script_dir/target/jwt_tokens.csv"
echo -n "" > $jwt_tokens_file

client_keys_file="$script_dir/target/client_credentials.csv"

if [[ ! -f $client_keys_file ]]; then
    echo "Couldn't find client_keys file in target"
    exit 1
fi

while IFS=, read -r consumer_key consumer_secret
do
    tokens_file="$script_dir/target/jwt_tokens_$consumer_key.csv"
    generate_tokens_command="java -Xms128m -Xmx128m -jar $script_dir/token-generation-artifacts/jwt-generator-0.1.1-SNAPSHOT.jar \
        --key-store-file $script_dir/token-generation-artifacts/wso2carbon.jks --consumer-key $consumer_key\
        --tokens-count $tokens_count --output-file $tokens_file --apim-host $apim_host"
    echo "Generating Tokens: $generate_tokens_command"
    $generate_tokens_command
    cat $tokens_file >> $jwt_tokens_file
    rm $tokens_file
done < $client_keys_file


