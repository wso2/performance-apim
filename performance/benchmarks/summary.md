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
| Concurrent Users | The number of users accessing the application at the same time. | 50, 100, 200, 300, 500, 1000 |
| Message Size (Bytes) | The request payload size in Bytes. | 50, 1024, 10240 |
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
|  Passthrough | 2G | 50 | 50 | 0 | 0 | 2513.2 | 19.8 | 18.83 | 98 | 95.14 |  |
|  Passthrough | 2G | 50 | 1024 | 0 | 0 | 2517.54 | 19.76 | 18.56 | 96 | 95.15 |  |
|  Passthrough | 2G | 50 | 10240 | 0 | 0 | 1882.62 | 26.43 | 17.99 | 90 | 96.2 |  |
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 2663.16 | 37.44 | 29.07 | 161 | 94.61 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 2592.37 | 38.47 | 28.47 | 157 | 95.14 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 1864.5 | 53.49 | 29.27 | 167 | 96.2 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 2686.34 | 74.32 | 45.51 | 252 | 94.4 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 2596.7 | 76.91 | 44.65 | 259 | 94.82 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 1825.08 | 109.42 | 48.02 | 273 | 96.13 |  |
|  Passthrough | 2G | 300 | 50 | 0 | 0 | 2708.07 | 110.64 | 58.44 | 323 | 94.58 |  |
|  Passthrough | 2G | 300 | 1024 | 0 | 0 | 2584.11 | 115.99 | 59.07 | 327 | 94.6 |  |
|  Passthrough | 2G | 300 | 10240 | 0 | 0 | 1815.75 | 165.08 | 64.28 | 373 | 96.14 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 2653.97 | 188.29 | 83.89 | 453 | 94.62 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 2533.79 | 197.24 | 82.49 | 457 | 94.78 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 1800.92 | 277.66 | 94.84 | 555 | 96.05 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 2543.98 | 393.09 | 142.06 | 787 | 94.21 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 2497.17 | 400.39 | 139.6 | 791 | 94.31 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 1768.41 | 565.27 | 158.5 | 979 | 95.76 |  |
|  Transformation | 2G | 50 | 50 | 0 | 0 | 212.92 | 234.73 | 29.86 | 301 | 97.25 |  |
|  Transformation | 2G | 50 | 1024 | 0 | 0 | 208.79 | 239.42 | 31.8 | 309 | 97.19 |  |
|  Transformation | 2G | 50 | 10240 | 0 | 0 | 180.56 | 277.14 | 56.5 | 363 | 97.34 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 219.98 | 454.69 | 56.62 | 555 | 96.92 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 211.17 | 473.62 | 57.94 | 571 | 96.93 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 181.28 | 551.55 | 107.45 | 679 | 97.27 |  |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 214.19 | 932.96 | 97.56 | 1079 | 96.67 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 209.35 | 954.61 | 108.34 | 1103 | 96.72 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 178.69 | 1117.88 | 207.24 | 1319 | 96.86 |  |
|  Transformation | 2G | 300 | 50 | 0 | 0 | 214.27 | 1397.85 | 155.97 | 1567 | 96.32 |  |
|  Transformation | 2G | 300 | 1024 | 0 | 0 | 210.16 | 1424.94 | 167.86 | 1615 | 96.39 |  |
|  Transformation | 2G | 300 | 10240 | 0 | 0 | 184.9 | 1618.89 | 311.23 | 1879 | 96.43 |  |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 219.06 | 2275.69 | 175.98 | 2511 | 95.9 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 210.89 | 2363.2 | 193.8 | 2639 | 95.95 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 184.72 | 2696.56 | 352.88 | 3007 | 95.95 |  |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 214.71 | 4626.46 | 211.84 | 5279 | 95.08 |  |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 209.06 | 4750.59 | 210.36 | 5087 | 95.28 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 172.02 | 5766.49 | 629.55 | 7263 | 94.03 |  |

The following figure shows how the Throughput changes for different number of concurrent users.

![picture](all-comparison-plots/throughput-2G-0ms.png)
![picture](all-comparison-plots/throughput-concurrent-users-2G.png)

The following figure shows how the Average Response Time changes for different number of concurrent users.

![picture](all-comparison-plots/average-response-time-2G-0ms.png)
![picture](all-comparison-plots/average-response-time-concurrent-users-2G.png)

Let’s look at the 90th, 95th, and 99th Response Time percentiles. This is useful to measure the percentage of requests that exceeded the response time value for a given percentile. A percentile can also tell the percentage of requests completed below the particular response time value.

![picture](all-comparison-plots/percentiles_response_time_0ms.png.png)

The GC Throughput was calculated for each test to check whether GC operations are not impacting the performance of the server. The GC Throughput is the time percentage of the application, which was not busy with GC operations.

![picture](all-comparison-plots/gc_0ms.png)
