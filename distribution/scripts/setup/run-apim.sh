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


function usageCommand() {
    echo "-n <netty_host> -m <mysql_host> -u <mysql_username> -p <mysql_password> -c <mysql_connectot_url> -a <apim_download_url>"
}
export -f usageCommand

function usageHelp() {
    echo "-n: The hostname of Netty Service."
    echo "-m: The hostname of Mysql service"
    echo "-u: Mysql username"
    echo "-p: Mysql password"
    echo "-c: Mysql connector url"
    echo "-a: The download url of APIM product."
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
}
validate

# Configure WSO2 API Manager
$script_dir/configure.sh -m $mysql_host -u $mysql_user -p $mysql_password -c $HOME/usr/share/java/$mysql_con_jar

# Start API Manager
$script_dir/apim-start.sh

# Create APIs in Local API Manager
$script_dir/create-apis.sh -a localhost -n $netty_host

# Generate tokens
tokens_sql="$script_dir/target/tokens.sql"
if [[ ! -f $tokens_sql ]]; then
   $script_dir/generate-tokens.sh -t 4000
fi

if [[ -f $tokens_sql ]]; then
    mysql -h $mysql_host -u $mysql_user -p$mysql_password apim < $tokens_sql
fi

