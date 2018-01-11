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
# Run Performance Tests for WSO2 API Manager
# ----------------------------------------------------------------------------

if [[ -d results ]]; then
    echo "Results directory already exists"
    exit 1
fi

jmeter_dir=""
for dir in $HOME/apache-jmeter*; do
    [ -d "${dir}" ] && jmeter_dir="${dir}" && break
done
export JMETER_HOME="${jmeter_dir}"
export PATH=$JMETER_HOME/bin:$PATH

validate_command() {
    # Check whether given command exists
    # $1 is the command name
    # $2 is the package containing command
    if ! command -v $1 >/dev/null 2>&1; then
        echo "Please install $2 (sudo apt -y install $2)"
        exit 1
    fi
}

validate_command zip zip
#jq is required to create final reports
validate_command jq jq

concurrent_users=(50 100 150 500 1000)
backend_sleep_time=(0 30 500 1000)
message_size=(50 1024 10240 102400)
api_host=172.30.2.239
api_path=/echo/1.0.0
api_ssh_host=apim
backend_ssh_host=apimnetty
# Test Duration in seconds
test_duration=900
# Warm-up time in minutes
warmup_time=5
jmeter1_host=172.30.2.13
jmeter2_host=172.30.2.46
jmeter1_ssh_host=apimjmeter1
jmeter2_ssh_host=apimjmeter2
#Heap Size in GBs
apim_heap_size=4
mkdir results
cp $0 results

echo "Generating Payloads in $jmeter1_host"
ssh $jmeter1_ssh_host "./payloads/generate-payloads.sh"
echo "Generating Payloads in $jmeter2_host"
ssh $jmeter2_ssh_host "./payloads/generate-payloads.sh"

write_server_metrics() {
    server=$1
    ssh_host=$2
    pgrep_pattern=$3
    command_prefix=""
    if [[ ! -z $ssh_host ]]; then
        command_prefix="ssh $ssh_host"
    fi
    $command_prefix ss -s > ${report_location}/${server}_ss.txt
    $command_prefix uptime > ${report_location}/${server}_uptime.txt
    $command_prefix sar -q > ${report_location}/${server}_loadavg.txt
    $command_prefix sar -A > ${report_location}/${server}_sar.txt
    $command_prefix top -bn 1 > ${report_location}/${server}_top.txt
    if [[ ! -z $pgrep_pattern ]]; then
        $command_prefix ps u -p \`pgrep -f $pgrep_pattern\` > ${report_location}/${server}_ps.txt
    fi
}

for msize in ${message_size[@]}
do
    for sleep_time in ${backend_sleep_time[@]}
    do
        for u in ${concurrent_users[@]}
        do
            # There are two JMeter Servers
            total_users=$(($u * 2))
            report_location=$PWD/results/${msize}B/${sleep_time}ms_sleep/${total_users}_users
            echo "Report location is ${report_location}"
            mkdir -p $report_location

            ssh $api_ssh_host "./apim/apim-start.sh $apim_heap_size"
            ssh $backend_ssh_host "./netty-service/netty-start.sh $sleep_time"

            # Start remote JMeter servers
            ssh $jmeter1_ssh_host "./jmeter/jmeter-server-start.sh $jmeter1_host"
            ssh $jmeter2_ssh_host "./jmeter/jmeter-server-start.sh $jmeter2_host"

            export JVM_ARGS="-Xms2g -Xmx2g -XX:+PrintGC -XX:+PrintGCDetails -XX:+PrintGCDateStamps -Xloggc:$report_location/jmeter_gc.log"
            echo "# Running JMeter. Concurrent Users: $u Duration: $test_duration JVM Args: $JVM_ARGS"
            jmeter -n -t apim-test.jmx -R $jmeter1_host,$jmeter2_host -X \
                -Gusers=$u -Gduration=$test_duration -Ghost=$api_host -Gpath=$api_path \
                -Gpayload=$HOME/${msize}B.json -Gresponse_size=${msize}B -Gtokens=$HOME/tokens.csv \
                -Gprotocol=https -l ${report_location}/results.jtl

            write_server_metrics jmeter
            write_server_metrics apim $api_ssh_host carbon
            write_server_metrics netty $backend_ssh_host netty
            write_server_metrics jmeter1 $jmeter1_ssh_host
            write_server_metrics jmeter2 $jmeter2_ssh_host

            $HOME/jtl-splitter/jtl-splitter.sh ${report_location}/results.jtl $warmup_time
            echo "Generating Dashboard for Warmup Period"
            jmeter -g ${report_location}/results-warmup.jtl -o $report_location/dashboard-warmup
            echo "Generating Dashboard for Measurement Period"
            jmeter -g ${report_location}/results-measurement.jtl -o $report_location/dashboard-measurement

            echo "Zipping JTL files in ${report_location}"
            zip -jm ${report_location}/jtls.zip ${report_location}/results*.jtl

            scp $jmeter1_ssh_host:jmetergc.log ${report_location}/jmeter1_gc.log
            scp $jmeter2_ssh_host:jmetergc.log ${report_location}/jmeter2_gc.log
            scp $api_ssh_host:wso2am-*/repository/logs/wso2carbon.log ${report_location}/wso2carbon.log
            scp $api_ssh_host:wso2am-*/repository/logs/gc.log ${report_location}/apim_gc.log
            scp $backend_ssh_host:netty-service/logs/netty.log ${report_location}/netty.log
            scp $backend_ssh_host:netty-service/logs/nettygc.log ${report_location}/netty_gc.log
        done
    done
done

echo "Completed"
