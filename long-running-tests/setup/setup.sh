#!/bin/bash -e
# Copyright (c) 2022, WSO2 LLC (http://wso2.org)
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
# Setup WSO2 API Manager for Long Running Tests
# ----------------------------------------------------------------------------

script_dir=$(dirname "$0")
apim_host=""
backend_endpoint_url=""
vhost=""

function usage() {
    echo ""
    echo "Usage: "
    echo "$0 -a <apim_host> -b <backend_endpoint_url> -v <vhost> [-h]"
    echo ""
    echo "-a: Hostname of WSO2 API Manager."
    echo "-b: Backend endpoint URL."
    echo "-v: Virtual Host (VHost)"
    echo "-h: Display this help and exit."
    echo ""
}

while getopts "a:b:v:h" opt; do
    case "${opt}" in
    a)
        apim_host=${OPTARG}
        ;;
    b)
        backend_endpoint_url=${OPTARG}
        ;;
    v)
        vhost=${OPTARG}
        ;;
    h)
        usage
        exit 0
        ;;
    \?)
        usage
        exit 1
        ;;
    *)
        opts+=("-${opt}")
        [[ -n "$OPTARG" ]] && opts+=("$OPTARG")
        ;;
    esac
done
shift "$((OPTIND - 1))"

mkdir -p "$script_dir/target"

## Create Applications
$script_dir/create-apps.sh -a $apim_host -n 5 -k JWT

## Create APIs
$script_dir/create-api.sh -a $apim_host -i 5 -n sample -d desc -b $backend_endpoint_url -v $vhost

## Create API with Mediation Sequence
$script_dir/create-api.sh -a $apim_host -i 1 -n mediationSample -d mediationDesc \
    -b $backend_endpoint_url -v $vhost -o mediation-api-sequence.xml

## Generate JWT Tokens
$script_dir/generate-jwt-tokens.sh -a $apim_host -t 1000
