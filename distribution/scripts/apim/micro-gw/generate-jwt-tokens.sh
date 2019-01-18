#!/bin/bash
# Copyright 2019 WSO2 Inc. (http://wso2.org)
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
tokens_count=$1

validate() {
    if [[ -z  $1  ]]; then
        echo "Please provide arguments. Example: $0 tokens_count"
        exit 1
    fi
}

validate $tokens_count

mkdir -p "$script_dir/target"
tokens_file="$script_dir/target/jwt-tokens.csv"

if [[ -f $tokens_file ]]; then
    mv $tokens_file /tmp
fi

echo "Generating Tokens.........."

for (( c=1; c <= $tokens_count; c++ ))
do
	JWT_TOKEN=$(java -jar /home/ubuntu/jwt-generator/org.wso2.am.microgw.jwt-generator-1.0.0-jar-with-dependencies.jar "echo" "/echo" "1.0.0" "DefaultApplication" "Unlimited" "Unlimited" 1)
    echo $JWT_TOKEN >> $tokens_file
    echo -ne "Generated Tokens Count: ${c}\r"
done

echo "Token Generation Completed.........."