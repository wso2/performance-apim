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

export JVM_ARGS="-Xmx4g"

token="$3"

echo 'Token : '$token

thread="$1"
loop="1"
ramp="$2" #seconds


echo 'thread '$thread
echo 'loop '$loop
echo 'ramp '$ramp

sh jmeter/apache-jmeter-5.4.1/bin/jmeter.sh -n -t websocket-connections-test.jmx -Jthread=$thread  -Jloop=$loop -Jramp=$ramp -Jtoken=$token
