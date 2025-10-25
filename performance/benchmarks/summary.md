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
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 3772 | 26.42 | 24.82 | 109 | 98.61 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 3620.99 | 27.53 | 29.18 | 142 | 98.64 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 2812.07 | 35.45 | 25.07 | 91 | 98.9 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 847.17 | 117.83 | 15.95 | 162 | 99.37 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 3699.03 | 53.98 | 54.63 | 289 | 98.51 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 3637.33 | 54.89 | 43.11 | 210 | 98.55 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 2843.02 | 70.22 | 40.64 | 169 | 98.82 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 790.76 | 252.86 | 24.07 | 319 | 99.37 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 3661.33 | 136.45 | 227.88 | 999 | 98.11 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 3625.61 | 137.8 | 98.84 | 579 | 98.27 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 2796.72 | 178.62 | 72.55 | 489 | 98.63 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 738.81 | 676.51 | 42.3 | 791 | 99.35 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 3606.37 | 277.08 | 262.48 | 1287 | 97.63 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 3531.54 | 283.02 | 229.94 | 1255 | 97.71 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 2697.1 | 370.8 | 115.2 | 791 | 98.12 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 736.33 | 1356.38 | 106.57 | 1767 | 99.11 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2896.09 | 34.44 | 37.33 | 150 | 98.06 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 2320.85 | 43 | 46.25 | 172 | 98.07 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 780.94 | 127.93 | 138.8 | 911 | 98.18 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 0 | 96.63 | 1034.15 | 133.98 | 1359 | 95.57 |  |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2855.63 | 69.94 | 62.63 | 289 | 97.98 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 2303.91 | 86.71 | 73.57 | 365 | 97.86 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 815.7 | 245.15 | 205.31 | 1343 | 97.87 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 0 | 75.11 | 2653.83 | 484.5 | 4319 | 88.2 | 363.926 |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2890.64 | 172.87 | 119.4 | 691 | 97.35 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 2340.4 | 213.58 | 126.89 | 719 | 97.19 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 771.72 | 647.57 | 382.96 | 2239 | 97.18 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 0 | 71.49 | 6938.64 | 843.65 | 8831 | 86.17 | 472.029 |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2799.29 | 357.25 | 172.78 | 971 | 95.84 |  |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 2241.49 | 446.06 | 211.35 | 1183 | 96.02 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 642.51 | 1554.03 | 706.98 | 3759 | 93.2 |  |
|  Transformation | 2G | 1000 | 102400 | 0 | 0 | 57.16 | 17114.72 | 2036.53 | 22399 | 76.41 | 583.935 |
