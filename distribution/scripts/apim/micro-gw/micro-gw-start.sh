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

function usage() {
    echo ""
    echo "Usage: "
    echo "$0 [-m <heap_size>] [-n <label>] [-h]"
    echo "-m: The heap memory size of API Microgateway. Default: $default_heap_size."
    echo "-n: The identifier for the built Microgateway distribution. Default: $default_label."
    echo "-h: Display this help and exit."
    echo ""
}

while getopts "m:n:h" opt; do
    case "${opt}" in
    m)
        heap_size=${OPTARG}
        ;;
    n)
        label=${OPTARG}
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

if [ -e "/home/ubuntu/micro-gw-${label}/bin/gateway.pid" ]; then
    PID=$(cat "/home/ubuntu/micro-gw-${label}/bin/gateway.pid")
fi

if pgrep -f ballerina >/dev/null; then
    echo "Shutting down microgateway"
    pgrep -f ballerina | xargs kill -9
fi

echo "Waiting for microgateway to stop"
while true; do
    if ! pgrep -f ballerina >/dev/null; then
        echo "Microgateway stopped"
        break
    else
        sleep 10
    fi
done

log_files=(/home/ubuntu/micro-gw-${label}/logs/*)

if [ ${#log_files[@]} -gt 1 ]; then
    echo "Log files exists. Moving to /tmp"
    mv /home/ubuntu/micro-gw-${label}/logs/* /tmp/
fi

echo "Enabling GC Logs"
export JAVA_OPTS="-XX:+PrintGC -XX:+PrintGCDetails -XX:+PrintGCDateStamps -Xloggc:/home/ubuntu/micro-gw-${label}/logs/gc.log"
JAVA_OPTS+=" -Xms${heap_size} -Xmx${heap_size}"
JAVA_OPTS+=" -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath="/home/ubuntu/micro-gw-${label}/runtime/heap-dump.hprof""

jvm_dir=""
for dir in /usr/lib/jvm/jdk1.8*; do
    [ -d "${dir}" ] && jvm_dir="${dir}" && break
done
export JAVA_HOME="${jvm_dir}"

echo "Starting Microgateway"
pushd /home/ubuntu/micro-gw-${label}/bin/
bash gateway >/dev/null &
popd

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
