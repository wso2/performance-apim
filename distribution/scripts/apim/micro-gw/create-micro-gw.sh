#!/usr/bin/expect
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
# Setup WSO2 API Microgateway Project
# ----------------------------------------------------------------------------
spawn micro-gw import echo-mgw -a echo -v 1.0.0
expect -exact "Enter Username:"
send -- "admin\r"
expect -exact "Enter Password for admin:"
send -- "admin\r"
expect -exact "Enter APIM base URL: \[https://localhost:9443/\]"
send -- "\r"
expect -exact "Enter Trust store location:"
send -- "\r"
expect -exact "Enter Trust store password:"
send -- "\r"
expect eof
