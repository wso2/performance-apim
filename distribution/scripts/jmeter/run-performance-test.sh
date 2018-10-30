#!/bin/bash -e

script_dir=$(dirname "$0")
# Execute common script
. $script_dir/perf-test-common.sh

function initialize()
{
    export apim_ssh_host=apim
    export apim_host=$(get_ssh_hostname $apim_ssh_host)
    scp $apim_ssh_host:setup/target/tokens.csv $HOME/tokens.csv
}
export -f initialize

declare -A test_scenario0=(
    [name]="passthrough"
    [display_name]="Passthrough"
    [description]="APIM simply forwards all requests to a back-end service without any processing"
    [jmx]="apim-test.jmx"
    [protocol]="https"
    [path]="/echo/1.0.0"
    [use_backend]=true
    [skip]=false
)
declare -A test_scenario1=(
    [name]="mediation"
    [display_name]="Mediation"
    [description]="APIM processes all the requests before forwarding it to a back-end service"
    [jmx]="apim-test.jmx"
    [protocol]="https"
    [path]="/mediation/1.0.0"
    [use_backend]=true
    [skip]=false
)

function before_execute_test_scenario() {

    local service_path=${scenario[path]}
    local protocol=${scenario[protocol]}
    jmeter_params+=("host=$apim_host" "port=8243" "path=$service_path")
    jmeter_params+=("payload=$HOME/${msize}B.json" "response_size=${msize}B" "protocol=$protocol" tokens="$HOME/tokens.csv")
    echo "Starting APIM service"
    ssh $apim_ssh_host "./setup/apim-start.sh $heap "
}

function after_execute_test_scenario() {

    write_server_metrics apim $apim_ssh_host carbon
    download_file $apim_ssh_host wso2am/repository/logs/wso2carbon.log wso2carbon.log
    download_file $apim_ssh_host wso2am/repository/logs/gc.log apim_gc.log
}

test_scenarios