#!/bin/bash -e
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
# Setup WSO2 API Manager With Micro Gateway
# ----------------------------------------------------------------------------

# This script will run all other scripts to configure and setup WSO2 API Manager with Micro Gateway

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
export micro_gw_product=""
export oracle_jdk_dist=""
export os_user=""

function usageCommand() {
    echo "-j <oracle_jdk_dist> -a <apim_product> -k <micro_gw_product> -c <mysql_connector_file> -n <netty_host> -m <mysql_host> -u <mysql_username> -p <mysql_password> -b <os_user>"
}
export -f usageCommand

function usageHelp() {
    echo "-j: Oracle JDK distribution."
    echo "-a: WSO2 API Manager distribution."
    echo "-k: WSO2 API Microgateway distribution."
    echo "-c: MySQL Connector JAR file."
    echo "-n: The hostname of Netty service."
    echo "-m: The hostname of MySQL service."
    echo "-u: MySQL Username."
    echo "-p: MySQL Password."
    echo "-b: General user of the OS."
}
export -f usageHelp

while getopts "gp:w:o:hj:a:k:c:n:m:u:p:b:" opt; do
    case "${opt}" in
    j)
        oracle_jdk_dist=${OPTARG}
        ;;
    a)
        apim_product=${OPTARG}
        ;;
    k)
        micro_gw_product=${OPTARG}
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
    b)
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
    if [[ ! -f $oracle_jdk_dist ]]; then
        echo "Please download Oracle JDK."
        exit 1
    fi
    if [[ -z $apim_product ]]; then
        echo "Please provide the WSO2 API Manager Distribution."
        exit 1
    fi
    if [[ -z $micro_gw_product ]]; then
        echo "Please provide the API Microgateway Distribution."
        exit 1
    fi
    if [[ ! -f $mysql_connector_file ]]; then
        echo "Please provide the MySQL connector file."
        exit 1
    fi
    if [[ -z $netty_host ]]; then
        echo "Please provide the hostname of Netty Service."
        exit 1
    fi
    if [[ -z $mysql_host ]]; then
        echo "Please provide the hostname of MySQL host."
        exit 1
    fi
    if [[ -z $mysql_user ]]; then
        echo "Please provide the MySQL username."
        exit 1
    fi
    if [[ -z $mysql_password ]]; then
        echo "Please provide the MySQL password."
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
    $script_dir/../java/install-java.sh -f $oracle_jdk_dist -u $os_user

    #install docker
    $script_dir/../docker/install-docker.sh -u $os_user

    pushd ${install_dir}

    #Remove API Manager if it is already there
    if [[ -d wso2am ]]; then
        sudo -u $os_user rm -r wso2am
    fi

    #Extract the downloaded zip
    echo "Extracting WSO2 API Manager"
    apim_dirname=$(unzip -Z -1 $apim_product | head -1 | sed -e 's@/.*@@')
    sudo -u $os_user unzip -q -o $apim_product
    sudo -u $os_user mv -v $apim_dirname wso2am
    echo "API Manager is extracted"

    # Configure WSO2 API Manager
    sudo -u $os_user $script_dir/../apim/configure.sh -m $mysql_host -u $mysql_user -p $mysql_password -c $mysql_connector_file

    # Start API Manager
    sudo -u $os_user $script_dir/../apim/apim-start.sh -m 1G

    # Create APIs in Local API Manager
    sudo -u $os_user $script_dir/../apim/create-api.sh -a localhost -n "echo" -d "Echo API" -b "http://${netty_host}:8688/"

    #Extract the Micro-gw zip
    echo "Extracting WSO2 API Manager Micro Gateway"
    mgw_dirname=$(unzip -Z -1 $micro_gw_product | head -1 | sed -e 's@/.*@@')
    sudo -u $os_user unzip -q -o $micro_gw_product
    sudo -u $os_user mv -v $mgw_dirname micro-gw
    echo "Micro Gateway is extracted"

    #todo: change the scripts to support APIM latest version
    #Copy toolkit-config.toml file to support APIM 2.6.0
    # cp $script_dir/../apim/micro-gw/toolkit-config.toml $PWD/micro-gw/conf/toolkit-config.toml

    jvm_dir=""
    for dir in /usr/lib/jvm/jdk1.8*; do
        [ -d "${dir}" ] && jvm_dir="${dir}" && break
    done
    export JAVA_HOME="${jvm_dir}"

    #Export the PATH of Micro-GW
    export PATH=$PATH:$PWD/micro-gw/bin

    #initialize Micro-GW project
    micro-gw init echo-mgw -f

    #import Micro-GW project
    ./apim/micro-gw/create-micro-gw.sh

    #build Micro-GW
    micro-gw build echo-mgw

    #create empty file to avoid permission issues
    touch /home/ubuntu/micro-gw.conf
    chmod a+rw /home/ubuntu/micro-gw.conf

    #start Micro-GW
    sudo -u $os_user ./apim/micro-gw/micro-gw-start.sh -m 512m -n echo-mgw -c 1

    #Generate jwt-tokens
    sudo -u $os_user ./apim/generate-jwt-tokens.sh -t 1000 -a jwt-tokens.csv

    # Generate oauth2 access tokens
    tokens_sql="$script_dir/../apim/target/tokens.sql"
    if [[ ! -f $tokens_sql ]]; then
        sudo -u $os_user $script_dir/../apim/generate-tokens.sh -t 4000
    fi

    gen_tokens_sql="$script_dir/../apim/target/tokens.sql"
    if [[ -f $gen_tokens_sql ]]; then
        mysql -h $mysql_host -u $mysql_user -p$mysql_password apim < $gen_tokens_sql
    else
        echo "SQL file with generated tokens not found."
        exit 1
    fi

    popd
    echo "Completed API Micro-Gateway setup..."
}
export -f setup

$script_dir/setup-common.sh "${opts[@]}" "$@" -p curl -p jq -p unzip -p expect -p mysql-client
