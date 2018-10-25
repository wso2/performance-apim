#!/bin/bash -e
# Copyright 2018 WSO2 Inc. (http://wso2.org)
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

# Make sure the script is running as root.
script_name="$0"
script_dir=$(dirname "$0")
netty_host=""
mysql_host=""
mysql_user=""
mysql_password=""
mysql_connector_file=""
apim_product=""
jdk=""
os_user=""

function usageCommand() {
    echo "-n <netty_host> -m <mysql_host> -u <mysql_username> -p <mysql_password> -c <mysql_connector_file> -a <apim_product> -j oracle jdk -o normal os user(eg: ubuntu)"
}
export -f usageCommand

function usageHelp() {
    echo "-n: The hostname of Netty Service."
    echo "-m: The hostname of Mysql service"
    echo "-u: Mysql username"
    echo "-p: Mysql password"
    echo "-c: Mysql Connector File"
    echo "-a: Apim Product zip"
    echo "-j: Oracle Jdk file"
    echo "-o: General user of the OS"
}
export -f usageHelp

while getopts "n:m:u:p:c:a:w:gp" opt; do
    case "${opt}" in
    n)
        netty_host=${OPTARG}
        ;;
    m)
        mysql_host=${OPTARG}
        ;;
    u)
        mysql_user=${OPTARG}
        ;;
    p)
        mysql_password=${OPTARG}
        ;;
    c)
        mysql_connector_file=${OPTARG}
        ;;
    a)
        apim_product=${OPTARG}
        ;;
    j)
        jdk=${OPTARG}
        ;;
    o)
        os_user=${OPTARG}
        ;;
    *)
        opts+=("-${opt}")
        [[ -n "$OPTARG" ]] && opts+=("$OPTARG")
        ;;
    esac
done
shift "$((OPTIND - 1))"

function validate()
{
    if [[ -z $netty_host ]]; then
        echo "Please provide the hostname of Netty Service."
        exit 1
    fi
    if [[ -z $mysql_host ]]; then
        echo "Please provide the hostname of mysql host"
        exit 1
    fi
    if [[ -z $mysql_user ]]; then
        echo "Please provide the mysql username"
        exit 1
    fi
    if [[ -z $mysql_password ]]; then
        echo "Please provide the mysql password"
        exit 1
    fi
    if [[ -z $mysql_connector_file ]]; then
        echo "Please provide the mysql connector file"
        exit 1
    fi
    if [[ -z $apim_product ]]; then
        echo "Please provide the apim_product"
        exit 1
    fi
    if [[ -z $os_user ]]; then
        echo "Please provide the username of the general os user"
        exit 1
    fi
    if [[ ! -f $HOME/$jdk ]]; then
        echo "please download oracle jdk to $HOME"
    fi
}
export -f validate

HOME=/home/$os_user

apim_extracted_file="wso2am"
function setup()
{
    $script_dir/../java/install-java.sh -f $HOME/$jdk

    #Remove apim product unzipped product if it is already there
    if [[ -d $HOME/$apim_extracted_file ]]; then
    #TODO: user should be an option
     sudo -u $os_user rm -r $HOME/$apim_extracted_file
    fi

    #Extract the downloaded zip
    echo "Extracting WSO2 API Manager"
    sudo -u $os_user unzip -o $HOME/$apim_product -d $HOME
    sudo -u $os_user mv $HOME/wso2am-* $HOME/wso2am
    echo "API Manager is extracted"

    # Configure WSO2 API Manager
    sudo -u $os_user $script_dir/configure.sh -m $mysql_host -u $mysql_user -p $mysql_password -c $HOME/$mysql_connector_file

    # Start API Manager
    sudo -u $os_user $script_dir/apim-start.sh

    # Create APIs in Local API Manager
    sudo -u $os_user $script_dir/create-apis.sh -a localhost -n $netty_host

    # Generate tokens
    tokens_sql="$script_dir/target/tokens.sql"
    if [[ ! -f $tokens_sql ]]; then
        sudo -u $os_user $script_dir/generate-tokens.sh -t 4000
    fi

    if [[ -f $tokens_sql ]]; then
        sudo -u $os_user mysql -h $mysql_host -u $mysql_user -p$mysql_password apim < $tokens_sql
    fi
}
export -f setup

$script_dir/setup-common.sh "${opts[@]}" "$@" -p curl -p jq -p unzip -p mysql-client
echo "Completed..."