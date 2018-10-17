#!/bin/bash
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
if [ "$UID" -ne "0" ]; then
    echo "You must be root to run $0. Try following"
    echo "sudo $0"
    exit 9
fi

script_name="$0"
script_dir=$(dirname "$0")
netty_host=""
mysql_host=""
mysql_user=""
mysql_password=""
mysql_connector_url=""
apim_download_url=""

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
    c)
        mysql_connector_url=${OPTARG}
        ;;
    a)
        apim_download_url=${OPTARG}
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
    if [[ -z $mysql_connector_url ]]; then
        echo "Please provide the url to download mysql connector"
        exit 1
    fi
    if [[ -z $apim_download_url ]]; then
        echo "Please provide the url to download Api Manager"
        exit 1
    fi
}
export -f validate

echo $script_dir
jdk_zip="jdk-8u181-linux-x64.tar.gz"
install_java()
{
    if [[ -f $HOME/$jdk_zip ]]; then
        $script_dir/../java/install-java.sh -f $HOME/$jdk_zip
    else
        echo "please download oracle jdk to $HOME"
    fi
}
install_java

mysql_con_jar="mysql-connector-java-8.0.12.jar"
setup_mysql_connector()
{
    if [[ ! -f $HOME/mysql_connector.deb ]]; then
        echo "Downloading mysql connector"
        wget -q $mysql_connector_url -O $HOME/mysql_connector.deb
    fi

    if [[ ! -d $HOME/usr/share/java/$mysql_con_jar ]]; then
        echo "Extracting Mysql connector"
        dpkg -x $HOME/mysql_connector.deb $HOME
        echo "Mysql connector is extracted"
    else
        echo "Mysql Connector is already extracted"
    fi
}

apim_product="wso2am"
function setup()
{
    apt -y install curl
    apt -y install mysql-client
    apt -y install jq
    apt -y install unzip
    apt -y install dpkg

    #download apim zip , if the zip is not available
    if [[ ! -f $HOME/apim_installer.zip ]]; then
        echo "Downloading WSO2 API Manager to $HOME"
        wget -q $apim_download_url -O $HOME/apim_installer.zip
        echo "Api Manager Downloaded"
    fi

    #Remove apim product unzipped product if it is already there
    if [[ -d $HOME/$apim_product ]]; then
        rm -r $HOME/$apim_product
    fi

    #Extract the downloaded zip
    echo "Extracting WSO2 API Manager"
    unzip -o $HOME/apim_installer.zip -d $HOME
    mv $HOME/wso2am-* $HOME/wso2am
    echo "API Manager is extracted"

    $(setup_mysql_connector)
}
export -f setup



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

$script_dir/setup-common.sh "${opts[@]}" "$@"

echo "Completed..."
