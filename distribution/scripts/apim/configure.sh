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
# Configure WSO2 API Manager
# ----------------------------------------------------------------------------

script_dir=$(dirname "$0")
mysql_host=""
mysql_user=""
mysql_password=""
mysql_connector_file=""

function usage() {
    echo ""
    echo "Usage: "
    echo "$0 -m <mysql_host> -u <mysql_user> -p <mysql_password> -c <mysql_connector_file> [-h]"
    echo ""
    echo "-m: Hostname of Mysql Service"
    echo "-u: User of Mysql"
    echo "-p: Password of Mysql"
    echo "-c: Jar file of the Mysql Connector"
    echo "-i: Installed Directory of APIM"
    echo "-h: Display this help and exit."
    echo ""
}

while getopts "m:u:p:c:i:h" opt; do
    case "${opt}" in
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
    echo "Please provide the mysql connector"
    exit 1
fi

validate_command() {
    # Check whether given command exists
    # $1 is the command name
    # $2 is the package containing command
    if ! command -v $1 >/dev/null 2>&1; then
        echo "Please Install $2"
        exit 1
    fi
}

replace_value() {
    echo "Replacing $2 with $3"
    find $1 -type f -exec sed -i -e "s/$2/$3/g" {} \;
}

validate_command mysql mysql-client

if [[ ! -f $mysql_connector_file ]]; then
    echo "Please provide the path to MySQL Connector JAR"
    exit 1
fi

#copy db scripts from api manager to /tmp directory
cp wso2am/dbscripts/apimgt/mysql5.7.sql /tmp/apimgt-mysql5.7.sql
cp wso2am/dbscripts/mysql5.7.sql /tmp/mysql5.7.sql

# Execute Queries
echo "Creating Databases. Please make sure MySQL server 5.7 is installed"
mysql -h $mysql_host -u $mysql_user -p$mysql_password <"$script_dir/sqls/create-databases.sql"

# Copy configurations after replacing values
temp_conf=$(mktemp -d /tmp/apim-conf.XXXXXX)

echo "Copying configs to a temporary directory"
cp -rv $script_dir/conf $temp_conf

replace_value $temp_conf mysql_host $mysql_host
replace_value $temp_conf mysql_user $mysql_user
replace_value $temp_conf mysql_password $mysql_password

apim_path=""
dir=wso2am
apim_path="${dir}"

if [[ -d $apim_path ]]; then
    cp -rv $temp_conf/conf ${apim_path}/repository/
    cp -v $mysql_connector_file ${apim_path}/repository/components/lib/
fi
