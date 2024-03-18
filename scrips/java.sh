#!/bin/bash -e
# Copyright 2024 WSO2 LLC. (http://wso2.org)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
threads=$1
eps=$2
run_for_millis=$3
host=$4
message_size=$5
token=$6

url="ws://$host:9099/echoapi/1.0.0" #modify this as required

# standard messages
b500="data:(heap-59324840,nonHeap-472012345678910848,ts-1616473393721,identifier-ram_17),data:(heap-59324840,nonHeap-472012345678910848,ts-1616473393721,identifier-ram_17),data:(heap-59324840,nonHeap-472012345678910848,ts-1616473393721,identifier-ram_17),data:(heap-59324840,nonHeap-472012345678910848,ts-1616473393721,identifier-ram_17),data:(heap-59324840,nonHeap-472012345678910848,ts-1616473393721,identifier-ram_17),data:(heap-59324840,nonHeap-472012345678910848,ts-1616473393712321,identifier-ram_17)"
b250="data:(heap-59324840,nonHeap-472012345678910848,ts-1616473393721,identifier-ram_17),data:(heap-59324840,nonHeap-472012345678910848,ts-1616473393721,identifier-ram_17),data:(heap-59324840,nonHeap-47201234567891210848,ts-1616473393721,identifier-ram_17)"
b125="data:(heap-59324840,nonHeap-472012345678910848,ts-1616473393721,identifier-ram_17),data:(heap-59324840,nonHeap-848,ts-1616473"
b60="data:(heap-59324840,nonHeap-472848,ts-161,identifier-ram_17)"

case $message_size in
    500)
        message=$b500
        ;;
    250)
        message=$b250
        ;;
    125)
        message=$b125
        ;;
    60)
        message=$b60
        ;;
    *)
        message=$b500
        ;;
esac

echo message $message


java -version

java -jar custom-ws-client-jar-with-dependencies.jar $threads $eps $run_for_millis $url $message $token
