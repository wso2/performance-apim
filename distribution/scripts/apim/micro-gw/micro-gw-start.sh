#!/bin/bash
# Copyright 2019 WSO2 Inc. (http://wso2.org)
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
# Start WSO2 API Manager Micro Gateway
# ----------------------------------------------------------------------------

script_dir=$(dirname "$0")
default_label="echo-mgw"
label="$default_label"
default_heap_size="512m"
heap_size="$default_heap_size"
#todo: set as parameter
micro_gw_version="3.1.0"
default_cpus="2"
cpus="$default_cpus"

function usage() {
    echo ""
    echo "Usage: "
    echo "$0 [-m <heap_size>] [-n <label>] [-h]"
    echo "-m: The heap memory size of API Microgateway. Default: $default_heap_size."
    echo "-c: --cpus parameter of API Microgateway (docker). Default: $default_cpus."
    echo "-n: The identifier for the built Microgateway distribution. Default: $default_label."
    echo "-h: Display this help and exit."
    echo ""
}

while getopts "m:n:c:h" opt; do
    case "${opt}" in
    m)
        heap_size=${OPTARG}
        ;;
    n)
        label=${OPTARG}
        ;;
    c) 
        cpus=${OPTARG}
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

if [[ -z $heap_size ]]; then
    echo "Please provide the heap size for the API Microgateway."
    exit 1
fi

if [[ -z $label ]]; then
    echo "Please provide the identifier for the built Microgateway distribution."
    exit 1
fi

docker kill $(docker ps -a | grep wso2/wso2micro-gw:$micro_gw_version | awk '{print $1}')
docker rm $(docker ps -a | grep wso2/wso2micro-gw:$micro_gw_version | awk '{print $1}')

# create a separate location to keep logs
if [ ! -d "/home/ubuntu/micro-gw-${label}" ]; then
  mkdir /home/ubuntu/micro-gw-${label}
  mkdir /home/ubuntu/micro-gw-${label}/logs
  mkdir /home/ubuntu/micro-gw-${label}/runtime
fi

log_files=(/home/ubuntu/micro-gw-${label}/logs/*)

if [ ${#log_files[@]} -gt 1 ]; then
    echo "Log files exists. Moving to /tmp"
    mv /home/ubuntu/micro-gw-${label}/logs/* /tmp/
fi

#create empty file to mount into docker
touch /home/ubuntu/micro-gw-${label}/logs/gc.log
touch /home/ubuntu/micro-gw-${label}/runtime/heap-dump.hprof
touch /home/ubuntu/micro-gw-${label}/logs/microgateway.log
chmod -R a+rw /home/ubuntu/micro-gw-${label}

echo "Enabling GC Logs"
export JAVA_OPTS="-Xms${heap_size} -Xmx${heap_size} -XX:+PrintGC -XX:+PrintGCDetails -XX:+PrintGCDateStamps -Xloggc:/home/ballerina/gc.log"
JAVA_OPTS+=" -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath="/home/ballerina/heap-dump.hprof""

jvm_dir=""
for dir in /usr/lib/jvm/jdk1.8*; do
    [ -d "${dir}" ] && jvm_dir="${dir}" && break
done
export JAVA_HOME="${jvm_dir}"

#overwrite the micro-gw.conf
echo $(ifconfig | grep "inet " | grep -v "127.0.0.1" | grep -v "172." |awk '{print $2}')
sh /home/ubuntu/apim/micro-gw/create-micro-gw-conf.sh -i $(ifconfig | grep "inet " | grep -v "127.0.0.1" | grep -v "172." |awk '{print $2}')

echo "Starting Microgateway"
pushd /home/ubuntu/${label}/target/
(
    set -x
    #todo: change the conf path after properly fixing the micro-gw.conf
    docker run -d -v ${PWD}:/home/exec/ -v /home/ubuntu/micro-gw.conf:/home/ballerina/conf/micro-gw.conf -p 9095:9095 -p 9090:9090 -e project=${label} \
    -e JAVA_OPTS="${JAVA_OPTS}" --name="microgw" --cpus=${cpus} \
    -v /home/ubuntu/micro-gw-${label}/logs/gc.log:/home/ballerina/gc.log -v /home/ubuntu/micro-gw-${label}/runtime/heap-dump.hprof:/home/ballerina/heap-dump.hprof \
    wso2/wso2micro-gw:${micro_gw_version}
)
popd

docker stop $(docker ps -a | grep wso2/wso2micro-gw:$micro_gw_version | awk '{print $1}')
docker start $(docker ps -a | grep wso2/wso2micro-gw:$micro_gw_version | awk '{print $1}')

echo "Waiting for Microgateway to start"

n=0
until [ $n -ge 60 ]; do
    nc -zv localhost 9095 && break
    n=$(($n + 1))
    sleep 1
done

# Wait for another 5 seconds to make sure that the server is ready to accept API requests.
sleep 5
exit $exit_status
