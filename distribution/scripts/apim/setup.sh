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
# Setup WSO2 API Manager
# ----------------------------------------------------------------------------

# This script will run all other scripts to configure and setup WSO2 API Manager

script_dir=$(dirname "$0")
apim_host=$1
netty_host=$2
mysql_host=$3
mysql_user=$4
mysql_password=$5
mysql_connector_jar="$6"

validate() {
    if [[ -z  $1  ]]; then
        echo "Please provide arguments. Example: $0 apim_host netty_host mysql_host mysql_user mysql_pw mysql_connector_jar"
        exit 1
    fi
}

validate $apim_host
validate $netty_host
validate $mysql_host
validate $mysql_user
validate $mysql_password
validate $mysql_connector_jar

apim_path="$HOME/wso2am-2.1.0"

# Extract API Manager
if [[ ! -f $apim_path.zip ]]; then
    echo "Please download WSO2 API Manager to $HOME"
    exit 1
fi
if [[ ! -d $apim_path ]]; then
    echo "Extracting WSO2 API Manager"
    unzip -q $apim_path.zip
    echo "API Manager is extracted"
else
    echo "API Manager is already extracted"
    exit 1
fi

# Configure WSO2 API Manager
$script_dir/configure.sh $mysql_host $mysql_user $mysql_pw $mysql_connector_jar

# Start API Manager
$script_dir/apim_start.sh

# Create APIs
$script_dir/create_apis.sh

# Generate tokens
if [[ ! -f "$script_dir/target/tokens.sql" ]]; then
    $script_dir/generate_tokens.sh 4000
    mysql -h $mysql_host -u $mysql_user -p$mysql_password apim < "$script_dir/target/tokens.sql"
fi
