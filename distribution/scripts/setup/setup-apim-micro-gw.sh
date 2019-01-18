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
export apim_product=""
export oracle_jdk_dist=""
export micro_gw_dist=""
export os_user=""

function usageCommand() {
    echo "-j <oracle_jdk_dist> -a <apim_product> -m <micro-gw> -n <netty_host> -u <os_user>"
}
export -f usageCommand

function usageHelp() {
    echo "-j: Oracle JDK distribution."
    echo "-a: WSO2 API Manager distribution."
    echo "-m: WSO2 API Manager Micro-GW Distribution."
    echo "-n: The hostname of Netty service."
    echo "-u: General user of the OS."
}
export -f usageHelp

while getopts "gp:w:o:hj:a:m:n:u:" opt; do
    case "${opt}" in
    j)
        oracle_jdk_dist=${OPTARG}
        ;;
    a)
        apim_product=${OPTARG}
        ;;
    m)
        micro_gw_dist=${OPTARG}
        ;;
    n)
        netty_host=${OPTARG}
        ;;
    u)
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
        echo "Please provide the WSO2 API Manager Distribution"
        exit 1
    fi
    if [[ -z $micro_gw_dist ]]; then
        echo "Please provide the WSO2 API Manager Micro Gateway Distribution"
        exit 1
    fi
    if [[ -z $netty_host ]]; then
        echo "Please provide the hostname of Netty Service."
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
    $script_dir/../java/install-java.sh -f $oracle_jdk_dist

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

    # Start API Manager
    sudo -u $os_user $script_dir/../apim/apim-start.sh -m 1G

    # Create APIs in Local API Manager
    sudo -u $os_user $script_dir/../apim/micro-gw/create-apis.sh -a localhost -n $netty_host

    #Extract the Micro-gw zip
    echo "Extracting WSO2 API Manager Micro Gateway"
    sudo -u $os_user unzip -q -o $micro_gw_dist
    sudo -u $os_user mv wso2am-micro* micro-gw
    echo "Micro Gateway is extracted"

    jvm_dir=""
    for dir in /usr/lib/jvm/jdk1.8*; do
        [ -d "${dir}" ] && jvm_dir="${dir}" && break
    done
    export JAVA_HOME="${jvm_dir}"

    #Export the PATH of Micro-GW
    export PATH=$PATH:/home/$os_user/micro-gw/bin

    # setup Micro-GW project
    chmod +x /home/$os_user/apim/micro-gw/create-micro-gw.sh
    /home/$os_user/apim/micro-gw/create-micro-gw.sh

    #build Micro-GW
    micro-gw build echo-mgw

    unzip /home/$os_user/echo-mgw/target/micro-gw-echo-mgw.zip
    chown -R $os_user /home/$os_user

    #start Micro-GW
    sudo -u $os_user /home/$os_user/apim/micro-gw/micro-gw-start.sh

    sudo -u $os_user /home/$os_user/apim/micro-gw/generate-jwt-tokens.sh 1000

    popd
    echo "Completed API Manager setup..."
}
export -f setup

$script_dir/setup-common.sh "${opts[@]}" "$@" -p curl -p jq -p unzip -p expect
