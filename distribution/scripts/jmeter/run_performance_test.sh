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
message_size=(50 1024 10240 102400)
api_host=172.30.2.239
api_path=/echo/1.0.0
api_ssh_host=apim
backend_ssh_host=apimnetty
test_duration=900
jmeter1_host=172.30.2.13
jmeter2_host=172.30.2.46
jmeter1_ssh_host=apimjmeter1
jmeter2_ssh_host=apimjmeter2
mkdir results
cp $0 results

echo "Generating Payloads in $jmeter1_host"
ssh $jmeter1_ssh_host "./payloads/generate-payloads.sh"
echo "Generating Payloads in $jmeter2_host"
ssh $jmeter2_ssh_host "./payloads/generate-payloads.sh"

for msize in ${message_size[@]}
do
    for sleep_time in ${backend_sleep_time[@]}
    do
        for u in ${concurrent_users[@]}
        do
            report_location=$PWD/results/${msize}B/${sleep_time}ms_sleep/${u}_users
            echo "Report location is ${report_location}"
            mkdir -p $report_location

            ssh $api_ssh_host "./apim/apim-start.sh"
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

            ss -s > ${report_location}/jmeter_ss.txt
            ssh $api_ssh_host "ss -s" > ${report_location}/apim_ss.txt
            ssh $backend_ssh_host "ss -s" > ${report_location}/netty_ss.txt

            $HOME/jtl-splitter/jtl-splitter.sh ${report_location}/results.jtl 5
            echo "Generating Dashboard for Warmup Period"
            jmeter -g ${report_location}/results-warmup.jtl -o $report_location/dashboard-warmup
            echo "Generating Dashboard for Measurement Period"
            jmeter -g ${report_location}/results-measurement.jtl -o $report_location/dashboard-measurement

            echo "Zipping JTL files in ${report_location}"
            zip -jm ${report_location}/jtls.zip ${report_location}/results*.jtl

            scp $jmeter1_ssh_host:jmetergc.log ${report_location}/jmeter1_gc.log
            scp $jmeter2_ssh_host:jmetergc.log ${report_location}/jmeter2_gc.log

            scp $api_ssh_host:wso2am-2.1.0/repository/logs/wso2carbon.log ${report_location}/wso2carbon.log
            scp $api_ssh_host:wso2am-2.1.0/repository/logs/gc.log ${report_location}/apim_gc.log
            scp $backend_ssh_host:netty-service/logs/netty.log ${report_location}/netty.log
            scp $backend_ssh_host:netty-service/logs/nettygc.log ${report_location}/netty_gc.log

            sar -q > ${report_location}/jmeter_loadavg.txt
            sar -A > ${report_location}/jmeter_sar.txt

            ssh $jmeter1_ssh_host "sar -A" > ${report_location}/jmeter1_sar.txt
            ssh $jmeter2_ssh_host "sar -A" > ${report_location}/jmeter2_sar.txt

            ssh $api_ssh_host "sar -q" > ${report_location}/apim_loadavg.txt
            ssh $api_ssh_host "sar -A" > ${report_location}/apim_sar.txt
            ssh $api_ssh_host "top -bn 1" > ${report_location}/apim_top.txt
            ssh $api_ssh_host "ps u -p \`pgrep -f carbon\`" > ${report_location}/apim_ps.txt

            ssh $backend_ssh_host "sar -q" > ${report_location}/netty_loadavg.txt
            ssh $backend_ssh_host "sar -A" > ${report_location}/netty_sar.txt
            ssh $backend_ssh_host "top -bn 1" > ${report_location}/netty_top.txt
            ssh $backend_ssh_host "ps u -p \`pgrep -f netty\`" > ${report_location}/netty_ps.txt
        done
    done
done

echo "Completed"
