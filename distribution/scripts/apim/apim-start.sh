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
# Start WSO2 API Manager
# ----------------------------------------------------------------------------

heap_size=$1
if [[ -z $heap_size ]]; then
    heap_size="4"
fi

jvm_dir=""
for dir in /usr/lib/jvm/jdk1.8*; do
    [ -d "${dir}" ] && jvm_dir="${dir}" && break
done
export JAVA_HOME="${jvm_dir}"

apim_version=2.1.0
carbon_bootstrap_class=org.wso2.carbon.bootstrap.Bootstrap

if pgrep -f "$carbon_bootstrap_class" > /dev/null; then
    echo "Shutting down APIM"
    $HOME/wso2am-${apim_version}/bin/wso2server.sh stop
fi

echo "Waiting for API Manager to stop"

while true
do
    if ! pgrep -f "$carbon_bootstrap_class" > /dev/null; then
        echo "API Manager stopped"
        break
    else
        sleep 10
    fi
done

log_files=($HOME/wso2am-${apim_version}/repository/logs/*)
if [ ${#log_files[@]} -gt 1 ]; then
    echo "Log files exists. Moving to /tmp"
    mv $HOME/wso2am-${apim_version}/repository/logs/* /tmp/;
fi

echo "Setting Heap to ${heap_size}GB"
export JVM_MEM_OPTS="-Xms${heap_size}G -Xmx${heap_size}G"

echo "Enabling GC Logs"
export JAVA_OPTS="-XX:+PrintGC -XX:+PrintGCDetails -XX:+PrintGCDateStamps -Xloggc:$HOME/wso2am-${apim_version}/repository/logs/gc.log"

echo "Starting APIM"
$HOME/wso2am-${apim_version}/bin/wso2server.sh start

echo "Waiting for API Manager to start"

while true 
do
    # Check Version service
    response_code="$(curl -sk -w "%{http_code}" -o /dev/null https://localhost:8243/services/Version)"
    if [ $response_code -eq 200 ]; then
        echo "API Manager started"
        break
    else
        sleep 10
    fi
done

# Wait for another 10 seconds to make sure that the server is ready to accept API requests.
sleep 10
