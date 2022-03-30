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
|  Passthrough | 2G | 50 | 50 | 0 | 0 | 2647.85 | 18.79 | 19.26 | 101 | 94.55 |  |
|  Passthrough | 2G | 50 | 1024 | 0 | 0 | 2595.11 | 19.18 | 19.81 | 96 | 94.71 |  |
|  Passthrough | 2G | 50 | 10240 | 0 | 0 | 1879.07 | 26.49 | 18.88 | 97 | 95.96 |  |
|  Passthrough | 2G | 50 | 102400 | 0 | 0 | 508.01 | 98.24 | 23.53 | 179 | 98.54 |  |
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 2734.75 | 36.47 | 27.61 | 161 | 94.63 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 2659.74 | 37.49 | 28.14 | 168 | 94.44 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 1882.89 | 52.97 | 30.33 | 170 | 96.23 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 497.57 | 200.78 | 38.22 | 333 | 98.56 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 2716.11 | 73.52 | 43.67 | 237 | 94.24 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 2649.99 | 75.36 | 44.83 | 249 | 94.18 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 1866.09 | 107.02 | 49.03 | 283 | 95.93 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 481.58 | 415.43 | 59.97 | 599 | 98.55 |  |
|  Passthrough | 2G | 300 | 50 | 0 | 0 | 2735.95 | 109.52 | 55.08 | 297 | 94.44 |  |
|  Passthrough | 2G | 300 | 1024 | 0 | 0 | 2566.25 | 116.78 | 57.31 | 313 | 94.57 |  |
|  Passthrough | 2G | 300 | 10240 | 0 | 0 | 1880.64 | 159.37 | 63.21 | 375 | 95.99 |  |
|  Passthrough | 2G | 300 | 102400 | 0 | 0 | 475.81 | 630.38 | 78.46 | 867 | 98.51 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 2677.21 | 186.68 | 79.47 | 433 | 94.32 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 2605.17 | 191.83 | 79.89 | 443 | 94.58 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 1829.83 | 273.27 | 91.84 | 555 | 95.61 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 467 | 1069.81 | 110.75 | 1383 | 98.47 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 2628.44 | 380.35 | 129.9 | 735 | 93.7 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 2524.61 | 396.08 | 130.28 | 751 | 94.17 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 1839.03 | 543.49 | 139.78 | 907 | 95.72 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 460.11 | 2168.65 | 191.74 | 2719 | 98.25 |  |
|  Transformation | 2G | 50 | 50 | 0 | 0 | 2084.56 | 23.89 | 22.65 | 127 | 94.28 |  |
|  Transformation | 2G | 50 | 1024 | 0 | 0 | 1771.81 | 28.12 | 23.82 | 133 | 94.88 |  |
|  Transformation | 2G | 50 | 10240 | 0 | 0 | 724.81 | 68.81 | 38.6 | 197 | 95.6 |  |
|  Transformation | 2G | 50 | 102400 | 0 | 100 | 23884.11 | 1.61 | 1.35 | 6 | 96.9 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2130.2 | 46.84 | 34.83 | 181 | 94.32 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 1801.18 | 55.41 | 36.75 | 194 | 94.72 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 715.25 | 139.65 | 68.48 | 347 | 95.65 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 99.3 | 8593 | 10.74 | 88.69 | 25 | 95.97 |  |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2176.49 | 91.77 | 52.01 | 275 | 94.37 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 1771.24 | 112.8 | 59.51 | 315 | 94.62 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 690.74 | 289.52 | 120.01 | 627 | 95.45 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 0.01 | 55.78 | 3579.58 | 13403.91 | 7199 | 94.51 |  |
|  Transformation | 2G | 300 | 50 | 0 | 0 | 2160.48 | 138.75 | 67.56 | 355 | 94.15 |  |
|  Transformation | 2G | 300 | 1024 | 0 | 0 | 1750.53 | 171.27 | 79.26 | 417 | 94.16 |  |
|  Transformation | 2G | 300 | 10240 | 0 | 0 | 671.75 | 446.66 | 160.78 | 887 | 95.56 |  |
|  Transformation | 2G | 300 | 102400 | 0 | 99.88 | 16493.5 | 14.93 | 146.48 | 57 | 92.85 |  |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2162.17 | 231.21 | 94.58 | 511 | 93.73 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 1778.18 | 281.24 | 108.09 | 587 | 94.41 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 684.71 | 729.95 | 226.7 | 1343 | 95.24 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 100 | 23055.41 | 15.71 | 19.26 | 97 | 95.85 |  |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2047.62 | 488.34 | 151.61 | 895 | 93.13 |  |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 1707.69 | 585.41 | 176.35 | 1063 | 93.66 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 642.49 | 1552.86 | 340.91 | 2495 | 94.44 |  |
|  Transformation | 2G | 1000 | 102400 | 0 | 100 | 22274.36 | 31.55 | 35.57 | 172 | 98.29 |  |
