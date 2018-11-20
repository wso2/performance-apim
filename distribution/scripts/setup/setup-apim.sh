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
# Setup WSO2 API Manager
# ----------------------------------------------------------------------------

# This script will run all other scripts to configure and setup WSO2 API Manager

# Make sure the script is running as root.
if [ "$UID" -ne "0" ]; then
    echo "You must be root to run $0. Try following"
    echo "sudo $0"
    exit 9
fi

export script_name="$0"
export script_dir=$(dirname "$0")
export netty_host=""
export mysql_host=""
export mysql_user=""
export mysql_password=""
export mysql_connector_file=""
export apim_product=""
export jdk=""
export os_user=""

function usageCommand() {
    echo "-j <oracle_jdk> -a <apim_product> -c <mysql_connector_file> -n <netty_host> -m <mysql_host> -u <mysql_username> -p <mysql_password> -o <os_user>"
}
export -f usageCommand

function usageHelp() {
    echo "-j: Oracle JDK file"
    echo "-a: WSO2 API Manager Product zip"
    echo "-c: MySQL Connector File"
    echo "-n: The hostname of Netty service."
    echo "-m: The hostname of MySQL service."
    echo "-u: MySQL Username."
    echo "-p: MySQL Password."
    echo "-o: General user of the OS."
}
export -f usageHelp

while getopts "gp:w:o:hj:a:c:n:m:u:p:o:" opt; do
    case "${opt}" in
    j)
        jdk=${OPTARG}
        ;;
    a)
        apim_product=${OPTARG}
        ;;
    c)
        mysql_connector_file=${OPTARG}
        ;;
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

function validate() {
    if [[ ! -f $jdk ]]; then
        echo "please download oracle jdk to /home/$os_user"
        exit 1
    fi
    if [[ -z $apim_product ]]; then
        echo "Please provide the apim_product"
        exit 1
    fi
    if [[ ! -f $mysql_connector_file ]]; then
        echo "Please provide the mysql connector file"
        exit 1
    fi
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
    if [[ -z $os_user ]]; then
        echo "Please provide the username of the general os user"
        exit 1
    fi

}
export -f validate

function setup() {
    install_dir=/home/$os_user
    $script_dir/../java/install-java.sh -f $jdk

    pushd ${install_dir}

    #Remove API Manager if it is already there
    if [[ -d wso2am ]]; then
        sudo -u $os_user rm -r wso2am
    fi

    #Extract the downloaded zip
    echo "Extracting WSO2 API Manager"
    sudo -u $os_user unzip -q -o $apim_product
    sudo -u $os_user mv wso2am-* wso2am
    echo "API Manager is extracted"

    # Configure WSO2 API Manager
    sudo -u $os_user $script_dir/../apim/configure.sh -m $mysql_host -u $mysql_user -p $mysql_password -c $mysql_connector_file

    # Start API Manager
    apim_heap_size=2G
    sudo -u $os_user $script_dir/../apim/apim-start.sh -m $apim_heap_size

    # Create APIs in Local API Manager
    sudo -u $os_user $script_dir/../apim/create-apis.sh -a localhost -n $netty_host

    # Generate tokens
    tokens_sql="$script_dir/target/tokens.sql"
    if [[ ! -f $tokens_sql ]]; then
        sudo -u $os_user $script_dir/../apim/generate-tokens.sh -t 4000
    fi

    if [[ -f $tokens_sql ]]; then
        sudo -u $os_user mysql -h $mysql_host -u $mysql_user -p$mysql_password apim <$tokens_sql
    fi

    popd
}
export -f setup

$script_dir/setup-common.sh "${opts[@]}" "$@" -p curl -p jq -p unzip -p mysql-client
echo "Completed..."
