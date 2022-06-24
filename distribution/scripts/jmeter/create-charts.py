#!/usr/bin/env python3.6
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
# Create charts from the summary.csv file
# ----------------------------------------------------------------------------
import matplotlib.pyplot as plt
import matplotlib.ticker as tkr
import pandas as pd
import seaborn as sns

import apimchart

sns.set_style("darkgrid")

df = pd.read_csv('summary.csv')
# Filter errors
df = df.loc[df['Error Count'] < 100]
# Format GraphQL query number values
df['GraphQL Query Number'] = df['GraphQL Query Number'].map(apimchart.format_query_number)

unique_sleep_times = df['Back-end Service Delay (ms)'].unique()
unique_query_numbers = df['GraphQL Query Number'].unique()


def save_line_chart(chart, column, title, ylabel=None):
    filename = chart + "_" + str(sleep_time) + "ms.png"
    print("Creating chart: " + title + ", File name: " + filename)
    fig, ax = plt.subplots()
    fig.subplots_adjust(bottom=0.3)
    fig.set_size_inches(8, 6)
    sns_plot = sns.pointplot(x="Concurrent Users", y=column, hue="GraphQL Query Number",
                             data=df.loc[df['Back-end Service Delay (ms)'] == sleep_time], ci=None, dodge=True)
    # ax.yaxis.set_major_formatter(tkr.FuncFormatter(lambda y, p: "{:,}".format(y)))
    plt.suptitle(title)
    # plt.title("Memory = " + df['Heap Size'][0] + ", Backend Service Delay = " + backendDelay + "ms")
    if ylabel is None:
        ylabel = column
    sns_plot.set(ylabel=ylabel)
    plt.legend(loc="lower center", frameon=True, title="GraphQL Query", bbox_to_anchor=(0.5, -0.4))
    plt.savefig(filename, dpi=1200)
    plt.clf()
    plt.close(fig)


def save_bar_chart(title):
    filename = "response_time_summary_" + query_number + "_" + str(sleep_time) + "ms.png"
    print("Creating chart: " + title + ", File name: " + filename)
    fig, ax = plt.subplots()
    fig.set_size_inches(8, 6)
    df_results = df.loc[(df['GraphQL Query Number'] == query_number) & (df['Back-end Service Delay (ms)'] == sleep_time)]
    df_results = df_results[
        ['GraphQL Query Number', 'Concurrent Users', 'Minimum Response Time (ms)', '90th Percentile of Response Time (ms)', '95th Percentile of Response Time (ms)',
         '99th Percentile of Response Time (ms)', 'Maximum Response Time (ms)']]
    df_results = df_results.set_index(['GraphQL Query Number', 'Concurrent Users']).stack().reset_index().rename(
        columns={'level_2': 'Summary', 0: 'Response Time (ms)'})
    sns.barplot(x='Concurrent Users', y='Response Time (ms)', hue='Summary', data=df_results, ci=None)
    ax.yaxis.set_major_formatter(tkr.FuncFormatter(lambda y, p: "{:,}".format(y)))
    plt.suptitle(title)
    plt.legend(loc=2, frameon=True, title="Response Time Summary")
    plt.savefig(filename, dpi=1200)
    plt.clf()
    plt.close(fig)


for sleep_time in unique_sleep_times:
    save_line_chart("thrpt", "Throughput (Requests/sec)", "Throughput (Requests/sec) vs Concurrent Users for " + str(sleep_time) + "ms backend delay",
                    ylabel="Throughput (Requests/sec)")
    save_line_chart("avgt", "Average Response Time (ms)",
                    "Average Response Time (ms) vs Concurrent Users for " + str(sleep_time) + "ms backend delay",
                    ylabel="Average Response Time (ms)")
    save_line_chart("gc", "WSO2 API Manager GC Throughput (%)",
                    "GC Throughput vs Concurrent Users for " + str(sleep_time) + "ms backend delay",
                    ylabel="GC Throughput (%)")
    for query_number in unique_query_numbers:
        save_bar_chart("Response Time Summary for\n" + query_number)

print("Done")
