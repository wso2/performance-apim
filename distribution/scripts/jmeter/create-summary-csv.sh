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
# Create a summary report from JMeter results
# ----------------------------------------------------------------------------

filename="summary.csv"
if [[ ! -f $filename ]]; then
    # Create File and save headers
    echo -n "Message Size","Sleep Time","Concurrent Users", > $filename
    echo -n "#Samples","KO","Error %","Average","Min","Max", >> $filename
    echo -n "90th pct","95th pct","99th pct","Throughput", >> $filename
    echo "Received","Sent" >> $filename
else
    echo "$filename already exists"
    exit 1
fi

write_column() {
    statisticsTableData=$1
    index=$2
    last_column=$3
    echo -n "$(echo $statisticsTableData | jq -r ".overall | .data[$index]")" >> $filename
    if [ "$last_column" = true ] ; then
        echo -ne "\r\n" >> $filename
    else
        echo -n "," >> $filename
    fi
}

for dashboard_dir in $(find . -name 'dashboard-measurement')
do 
    statisticsTableData=$(grep '#statisticsTable' $dashboard_dir/content/js/dashboard.js | sed  's/^.*"#statisticsTable"), \({.*}\).*$/\1/')
    echo -ne "Processing $dashboard_dir                                                         \r"
    message_size=$(echo $dashboard_dir | sed -r 's/.\/([0-9]+)B.*/\1/')
    sleep_time=$(echo $dashboard_dir | sed -r 's/.*\/([0-9]+)s_sleep.*/\1/')
    concurrent_users=$(($(echo $dashboard_dir | sed -r 's/.*\/([0-9]+)_users.*/\1/') * 2))
    echo -n $message_size,$sleep_time,$concurrent_users, >> $filename
    write_column "$statisticsTableData" 1 false
    write_column "$statisticsTableData" 2 false
    write_column "$statisticsTableData" 3 false
    write_column "$statisticsTableData" 4 false
    write_column "$statisticsTableData" 5 false
    write_column "$statisticsTableData" 6 false
    write_column "$statisticsTableData" 7 false
    write_column "$statisticsTableData" 8 false
    write_column "$statisticsTableData" 9 false
    write_column "$statisticsTableData" 10 false
    write_column "$statisticsTableData" 11 false
    write_column "$statisticsTableData" 12 true
done

# Add whitespace to clear progress information
echo "Created $filename.                                                                          "
