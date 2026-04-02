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
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 3481.35 | 28.64 | 28.73 | 140 | 98.32 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 3451.67 | 28.89 | 25.69 | 112 | 98.34 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 2609.53 | 38.22 | 24.96 | 94 | 98.56 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 805.25 | 123.99 | 22.95 | 188 | 99.04 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 3402.57 | 58.7 | 57.64 | 305 | 98.25 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 3338.96 | 59.81 | 50.64 | 281 | 98.27 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 2608.11 | 76.56 | 41.81 | 188 | 98.48 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 757.88 | 263.91 | 39.82 | 373 | 99.03 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 3467.36 | 144.09 | 162.22 | 875 | 97.92 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 3312.96 | 150.84 | 201.76 | 975 | 97.93 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 2588.86 | 193.01 | 74.11 | 495 | 98.31 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 709.72 | 704.26 | 75.29 | 939 | 99.01 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 3317.76 | 301.2 | 275.96 | 1351 | 97.48 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 3250.4 | 307.44 | 274.67 | 1375 | 97.51 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 2565.53 | 389.86 | 113.58 | 775 | 98.02 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 689.68 | 1447.74 | 137.08 | 1927 | 98.89 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2643.57 | 37.74 | 38.15 | 158 | 97.81 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 2175.9 | 45.87 | 48.74 | 183 | 97.75 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 718.13 | 139.15 | 149.58 | 1023 | 97.93 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 0 | 94.83 | 1053.52 | 132.95 | 1367 | 95.97 |  |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2675.68 | 74.65 | 60.01 | 313 | 97.62 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 2164.33 | 92.32 | 75 | 409 | 97.6 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 720.95 | 277.43 | 226.02 | 1455 | 97.72 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 0 | 78.21 | 2550.49 | 338.33 | 3711 | 92.25 | 389.818 |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2667.95 | 187.34 | 116.44 | 651 | 97.07 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 2169.38 | 230.45 | 128.19 | 727 | 97.06 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 745.25 | 670.26 | 405 | 2255 | 97.01 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 0 | 73.65 | 6749.27 | 727.36 | 8511 | 90.27 | 489.963 |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2499.64 | 399.98 | 222.44 | 1335 | 96.51 |  |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 2050.07 | 487.86 | 226.44 | 1263 | 96.56 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 642.38 | 1553.56 | 646.24 | 3583 | 96.62 |  |
|  Transformation | 2G | 1000 | 102400 | 0 | 0 | 64.79 | 15169.77 | 1770.52 | 20095 | 82.52 | 595.435 |
