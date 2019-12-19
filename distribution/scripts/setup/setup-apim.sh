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
export oracle_jdk_dist=""
export os_user=""
export token_type="JWT"

function usageCommand() {
    echo "-j <oracle_jdk_dist> -a <apim_product> -c <mysql_connector_file> -n <netty_host> -m <mysql_host> -u <mysql_username> -p <mysql_password> -o <os_user> -t <token_type>"
}
export -f usageCommand

function usageHelp() {
    echo "-j: Oracle JDK distribution."
    echo "-a: WSO2 API Manager distribution."
    echo "-c: MySQL Connector JAR file."
    echo "-n: The hostname of Netty service."
    echo "-m: The hostname of MySQL service."
    echo "-u: MySQL Username."
    echo "-p: MySQL Password."
    echo "-o: General user of the OS."
    echo "-t: Token type. Either JWT or OAUTH. Default is OAUTH."
}
export -f usageHelp

while getopts "gp:w:o:hj:a:c:n:m:u:p:o:t:" opt; do
    case "${opt}" in
    j)
        oracle_jdk_dist=${OPTARG}
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
    t)
        token_type=${OPTARG}
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
        echo "Please provide the apim_product."
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

function mediation_out_sequence() {
    cat <<EOF
<sequence xmlns=\"http://ws.apache.org/ns/synapse\" name=\"mediation-api-sequence\">
    <payloadFactory media-type=\"json\">
        <format>
            {\"payload\":\"\$1\",\"size\":\"\$2\"}
        </format>
        <args>
            <arg expression=\"\$.payload\" evaluator=\"json\"></arg>
            <arg expression=\"\$.size\" evaluator=\"json\"></arg>
        </args>
    </payloadFactory>
</sequence>
EOF
}
export -f mediation_out_sequence

function setup() {
    install_dir=/home/$os_user
    $script_dir/../java/install-java.sh -f $oracle_jdk_dist -u $os_user

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
    sudo -u $os_user $script_dir/../apim/create-api.sh -a localhost -n "echo" -d "Echo API" -b "http://${netty_host}:8688/" -k $token_type
    sudo -u $os_user $script_dir/../apim/create-api.sh -a localhost -n "mediation" -d "Mediation API" -b "http://${netty_host}:8688/" \
        -o "$(mediation_out_sequence | tr -d "\n\r")" -k $token_type

    if [ "$token_type" == "JWT" ]; then
        tokens_csv="$script_dir/../apim/target/tokens.csv"
        if [[ -f $tokens_csv ]]; then
            sudo -u $os_user rm tokens_csv
        fi
        sudo -u $os_user $script_dir/../apim/generate-jwt-tokens.sh -t 4000
    else
        # Generate tokens
        tokens_sql="$script_dir/../apim/target/tokens.sql"
        if [[ ! -f $tokens_sql ]]; then
            sudo -u $os_user $script_dir/../apim/generate-tokens.sh -t 4000
        fi

        if [[ -f $tokens_sql ]]; then
            mysql -h $mysql_host -u $mysql_user -p$mysql_password apim <$tokens_sql
        else
            echo "SQL file with generated tokens not found."
            exit 1
        fi
    fi

    popd
    echo "Completed API Manager setup..."
}
export -f setup

$script_dir/setup-common.sh "${opts[@]}" "$@" -p curl -p jq -p unzip -p mysql-client
