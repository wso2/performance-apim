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
# Run API Manager Performance Tests
# ----------------------------------------------------------------------------

script_dir=$(dirname "$0")
# Execute common script
. $script_dir/perf-test-common.sh

function initialize() {
    export apim_ssh_host=apim
    export apim_host=$(get_ssh_hostname $apim_ssh_host)
    echo "Downloading tokens to $HOME."
    scp $apim_ssh_host:apim/target/tokens.csv $HOME/
    if [[ $jmeter_servers -gt 1 ]]; then
        for jmeter_ssh_host in ${jmeter_ssh_hosts[@]}; do
            echo "Copying tokens to $jmeter_ssh_host"
            scp $HOME/tokens.csv $jmeter_ssh_host:
        done
    fi
}
export -f initialize

declare -A test_scenario0=(
    [name]="passthrough"
    [display_name]="Passthrough"
    [description]="A secured API, which directly invokes the back-end service."
    [jmx]="apim-test.jmx"
    [protocol]="https"
    [path]="/echo/1.0.0"
    [use_backend]=true
    [skip]=false
)
#declare -A test_scenario1=(
#    [name]="transformation"
#    [display_name]="Transformation"
#    [description]="A secured API, which has a mediation extension to modify the message."
#    [jmx]="apim-test.jmx"
#    [protocol]="https"
#    [path]="/mediation/1.0.0"
#    [use_backend]=true
#    [skip]=false
#)

function before_execute_test_scenario() {
    local service_path=${scenario[path]}
    local protocol=${scenario[protocol]}
    jmeter_params+=("host=$apim_host" "port=8243" "path=$service_path")
    jmeter_params+=("payload=$HOME/${msize}B.json" "response_size=${msize}B" "protocol=$protocol"
        tokens="$HOME/tokens.csv")
    echo "Starting APIM service"
    ssh $apim_ssh_host "./apim/apim-start.sh -m $heap"
}

function after_execute_test_scenario() {
    write_server_metrics apim $apim_ssh_host org.wso2.carbon.bootstrap.Bootstrap
    download_file $apim_ssh_host wso2am/repository/logs/wso2carbon.log wso2carbon.log
    download_file $apim_ssh_host wso2am/repository/logs/gc.log apim_gc.log
    download_file $apim_ssh_host wso2am/repository/logs/recording.jfr recording.jfr
}

test_scenarios
