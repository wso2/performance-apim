#!/bin/bash -e
# Copyright (c) 2019, WSO2 Inc. (http://wso2.org) All Rights Reserved.
#
# WSO2 Inc. licenses this file to you under the Apache License,
# Version 2.0 (the "License"); you may not use this file except
# in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#
# ----------------------------------------------------------------------------
# Run Microgateway performance tests on AWS Cloudformation Stacks
# ----------------------------------------------------------------------------

export script_name="$0"
export script_dir=$(dirname "$0")

export wso2am_distribution=""
export wso2am_micro_gw_distribution=""
export mysql_connector_jar=""
export wso2am_ec2_instance_type=""
export wso2am_rds_db_instance_class=""

export aws_cloudformation_template_filename="apim_micro_gw_perf_test_cfn.yaml"
export application_name="WSO2 API Microgateway"
export ec2_instance_name="wso2am"
export metrics_file_prefix="apim"
export run_performance_tests_script_name="run-micro-gw-performance-tests.sh"

function usageCommand() {
    echo "-a <wso2am_distribution> -m <wso2am_micro_gw_distribution> -c <mysql_connector_jar> -A <wso2am_ec2_instance_type> -D <wso2am_rds_db_instance_class>"
}
export -f usageCommand

function usageHelp() {
    echo "-a: WSO2 API Manager Distribution."
    echo "-m: WSO2 API Microgateway Distribution."
    echo "-c: MySQL Connector JAR file."
    echo "-A: Amazon EC2 Instance Type for WSO2 API Manager."
    echo "-D: Amazon EC2 DB Instance Class for WSO2 API Manager RDS Instance."
}
export -f usageHelp

while getopts ":u:f:d:k:n:j:o:g:s:b:r:J:S:N:t:p:w:ha:m:c:A:D:" opt; do
    case "${opt}" in
    a)
        wso2am_distribution=${OPTARG}
        ;;
    m)
        wso2am_micro_gw_distribution=${OPTARG}
        ;;
    c)
        mysql_connector_jar=${OPTARG}
        ;;
    A)
        wso2am_ec2_instance_type=${OPTARG}
        ;;
    D)
        wso2am_rds_db_instance_class=${OPTARG}
        ;;
    *)
        opts+=("-${opt}")
        [[ -n "$OPTARG" ]] && opts+=("$OPTARG")
        ;;
    esac
done
shift "$((OPTIND - 1))"

function validate() {
    if [[ ! -f $wso2am_distribution ]]; then
        echo "Please provide WSO2 API Manager distribution."
        exit 1
    fi

    export wso2am_distribution_filename=$(basename $wso2am_distribution)

    if [[ ${wso2am_distribution_filename: -4} != ".zip" ]]; then
        echo "WSO2 API Manager distribution must have .zip extension"
        exit 1
    fi

    if [[ ! -f $wso2am_micro_gw_distribution ]]; then
        echo "Please provide WSO2 API Microgateway distribution."
        exit 1
    fi

    export wso2am_micro_gw_distribution_filename=$(basename $wso2am_micro_gw_distribution)

    if [[ ${wso2am_micro_gw_distribution_filename: -4} != ".zip" ]]; then
        echo "WSO2 API Microgateway distribution must have .zip extension"
        exit 1
    fi

    if [[ ! -f $mysql_connector_jar ]]; then
        echo "Please provide MySQL Connector JAR file."
        exit 1
    fi

    export mysql_connector_jar_filename=$(basename $mysql_connector_jar)

    if [[ ${mysql_connector_jar_filename: -4} != ".jar" ]]; then
        echo "MySQL Connector JAR must have .jar extension"
        exit 1
    fi

    if [[ -z $wso2am_ec2_instance_type ]]; then
        echo "Please provide the Amazon EC2 Instance Type for WSO2 API Manager."
        exit 1
    fi

    if [[ -z $wso2am_rds_db_instance_class ]]; then
        echo "Please provide the Amazon EC2 DB Instance Class for WSO2 API Manager RDS Instance."
        exit 1
    fi
}
export -f validate

function create_links() {
    wso2am_distribution=$(realpath $wso2am_distribution)
    wso2am_micro_gw_distribution=$(realpath $wso2am_micro_gw_distribution)
    mysql_connector_jar=$(realpath $mysql_connector_jar)
    ln -s $wso2am_distribution $temp_dir/$wso2am_distribution_filename
    ln -s $wso2am_micro_gw_distribution $temp_dir/$wso2am_micro_gw_distribution_filename
    ln -s $mysql_connector_jar $temp_dir/$mysql_connector_jar_filename
}
export -f create_links

function get_test_metadata() {
    echo "application_name=$application_name"
    echo "wso2am_ec2_instance_type=$wso2am_ec2_instance_type"
    echo "wso2am_rds_db_instance_class=$wso2am_rds_db_instance_class"
}
export -f get_test_metadata

function get_cf_parameters() {
    echo "WSO2APIManagerDistributionName=$wso2am_distribution_filename"
    echo "WSO2APIMicroGWDistributionName=$wso2am_micro_gw_distribution_filename"
    echo "MySQLConnectorJarName=$mysql_connector_jar_filename"
    echo "WSO2APIManagerInstanceType=$wso2am_ec2_instance_type"
    echo "WSO2APIManagerDBInstanceClass=$wso2am_rds_db_instance_class"
    echo "MasterUsername=wso2carbon"
    echo "MasterUserPassword=wso2carbon#9762"
}
export -f get_cf_parameters

function get_columns() {
    echo "Scenario Name"
    echo "Heap Size"
    echo "Concurrent Users"
    echo "Message Size (Bytes)"
    echo "Back-end Service Delay (ms)"
    echo "Error %"
    echo "Throughput (Requests/sec)"
    echo "Average Response Time (ms)"
    echo "Standard Deviation of Response Time (ms)"
    echo "99th Percentile of Response Time (ms)"
    echo "WSO2 API Microgateway GC Throughput (%)"
    echo "Average WSO2 API Microgateway Memory Footprint After Full GC (M)"
}
export -f get_columns

$script_dir/cloudformation-common.sh "${opts[@]}" -- "$@"
