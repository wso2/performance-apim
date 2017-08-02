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
mysql_host=$1
mysql_user=$2
mysql_password=$3
mysql_connector_jar="$4"

validate() {
    if [[ -z  $1  ]]; then
        echo "Please provide arguments. Example: $0 mysql_host mysql_user mysql_pw mysql_connector_jar"
        exit 1
    fi
}

replace_value() {
    echo "Replacing $2 with $3"
    find $1 -type f -exec sed -i -e "s/$2/$3/g" {} \;
}

validate $mysql_host
validate $mysql_user
validate $mysql_password
validate $mysql_connector_jar

if [[ ! -f  $mysql_connector_jar  ]]; then
    echo "Please provide the path to MySQL Connector JAR"
    exit 1
fi

#Check whether mysql command exsits
if ! command -v mysql >/dev/null 2>&1; then
    echo "Please install mysql-client (sudo apt -y install mysql-client)"
    exit 1
fi

if [[ ! -f "target/tokens.sql" ]]; then
    # Generate tokens
    $script_dir/generate_tokens.sh 4000
fi

# Execute Queries
mysql -h $mysql_host -u $mysql_user -p$mysql_password < "$script_dir/sqls/create-databases.sql"
mysql -h $mysql_host -u $mysql_user -p$mysql_password apim < "$script_dir/target/tokens.sql"

# Copy configurations after replacing values
temp_conf=$(mktemp -d /tmp/apim-conf.XXXXXX)

echo "Copying configs to a temporary directory"
cp -rv conf $temp_conf

replace_value $temp_conf mysql_host $mysql_host
replace_value $temp_conf mysql_user $mysql_user
replace_value $temp_conf mysql_password $mysql_password

apim_path="$HOME/wso2am-2.1.0"

if [[ -d $apim_path ]]; then
    cp -rv $temp_conf/conf ${apim_path}/repository/
    cp -v $mysql_connector_jar ${apim_path}/repository/components/lib/
fi
