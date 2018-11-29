#!/bin/bash -e
# Copyright (c) 2018, WSO2 Inc. (http://wso2.org) All Rights Reserved.
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
# Run all scripts.
# ----------------------------------------------------------------------------

script_start_time=$(date +%s)
script_dir=$(dirname "$0")
default_results_dir="$PWD/results-$(date +%Y%m%d%H%M%S)"
results_dir="$default_results_dir"
apim_performance_distribution=""
apim_product_distribution=""
mysql_connector_distribution=""
key_file=""
jmeter_distribution=""
oracle_jdk_distribution=""
default_stack_name="apim-performance-test-stack"
stack_name="$default_stack_name"
default_test_name="apim-performance-test"
test_name="$default_test_name"
default_key_name="apim-perf-test"
key_name="$default_key_name"
default_s3_bucket_name="apimperformancetest"
s3_bucket_name="$default_s3_bucket_name"
default_s3_bucket_region="us-east-1"
s3_bucket_region="$default_s3_bucket_region"
default_jmeter_client_ec2_instance_type="t3.small"
jmeter_client_ec2_instance_type="$default_jmeter_client_ec2_instance_type"
default_jmeter_server_ec2_instance_type="t3.small"
jmeter_server_ec2_instance_type="$default_jmeter_server_ec2_instance_type"
default_apim_ec2_instance_type="t3.small"
apim_ec2_instance_type="$default_apim_ec2_instance_type"
default_netty_ec2_instance_type="t3.small"
netty_ec2_instance_type="$default_netty_ec2_instance_type"
default_minimum_stack_creation_wait_time=10
minimum_stack_creation_wait_time=$default_minimum_stack_creation_wait_time
default_db_instance_class="db.m5.large"
db_instance_class=$default_db_instance_class
default_master_username="wso2carbon"
master_username=$default_master_username
default_master_user_password="wso2carbon"
master_user_password=$default_master_user_password
default_os_user="ubuntu"
os_user=$default_os_user


function usage() {
    echo ""
    echo "Usage: "
    echo "$0 -f <apim_performance_distribution> -k <key_file> -[-d <results_dir>] [-n <key_name>]"
    echo "   [-b <s3_bucket_name>] [-r <s3_bucket_region>]"
    echo "   [-J <jmeter_client_ec2_instance_type>] [-S <jmeter_server_ec2_instance_type>]"
    echo "   [-B <apim_ec2_instance_type>] [-N <netty_ec2_instance_type>]"
    echo "   [-w <minimum_stack_creation_wait_time>]"
    echo "   [-h] -- [run_performance_tests_options]"
    echo ""
    echo "-f: APIM Performance Distribution containing the scripts to run performance tests."
    echo "-k: Amazon EC2 Key File."
    echo "-a: APIM Product Distribution (.zip)"
    echo "-j: Apache JMeter (tgz) distribution."
    echo "-o: Oracle JDK distribution."
    echo "-c: MySQL Connector JAR file."
    echo "-m: RDS Instance Master Username."
    echo "-p: RDS Instance Master User Password."
    echo "-u: General OS User."
    echo "-s: The Amazon CloudFormation Stack Name. Default: $default_stack_name"
    echo "-t: The Test Name. Default: $default_test_name"
    echo "-d: The results directory. Default value is a directory with current time. For example, $default_results_dir."
    echo "-n: Amazon EC2 Key Name. Default: $default_key_name."
    echo "-b: Amazon S3 Bucket Name. Default: $default_s3_bucket_name."
    echo "-r: Amazon S3 Bucket Region. Default: $default_s3_bucket_region."
    echo "-J: Amazon EC2 Instance Type for JMeter Client. Default: $default_jmeter_client_ec2_instance_type."
    echo "-S: Amazon EC2 Instance Type for JMeter Server. Default: $default_jmeter_server_ec2_instance_type."
    echo "-A: Amazon EC2 Instance Type for APIM. Default: $default_apim_ec2_instance_type."
    echo "-N: Amazon EC2 Instance Type for Netty (Backend) Service. Default: $default_netty_ec2_instance_type."
    echo "-w: The minimum time to wait in minutes before polling for cloudformation stack's CREATE_COMPLETE status."
    echo "    Default: $default_minimum_stack_creation_wait_time."
    echo "-h: Display this help and exit."
    echo ""
}

while getopts "f:k:n:a:j:o:c:m:p:d:b:r:J:S:A:N:z:w:h" opts; do
    case $opts in
    f)
        apim_performance_distribution=${OPTARG}
        ;;
    k)
        key_file=${OPTARG}
        ;;
    n)
        key_name=${OPTARG}
        ;;
    a)
        apim_product_distribution=${OPTARG}
        ;;
    j)
        jmeter_distribution=${OPTARG}
        ;;
    o)
        oracle_jdk_distribution=${OPTARG}
        ;;
    c)
        mysql_connector_distribution=${OPTARG}
        ;;
    m)
        master_username=${OPTARG}
        ;;
    p)
        master_user_password=${OPTARG}
        ;;
    s)
        stack_name=${OPTARG}
        ;;
    t)
        test_name=${OPTARG}
        ;;
    d)
        results_dir=${OPTARG}
        ;;
    b)
        s3_bucket_name=${OPTARG}
        ;;
    r)
        s3_bucket_region=${OPTARG}
        ;;
    J)
        jmeter_client_ec2_instance_type=${OPTARG}
        ;;
    S)
        jmeter_server_ec2_instance_type=${OPTARG}
        ;;
    A)
        apim_ec2_instance_type=${OPTARG}
        ;;
    N)
        netty_ec2_instance_type=${OPTARG}
        ;;
    w)
        minimum_stack_creation_wait_time=${OPTARG}
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

run_performance_tests_options="$@"

if [[ ! -f $apim_performance_distribution ]]; then
    echo "Please provide APIM Performance Distribution."
    exit 1
fi

apim_performance_distribution_filename=$(basename $apim_performance_distribution)

if [[ ${apim_performance_distribution_filename: -7} != ".tar.gz" ]]; then
    echo "APIM Performance Distribution must have .tar.gz extension"
    exit 1
fi

if [[ ! -f $key_file ]]; then
    echo "Please provide the key file."
    exit 1
fi

if [[ ${key_file: -4} != ".pem" ]]; then
    echo "AWS EC2 Key file must have .pem extension"
    exit 1
fi

if [[ ! -f $apim_product_distribution ]]; then
    echo "Please provide APIM Product zip"
    exit 1
fi

apim_product_distribution_filename=$(basename $apim_product_distribution)

if [[ ${apim_product_distribution_filename: -4} != ".zip" ]]; then
    echo "APIM Product must have a .zip extension"
    exit 1
fi

if [[ ! -f $mysql_connector_distribution ]]; then
    echo "Please provide the MySQL Connector JAR file."
    exit 1
fi

mysql_connector_distribution_filename=$(basename $mysql_connector_distribution)

if [[ ${mysql_connector_distribution_filename: -4} != ".jar" ]]; then
    echo "Please specify a valid mysql connector distribution"
    exit 1
fi

if [[ ! -f $jmeter_distribution ]]; then
    echo "Please specify the JMeter distribution file (apache-jmeter-*.tgz)"
    exit 1
fi

jmeter_distribution_filename=$(basename $jmeter_distribution)

if [[ ${jmeter_distribution_filename: -4} != ".tgz" ]]; then
    echo "Please provide the JMeter tgz distribution file (apache-jmeter-*.tgz)"
    exit 1
fi

if [[ ! -f $oracle_jdk_distribution ]]; then
    echo "Please specify the Oracle JDK distribution file (jdk-8u*-linux-x64.tar.gz)"
    exit 1
fi

oracle_jdk_distribution_filename=$(basename $oracle_jdk_distribution)

if ! [[ $oracle_jdk_distribution_filename =~ ^jdk-8u[0-9]+-linux-x64.tar.gz$ ]]; then
    echo "Please specify a valid Oracle JDK distribution file (jdk-8u*-linux-x64.tar.gz)"
    exit 1
fi

if [[ -z $master_username ]]; then
    echo "Please Provide the Username for RDS DB Instance"
    exit 1
fi

if [[ -z $master_user_password ]]; then
    echo "Please Provide the Password for RDS DB Instance"
    exit 1
fi

if [[ -d $results_dir ]]; then
    echo "Results directory already exists. Please give a new name to the results directory."
    exit 1
fi

if [[ -z $key_name ]]; then
    echo "Please provide the key name."
    exit 1
fi

if [[ -z $s3_bucket_name ]]; then
    echo "Please provide S3 bucket name."
    exit 1
fi

if [[ -z $s3_bucket_region ]]; then
    echo "Please provide S3 bucket region."
    exit 1
fi

if [[ -z $stack_name ]]; then
    echo "Please provide the stack name."
    exit 1
fi

if [[ -z $test_name ]]; then
    echo "Please provide the test name."
    exit 1
fi

if [[ -z $jmeter_client_ec2_instance_type ]]; then
    echo "Please provide the Amazon EC2 Instance Type for JMeter Client."
    exit 1
fi

if [[ -z $jmeter_server_ec2_instance_type ]]; then
    echo "Please provide the Amazon EC2 Instance Type for JMeter Server."
    exit 1
fi

if [[ -z $apim_ec2_instance_type ]]; then
    echo "Please provide the Amazon EC2 Instance Type for APIM."
    exit 1
fi

if [[ -z $netty_ec2_instance_type ]]; then
    echo "Please provide the Amazon EC2 Instance Type for Netty (Backend) Service."
    exit 1
fi

if ! [[ $minimum_stack_creation_wait_time =~ ^[0-9]+$ ]]; then
    echo "Please provide a valid minimum time to wait before polling for cloudformation stack's CREATE_COMPLETE status."
    exit 1
fi

key_filename=$(basename "$key_file")

if [[ "${key_filename%.*}" != "$key_name" ]]; then
    echo "Key file must match with the key name. i.e. $key_filename should be equal to $key_name.pem."
    exit 1
fi

function check_command() {
    if ! command -v $1 >/dev/null 2>&1; then
        echo "Please install $1"
        exit 1
    fi
}

check_command bc
check_command aws
check_command unzip
check_command jq
check_command python

function format_time() {
    # Duration in seconds
    local duration="$1"
    local minutes=$(echo "$duration/60" | bc)
    local seconds=$(echo "$duration-$minutes*60" | bc)
    if [[ $minutes -ge 60 ]]; then
        local hours=$(echo "$minutes/60" | bc)
        minutes=$(echo "$minutes-$hours*60" | bc)
        printf "%d hour(s), %02d minute(s) and %02d second(s)\n" $hours $minutes $seconds
    elif [[ $minutes -gt 0 ]]; then
        printf "%d minute(s) and %02d second(s)\n" $minutes $seconds
    else
        printf "%d second(s)\n" $seconds
    fi
}

function measure_time() {
    local end_time=$(date +%s)
    local start_time=$1
    local duration=$(echo "$end_time - $start_time" | bc)
    echo "$duration"
}

# Use absolute path
results_dir=$(realpath $results_dir)
mkdir $results_dir
echo "Results will be downloaded to $results_dir"

echo "Extracting APIM Performance Distribution to $results_dir"
tar -xf $apim_performance_distribution -C $results_dir

echo "Checking whether python requirements are installed..."
pip install --user -r $results_dir/jmeter/python-requirements.txt

estimate_command="$results_dir/jmeter/run-performance-test.sh -t ${run_performance_tests_options[@]}"
echo "Estimating time for performance tests: $estimate_command"
#Estimating this script will also validate the options. It's important to validate options before creating the stack.
$estimate_command

temp_dir=$(mktemp -d)

# Get absolute paths
key_file=$(realpath $key_file)
apim_performance_distribution=$(realpath $apim_performance_distribution)
apim_product_distribution=$(realpath $apim_product_distribution)
mysql_connector_distribution=$(realpath $mysql_connector_distribution)
jmeter_distribution=$(realpath $jmeter_distribution)
oracle_jdk_distribution=$(realpath $oracle_jdk_distribution)

ln -s $key_file $temp_dir/$key_filename
ln -s $apim_performance_distribution $temp_dir/$apim_performance_distribution_filename
ln -s $apim_product_distribution $temp_dir/$apim_product_distribution_filename
ln -s $mysql_connector_distribution $temp_dir/$mysql_connector_distribution_filename
ln -s $jmeter_distribution $temp_dir/$jmeter_distribution_filename
ln -s $oracle_jdk_distribution $temp_dir/$oracle_jdk_distribution_filename

echo "Syncing files in $temp_dir to S3 Bucket $s3_bucket_name..."
aws s3 sync --quiet --delete $temp_dir s3://$s3_bucket_name

echo "Listing files in S3 Bucket $s3_bucket_name..."
aws --region $s3_bucket_region s3 ls --summarize s3://$s3_bucket_name

cd $script_dir

echo "Validating stack..."
# Validate stack first
aws cloudformation validate-template --template-body file://apim_perf_test_cfn.yaml

# Save metadata
test_parameters_json='.'
test_parameters_json+=' | .["jmeter_client_ec2_instance_type"]=$jmeter_client_ec2_instance_type'
test_parameters_json+=' | .["jmeter_server_ec2_instance_type"]=$jmeter_server_ec2_instance_type'
test_parameters_json+=' | .["apim_ec2_instance_type"]=$apim_ec2_instance_type'
test_parameters_json+=' | .["netty_ec2_instance_type"]=$netty_ec2_instance_type'
jq -n \
    --arg jmeter_client_ec2_instance_type "$jmeter_client_ec2_instance_type" \
    --arg jmeter_server_ec2_instance_type "$jmeter_server_ec2_instance_type" \
    --arg apim_ec2_instance_type "$apim_ec2_instance_type" \
    --arg netty_ec2_instance_type "$netty_ec2_instance_type" \
    "$test_parameters_json" >$results_dir/cf-test-metadata.json

stack_create_start_time=$(date +%s)
create_stack_command="aws cloudformation create-stack --stack-name $stack_name \
    --template-body file://apim_perf_test_cfn.yaml --parameters \
    ParameterKey=TestName,ParameterValue=$test_name \
    ParameterKey=KeyName,ParameterValue=$key_name \
    ParameterKey=BucketName,ParameterValue=$s3_bucket_name \
    ParameterKey=BucketRegion,ParameterValue=$s3_bucket_region \
    ParameterKey=PerformanceAPIMDistributionName,ParameterValue=$apim_performance_distribution_filename \
    ParameterKey=APIMDistributionName,ParameterValue=$apim_product_distribution_filename \
    ParameterKey=JMeterDistributionName,ParameterValue=$jmeter_distribution_filename \
    ParameterKey=OracleJDKDistributionName,ParameterValue=$oracle_jdk_distribution_filename \
    ParameterKey=MysqlConnectorDistributionName,ParameterValue=$mysql_connector_distribution_filename \
    ParameterKey=DBInstanceClass,ParameterValue=$db_instance_class \
    ParameterKey=MasterUsername,ParameterValue=$master_username \
    ParameterKey=MasterUserPassword,ParameterValue=$master_user_password \
    ParameterKey=OSUser,ParameterValue=$os_user \
    ParameterKey=JMeterClientInstanceType,ParameterValue=$jmeter_client_ec2_instance_type \
    ParameterKey=JMeterServerInstanceType,ParameterValue=$jmeter_server_ec2_instance_type \
    ParameterKey=APIMInstanceType,ParameterValue=$apim_ec2_instance_type \
    ParameterKey=BackendInstanceType,ParameterValue=$netty_ec2_instance_type \
    --capabilities CAPABILITY_IAM"

echo "Creating stack..."
echo "$create_stack_command"
# Create stack
stack_id="$($create_stack_command)"

function exit_handler() {
    # Get stack events
    local stack_events_json=$results_dir/stack-events.json
    echo "Saving stack events to $stack_events_json"
    aws cloudformation describe-stack-events --stack-name $stack_id --no-paginate --output json >$stack_events_json
    # Check whether there are any failed events
    cat $stack_events_json | jq '.StackEvents | .[] | select ( .ResourceStatus == "CREATE_FAILED" )'

    # Download log events
    log_group_name="${stack_name}-CloudFormationLogs"
    local log_streams_json=$results_dir/log-streams.json
    if aws logs describe-log-streams --log-group-name $log_group_name --output json >$log_streams_json; then
        local log_events_file=$results_dir/log-events.log
        for log_stream in $(cat $log_streams_json | jq -r '.logStreams | .[] | .logStreamName'); do
            echo "Downloading log events from stream: $log_stream..."
            echo "#### The beginning of log events from $log_stream" >>$log_events_file
            aws logs get-log-events --log-group-name $log_group_name --log-stream-name $log_stream --output text >>$log_events_file
            echo -ne "\n\n#### The end of log events from $log_stream\n\n" >>$log_events_file
        done
    fi

    local stack_delete_start_time=$(date +%s)
    echo "Deleting the stack: $stack_id"
    aws cloudformation delete-stack --stack-name $stack_id

    echo "Polling till the stack deletion completes..."
    aws cloudformation wait stack-delete-complete --stack-name $stack_id
    printf "Stack deletion time: %s\n" "$(format_time $(measure_time $stack_delete_start_time))"

    printf "Script execution time: %s\n" "$(format_time $(measure_time $script_start_time))"
}

trap exit_handler EXIT

echo "Created stack: $stack_id"

# Sleep for sometime before waiting
# This is required since the 'aws cloudformation wait stack-create-complete' will exit with a
# return code of 255 after 120 failed checks. The command polls every 30 seconds, which means that the
# maximum wait time is one hour.
# Due to the dependencies in CloudFormation template, the stack creation may take more than one hour.
echo "Waiting ${minimum_stack_creation_wait_time}m before polling for cloudformation stack's CREATE_COMPLETE status..."
sleep ${minimum_stack_creation_wait_time}m
# Wait till completion
echo "Polling till the stack creation completes..."
aws cloudformation wait stack-create-complete --stack-name $stack_id
printf "Stack creation time: %s\n" "$(format_time $(measure_time $stack_create_start_time))"

echo "Getting JMeter Client Public IP..."

jmeter_client_ip="$(aws cloudformation describe-stacks --stack-name $stack_id --query 'Stacks[0].Outputs[?OutputKey==`JMeterClientPublicIP`].OutputValue' --output text)"

echo "JMeter Client Public IP: $jmeter_client_ip"

# JMeter servers must be 2 (according to the cloudformation script)
run_performance_tests_command="./jmeter/run-performance-test.sh ${run_performance_tests_options[@]} -n 2"
# Run performance tests
run_remote_tests="ssh -i $key_file -o "StrictHostKeyChecking=no" -t ubuntu@$jmeter_client_ip $run_performance_tests_command"
echo "Running performance tests: $run_remote_tests"
# Handle any error and let the script continue.
$run_remote_tests || echo "Remote test ssh command failed."

# Download results-without-jtls.zip
scp -i $key_file -o "StrictHostKeyChecking=no" ubuntu@$jmeter_client_ip:results-without-jtls.zip $results_dir
# Download results.zip
scp -i $key_file -o "StrictHostKeyChecking=no" ubuntu@$jmeter_client_ip:results.zip $results_dir

if [[ ! -f $results_dir/results.zip ]]; then
    echo "Failed to download the results.zip"
    exit 500
fi

echo "Creating summary.csv..."
cd $results_dir
unzip -q results.zip
wget -q http://sourceforge.net/projects/gcviewer/files/gcviewer-1.35.jar/download -O gcviewer.jar
./jmeter/create-summary-csv.sh -d results -n apim -p apim -j 2 -g gcviewer.jar

echo "Creating summary results markdown file..."
# Use following to get all column names:
echo "Available column names: "
while IFS= read -r line; do echo -ne " \"$line\""; done < <(./jmeter/create-summary-csv.sh -n "apim" -j 2 -i -x)

./jmeter/create-summary-markdown.py --json-files cf-test-metadata.json results/test-metadata.json --column-names \
    "Scenario Name" "Concurrent Users" "Message Size (Bytes)" "Back-end Service Delay (ms)" "Error %" "Throughput (Requests/sec)" \
    "Average Response Time (ms)" "Standard Deviation of Response Time (ms)" "99th Percentile of Response Time (ms)" \
    "Ballerina GC Throughput (%)" "Average of Ballerina Memory Footprint After Full GC (M)"
