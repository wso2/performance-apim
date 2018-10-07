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
netty_host=$1
mysql_host=$2
mysql_user=$3
mysql_password=$4
mysql_connector_jar="$5"

validate() {
    if [[ -z  $1  ]]; then
        echo "Please provide arguments. Example: $0 netty_host mysql_host mysql_user mysql_password mysql_connector_jar"
        exit 1
    fi
}

validate_command() {
    # Check whether given command exists
    # $1 is the command name
    # $2 is the package containing command
    if ! command -v $1 >/dev/null 2>&1; then
        echo "Please install $2 (sudo apt -y install $2)"
        exit 1
    fi
}

validate $netty_host
validate $mysql_host
validate $mysql_user
validate $mysql_password
validate $mysql_connector_jar

#Validate commands
validate_command curl curl
validate_command mysql mysql-client
validate_command jq jq

apim_download_url="https://github.com/wso2/product-apim/releases/download/v2.6.0-rc3/wso2am-2.6.0-rc3.zip"
apim_version="2.6.0"
apim_product="wso2-am-2.6.0"

download_apim()
{
    if [[ ! -f $HOME/apim_installer.zip ]]; then
        echo "Downloading WSO2 API Manager to $HOME"
        wget -q $apim_download_url -O $HOME/apim_installer.zip
        echo "Api Manager Downloaded"
    fi
    if [[ ! -d $HOME/apim_product ]]; then
        echo "Extracting WSO2 API Manager"
        unzip -q $HOME/apim_installer.zip -d $HOME
        echo "API Manager is extracted"
    else
        echo "API Manager is already extracted"
    fi
}
download_apim

# Extract API Manager
if [[ ! -f $apim_path.zip ]]; then
    echo "Please download WSO2 API Manager to $HOME"
    exit 1
fi
if [[ ! -d $apim_path ]]; then
    echo "Extracting WSO2 API Manager"
    unzip -q $apim_path.zip -d $HOME
    echo "API Manager is extracted"
else
    echo "API Manager is already extracted"
    exit 1
fi

# Configure WSO2 API Manager
$script_dir/configure.sh $mysql_host $mysql_user $mysql_password $mysql_connector_jar

# Start API Manager
$script_dir/apim-start.sh

# Create APIs in Local API Manager
$script_dir/create-apis.sh localhost $netty_host

# Generate tokens
tokens_sql="$script_dir/target/tokens.sql"
if [[ ! -f $tokens_sql ]]; then
    $script_dir/generate-tokens.sh 4000
fi

if [[ -f $tokens_sql ]]; then
    mysql -h $mysql_host -u $mysql_user -p$mysql_password apim < $tokens_sql
fi

echo "Completed..."
