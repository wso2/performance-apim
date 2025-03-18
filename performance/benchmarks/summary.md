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
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 3355.9 | 29.68 | 16.01 | 89 | 98.58 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 3254.43 | 30.62 | 16.64 | 92 | 98.6 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 2496.84 | 39.88 | 19.93 | 108 | 98.83 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 724.14 | 137.87 | 33.56 | 227 | 99.31 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 3320.84 | 60.1 | 28.76 | 157 | 98.52 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 3398.1 | 58.74 | 27.53 | 150 | 98.5 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 2460.66 | 81.09 | 34.07 | 187 | 98.77 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 682.43 | 293.12 | 55.35 | 441 | 99.29 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 3353.39 | 148.96 | 60.1 | 327 | 98.22 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 3306.37 | 151.09 | 60.36 | 333 | 98.21 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 2553.97 | 195.61 | 63.85 | 381 | 98.54 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 656.15 | 761.63 | 104.87 | 1087 | 99.2 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 3152.08 | 317.23 | 109.37 | 623 | 97.58 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 3101.36 | 322.47 | 110.49 | 627 | 97.58 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 2427.83 | 411.83 | 107.01 | 707 | 98.13 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 633.03 | 1576.93 | 171 | 2127 | 99.05 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2579.63 | 38.66 | 22.47 | 122 | 98.11 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 2132.26 | 46.78 | 26.71 | 143 | 98.12 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 727.18 | 137.28 | 68.95 | 347 | 98.06 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 0 | 91.53 | 1091.46 | 231.49 | 1695 | 95.2 | 320 |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2641.34 | 75.59 | 37.37 | 200 | 97.96 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 2191.93 | 91.1 | 43.31 | 231 | 97.84 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 706.84 | 282.91 | 114.09 | 603 | 97.97 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 0 | 75.21 | 2652.83 | 515.59 | 4319 | 89.03 | 350.75 |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2669.13 | 187.22 | 74.68 | 411 | 97.38 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 2103.1 | 237.71 | 92.69 | 509 | 97.37 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 719.11 | 695.17 | 214.8 | 1279 | 97.38 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 0 | 70.57 | 7030.42 | 1148.02 | 9791 | 86.65 | 467.281 |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2468.52 | 405.1 | 134.97 | 787 | 96.6 |  |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 2069.65 | 482.99 | 156.87 | 915 | 96.43 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 675.71 | 1476.92 | 359.65 | 2527 | 95.21 |  |
|  Transformation | 2G | 1000 | 102400 | 0 | 0 | 58.83 | 16700.45 | 2327.34 | 23167 | 79.3 | 569.567 |
