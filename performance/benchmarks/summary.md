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
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 3381.57 | 29.48 | 32.01 | 156 | 98.04 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 3278.28 | 30.42 | 32.52 | 159 | 98.09 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 2527.26 | 39.45 | 25.63 | 104 | 98.27 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 805.54 | 123.9 | 23.15 | 191 | 98.78 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 3208.02 | 62.27 | 85.19 | 377 | 98 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 3200.5 | 62.36 | 59.33 | 287 | 98.04 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 2549.23 | 78.32 | 41.88 | 212 | 98.31 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 765.72 | 261.16 | 39.55 | 375 | 98.79 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 3244.75 | 153.95 | 298.76 | 1135 | 97.55 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 3319.95 | 150.48 | 220.35 | 1039 | 97.63 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 2507.62 | 199.25 | 73.68 | 489 | 98.09 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 698.4 | 715.63 | 77.27 | 971 | 98.79 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 3224.74 | 309.86 | 328.13 | 1399 | 97.27 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 3095.18 | 322.86 | 328.93 | 1423 | 97.23 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 2422.77 | 412.75 | 117.5 | 811 | 97.74 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 694 | 1439.06 | 133.9 | 1887 | 98.63 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2681.48 | 37.21 | 43.31 | 193 | 97.48 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 2167.19 | 46.05 | 52.77 | 228 | 97.44 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 843.74 | 118.28 | 133.03 | 907 | 97.41 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 0 | 113.77 | 878.48 | 114.83 | 1151 | 95.4 |  |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2676.57 | 74.64 | 86.82 | 419 | 97.25 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 2237.24 | 89.3 | 78.06 | 405 | 97.17 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 859.36 | 232.68 | 206.04 | 1399 | 97.15 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 0 | 87.21 | 2287.8 | 349.41 | 3567 | 91.3 | 379.909 |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2680.93 | 186.4 | 245.94 | 1143 | 96.57 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 2198.99 | 227.29 | 289.28 | 1359 | 96.45 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 835.81 | 597.94 | 388.82 | 2239 | 96.35 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 0 | 82.59 | 6020.77 | 807.44 | 7967 | 88.5 | 501.333 |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2377.38 | 420.37 | 413.86 | 1727 | 96.1 |  |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 1981.73 | 504.17 | 452.53 | 1991 | 95.94 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 731.64 | 1365.88 | 620.73 | 3359 | 95.88 |  |
|  Transformation | 2G | 1000 | 102400 | 0 | 0 | 66.7 | 14756.56 | 1956.51 | 21119 | 80.58 | 601.672 |
