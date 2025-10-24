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
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 3729.37 | 26.73 | 27.62 | 134 | 98.6 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 3645.75 | 27.34 | 25.11 | 117 | 98.65 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 2769.19 | 36 | 24.65 | 89 | 98.92 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 816.73 | 122.24 | 16.54 | 168 | 99.4 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 3667.12 | 54.45 | 47.04 | 239 | 98.54 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 3556.11 | 56.14 | 42.7 | 221 | 98.59 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 2755.94 | 72.45 | 41.15 | 176 | 98.85 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 784.58 | 254.89 | 25.08 | 325 | 99.4 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 3666.65 | 136.22 | 264.76 | 1039 | 98.16 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 3599.34 | 138.83 | 167.22 | 871 | 98.24 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 2777.52 | 179.86 | 73.85 | 499 | 98.62 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 756.98 | 660.33 | 46.53 | 799 | 99.28 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 3530.35 | 283.04 | 306.39 | 1343 | 97.38 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 3507.44 | 284.95 | 228.9 | 1223 | 97.54 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 2764.47 | 361.69 | 105.57 | 731 | 98.31 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 723.72 | 1380 | 114.12 | 1823 | 99.14 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2913.59 | 34.23 | 37.69 | 144 | 98.09 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 2299.35 | 43.4 | 47.4 | 173 | 98.08 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 783.26 | 127.53 | 146.82 | 967 | 98.2 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 0 | 95.92 | 1041.76 | 148.01 | 1391 | 95.24 | 327 |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2895.1 | 68.99 | 59.88 | 309 | 97.92 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 2295.96 | 87.01 | 75.04 | 389 | 97.92 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 780.99 | 256.03 | 216.07 | 1415 | 97.99 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 0 | 76.08 | 2620.16 | 481.96 | 4255 | 88.36 | 367.75 |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2889.62 | 172.92 | 143.98 | 823 | 97.32 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 2346.34 | 213.05 | 128.03 | 727 | 97.26 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 773.18 | 646.63 | 373.62 | 2159 | 97.25 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 0 | 71.56 | 6943.75 | 854.73 | 8959 | 86.21 | 476.657 |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2769.12 | 361.17 | 185.89 | 1095 | 96.27 |  |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 2244.86 | 445.37 | 218.56 | 1207 | 95.91 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 679.31 | 1469.05 | 641.37 | 3439 | 94.8 |  |
|  Transformation | 2G | 1000 | 102400 | 0 | 0 | 56.1 | 17497.68 | 4294.29 | 40447 | 76.77 | 581.527 |
