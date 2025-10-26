# WSO2 API Manager Performance Test Results

During each release, we execute various automated performance test scenarios and publish the results.

| Test Scenarios | Description |
| --- | --- |
| Passthrough | A secured API, which directly invokes the back-end service. |
| Transformation | A secured API, which has a mediation extension to modify the message. |

Our test client is [Apache JMeter](https://jmeter.apache.org/index.html). We test each scenario for a fixed duration of
time. We split the test results into warmup and measurement parts and use the measurement part to compute the
performance metrics.

Test scenarios use a [Netty](https://netty.io/) based back-end service which echoes back any request
posted to it after a specified period of time.

We run the performance tests under different numbers of concurrent users, message sizes (payloads) and back-end service
delays.

The main performance metrics:

1. **Throughput**: The number of requests that the WSO2 API Manager processes during a specific time interval (e.g. per second).
2. **Response Time**: The end-to-end latency for an operation of invoking an API. The complete distribution of response times was recorded.

In addition to the above metrics, we measure the load average and several memory-related metrics.

The following are the test parameters.

| Test Parameter | Description | Values |
| --- | --- | --- |
| Scenario Name | The name of the test scenario. | Refer to the above table. |
| Heap Size | The amount of memory allocated to the application | 2G |
| Concurrent Users | The number of users accessing the application at the same time. | 100, 200, 500, 1000 |
| Message Size (Bytes) | The request payload size in Bytes. | 50, 1024, 10240, 102400 |
| Back-end Delay (ms) | The delay added by the back-end service. | 0 |

The duration of each test is **900 seconds**. The warm-up period is **300 seconds**.
The measurement results are collected after the warm-up period.

A [**c5.large** Amazon EC2 instance](https://aws.amazon.com/ec2/instance-types/) was used to install WSO2 API Manager.

The following are the measurements collected from each performance test conducted for a given combination of
test parameters.

| Measurement | Description |
| --- | --- |
| Error % | Percentage of requests with errors |
| Average Response Time (ms) | The average response time of a set of results |
| Standard Deviation of Response Time (ms) | The “Standard Deviation” of the response time. |
| 99th Percentile of Response Time (ms) | 99% of the requests took no more than this time. The remaining samples took at least as long as this |
| Throughput (Requests/sec) | The throughput measured in requests per second. |
| Average Memory Footprint After Full GC (M) | The average memory consumed by the application after a full garbage collection event. |

The following is the summary of performance test results collected for the measurement period.

|  Scenario Name | Heap Size | Concurrent Users | Message Size (Bytes) | Back-end Service Delay (ms) | Error % | Throughput (Requests/sec) | Average Response Time (ms) | Standard Deviation of Response Time (ms) | 99th Percentile of Response Time (ms) | WSO2 API Manager GC Throughput (%) | Average WSO2 API Manager Memory Footprint After Full GC (M) |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 3810.01 | 26.17 | 24.23 | 105 | 98.62 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 3697.02 | 26.96 | 25.03 | 118 | 98.6 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 2797.62 | 35.64 | 24.48 | 88 | 98.89 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 838.13 | 119.11 | 16.52 | 166 | 99.43 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 3699.93 | 53.96 | 49.36 | 263 | 98.53 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 3601.17 | 55.44 | 43.78 | 217 | 98.58 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 2816.8 | 70.88 | 44.23 | 224 | 98.84 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 787.42 | 253.96 | 24.02 | 321 | 99.4 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 3653.29 | 136.74 | 268.04 | 1047 | 98.12 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 3624.33 | 137.86 | 139.72 | 771 | 98.26 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 2780.5 | 179.67 | 72.62 | 493 | 98.65 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 730.32 | 684.42 | 58.42 | 911 | 99.32 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 3635.83 | 274.82 | 302.46 | 1335 | 97.66 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 3485.02 | 286.92 | 179.48 | 1079 | 97.55 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 2739.27 | 365.05 | 108.05 | 767 | 98.33 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 715.39 | 1396.01 | 108.09 | 1823 | 99.15 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2874.32 | 34.7 | 36.16 | 141 | 98.09 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 2282.85 | 43.72 | 49.4 | 185 | 98.16 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 775.3 | 128.81 | 137.29 | 811 | 98.2 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 0 | 95.77 | 1043.18 | 132.36 | 1359 | 95.8 |  |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2801.35 | 71.3 | 61.08 | 315 | 97.98 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 2285.98 | 87.39 | 73.91 | 381 | 97.89 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 787.54 | 253.92 | 222.3 | 1455 | 98.03 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 0 | 75.92 | 2628.19 | 491.55 | 4319 | 88.47 | 366.148 |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2896.72 | 172.52 | 104.06 | 615 | 97.37 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 2312.61 | 216.17 | 127.79 | 715 | 97.27 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 771.58 | 647.94 | 385.18 | 2255 | 97.2 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 0 | 74.61 | 6662.14 | 854.38 | 8767 | 86.6 | 475.057 |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2767.96 | 361.39 | 176.53 | 999 | 95.88 |  |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 2208.15 | 452.99 | 227.76 | 1287 | 95.67 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 687.42 | 1452.48 | 654.99 | 3375 | 94.23 |  |
|  Transformation | 2G | 1000 | 102400 | 0 | 0.01 | 56.53 | 17388.67 | 4269.6 | 39423 | 78.7 | 580.224 |
