#!/bin/bash -e

script_dir=$(dirname "$0")
# Execute common script
. $script_dir/perf-test-common.sh

apim_ssh_host=apim
apim_host=$(get_ssh_hostname $apim_ssh_host)
scp $apim_ssh_host:setup/target/tokens.csv $HOME/tokens.csv

declare -A test_scenario0=(
    [name]="passthrough"
    [jmx]="apim-test.jmx"
    [protocol]="https"
    [path]="/echo/1.0.0"
    [use_backend]=true
    [skip]=false
)
declare -A test_scenario1=(
    [name]="mediation"
    [jmx]="apim-test.jmx"
    [protocol]="https"
    [path]="/mediation/1.0.0"
    [use_backend]=true
    [skip]=false
)

function before_execute_test_scenario() {

    local service_path=${scenario[path]}
    local protocol=${scenario[protocol]}
    jmeter_params+=("host=$apim_host" "port=9090" "path=$service_path")
    jmeter_params+=("payload=$HOME/${msize}B.json" "response_size=${msize}B" "protocol=$protocol")
    JMETER_JVM_ARGS="-Xbootclasspath/p:/opt/alpnboot/alpnboot.jar"
    echo "Starting APIM service"
    ssh $apim_ssh_host "./setup/apim-start.sh $heap "
}

function after_execute_test_scenario() {

    write_server_metrics apim $apim_ssh_host carbon
    download_file $apim_ssh_host wso2am/repository/logs/wso2carbon.log wso2carbon.log
    download_file $apim_ssh_host wso2am/repository/logs/gc.log apim_gc.log
}

test_scenarios