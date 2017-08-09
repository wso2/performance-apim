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

for message_size_dir in $(find . -maxdepth 1 -name '*B' | sort -V)
do
    for sleep_time_dir in $(find $message_size_dir -maxdepth 1 -name '*s_sleep' | sort -V)
    do
        for user_dir in $(find $sleep_time_dir -maxdepth 1 -name '*_users' | sort -V)
        do
            dashboard_data_file=$user_dir/dashboard-measurement/content/js/dashboard.js
            if [[ ! -f $dashboard_data_file ]]; then
                echo "WARN: Dashboard data file not found: $dashboard_data_file"
                exit 1
            fi
            statisticsTableData=$(grep '#statisticsTable' $dashboard_data_file | sed  's/^.*"#statisticsTable"), \({.*}\).*$/\1/')
            echo "Getting data from $dashboard_data_file"
            message_size=$(echo $message_size_dir | sed -r 's/.\/([0-9]+)B.*/\1/')
            sleep_time=$(echo $sleep_time_dir | sed -r 's/.*\/([0-9]+)s_sleep.*/\1/')
            concurrent_users=$(($(echo $user_dir | sed -r 's/.*\/([0-9]+)_users.*/\1/') * 2))
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
    done
done

echo "Completed. Open $filename."
