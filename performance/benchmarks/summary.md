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
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 3213.01 | 31.01 | 16.18 | 90 | 98.73 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 3308.36 | 30.12 | 15.24 | 85 | 98.64 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 2413.03 | 41.25 | 20.09 | 109 | 98.93 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 715.63 | 139.5 | 32.86 | 227 | 99.39 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 3378.98 | 59.06 | 27.21 | 149 | 98.62 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 3235.35 | 61.69 | 28.32 | 155 | 98.63 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 2429.52 | 82.12 | 34.79 | 191 | 98.9 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 692.83 | 288.7 | 55.08 | 431 | 99.38 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 3242.01 | 154.09 | 62.62 | 341 | 98.39 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 3298.08 | 151.46 | 60.45 | 335 | 98.35 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 2426.09 | 205.92 | 66.06 | 393 | 98.7 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 642.15 | 778.2 | 115.28 | 1175 | 99.25 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 3178.67 | 314.57 | 107.07 | 619 | 97.87 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 3056.87 | 327.15 | 110.52 | 647 | 97.86 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 2387.84 | 418.79 | 107.65 | 719 | 98.28 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 623.01 | 1602.57 | 174.93 | 2159 | 99.12 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2504.58 | 39.81 | 21.96 | 120 | 98.23 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 2151.87 | 46.35 | 24.97 | 134 | 98.2 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 726.43 | 137.43 | 67.27 | 339 | 98.15 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 0 | 93.59 | 1067.45 | 223.28 | 1647 | 95.49 | 306 |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2516.49 | 79.34 | 39.14 | 208 | 98.13 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 2097.82 | 95.19 | 45.89 | 243 | 97.98 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 734.55 | 272.25 | 114.3 | 595 | 97.98 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 0 | 77.06 | 2589.45 | 476.59 | 4223 | 89.43 | 339.412 |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2518.17 | 198.45 | 78.7 | 433 | 97.68 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 2092.01 | 238.94 | 93.81 | 515 | 97.49 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 736.75 | 678.38 | 210.72 | 1247 | 96.96 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 0 | 71.71 | 6924.4 | 1117.67 | 9727 | 86.77 | 457.065 |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2526.38 | 395.83 | 132.54 | 771 | 96.67 |  |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 2053.18 | 487.01 | 159.79 | 927 | 96.07 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 706.05 | 1414.64 | 343.14 | 2351 | 96.57 |  |
|  Transformation | 2G | 1000 | 102400 | 0 | 0 | 63.2 | 15549.4 | 1717.72 | 20095 | 81.16 | 545.981 |
