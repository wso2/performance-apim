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

export PATH=$JMETER_HOME/bin:$PATH

concurrent_users=(50 100 150 500 1000)
backend_sleep_time=(0 30 500 1000)
message_size=(0 1 10 100)
api_host=172.30.2.239
api_path=/echo/1.0.0
api_ssh_host=apim2
backend_ssh_host=apim3
test_duration=900
mkdir results
cp $0 results

# Generate Payloads
$HOME/payloads/generate-payloads.sh

run_tests() {
    for msize in ${message_size[@]}
    do
        for sleep_time in ${backend_sleep_time[@]}
        do
            for u in ${concurrent_users[@]}
            do
                report_location=$PWD/results/${msize}K/${sleep_time}s_sleep/${u}_users
                mkdir -p $report_location

                ssh $api_ssh_host "./apim/apim_start.sh"
                ssh $backend_ssh_host "./netty-service/netty_start.sh $sleep_time"

                export JVM_ARGS="-Xms2g -Xmx2g -XX:+PrintGC -XX:+PrintGCDetails -XX:+PrintGCDateStamps -Xloggc:$PWD/$report_location/jmeter_gc.log"
                echo "# Running JMeter. Concurrent Users: $u Duration: $test_duration JVM Args: $JVM_ARGS"
                jmeter.sh -n -t apim-test.jmx -R 172.30.2.13,172.30.2.46 \
                    -Gusers=$u -Gduration=$test_duration -Ghost=$api_host -Gpath=$api_path -Gpayload=$1.json -Gprotocol=https -l ${report_location}/results.jtl

                ss -s > ${report_location}/jmeter_ss.txt
                ssh $api_ssh_host "ss -s" > ${report_location}/apim_ss.txt
                ssh $backend_ssh_host "ss -s" > ${report_location}/netty_ss.txt

                $HOME/jtl-splitter/jtl-splitter.sh ${report_location}/results.jtl 5
                echo "Generating Dashboard for Warmup Period"
                jmeter -g ${report_location}/results-warmup.jtl -o $report_location/dashboard-warmup
                echo "Generating Dashboard for Measurement Period"
                jmeter -g ${report_location}/results-measurement.jtl -o $report_location/dashboard-measurement

                echo "Zipping JTL files"
                zip -jm ${report_location}/jtls.zip ${report_location}/results*.jtl

                scp $api_ssh_host:wso2am-2.1.0/repository/logs/wso2carbon.log ${report_location}/wso2carbon.log
                scp $api_ssh_host:wso2am-2.1.0/repository/logs/gc.log ${report_location}/apim_gc.log
                scp $backend_ssh_host:logs/nettygc.log ${report_location}/netty_gc.log

                sar -q > ${report_location}/jmeter_loadavg.txt
                sar -A > ${report_location}/jmeter_sar.txt

                ssh $api_ssh_host "sar -q" > ${report_location}/apim_loadavg.txt
                ssh $api_ssh_host "sar -A" > ${report_location}/apim_sar.txt
                ssh $api_ssh_host "top -bn 1" > ${report_location}/apim_top.txt
                ssh $api_ssh_host "ps u -p \`pgrep -f carbon\`" > ${report_location}/apim_ps.txt

                ssh $backend_ssh_host "sar -q" > ${report_location}/netty_loadavg.txt
                ssh $backend_ssh_host "sar -A" > ${report_location}/netty_sar.txt
                ssh $backend_ssh_host "top -bn 1" > ${report_location}/netty_top.txt
                ssh $backend_ssh_host "ps u -p \`pgrep -f netty\`" > ${report_location}/netty_ps.txt
                # Increased due to errors
                sleep 240
            done
        done
    done
}

run_tests
echo "Completed"
