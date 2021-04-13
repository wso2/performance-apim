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
| Concurrent Users | The number of users accessing the application at the same time. | 100, 200, 300 |
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
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 2760.63 | 36.14 | 28.82 | 163 | 94.07 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 2719.94 | 36.69 | 29.36 | 160 | 93.96 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 1931.43 | 51.65 | 30.17 | 174 | 95.48 | 324 |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 2760.68 | 72.35 | 44.16 | 241 | 94 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 2674.86 | 74.69 | 43.87 | 245 | 93.96 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 1881.03 | 106.23 | 49.42 | 283 | 95.32 |  |
|  Passthrough | 2G | 300 | 50 | 0 | 0 | 2718.4 | 110.26 | 58.93 | 323 | 93.81 |  |
|  Passthrough | 2G | 300 | 1024 | 0 | 0 | 2640.48 | 113.52 | 57.62 | 321 | 94.01 |  |
|  Passthrough | 2G | 300 | 10240 | 0 | 0 | 1901.62 | 157.61 | 62.57 | 371 | 95.39 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2196.15 | 45.46 | 33.66 | 176 | 94.21 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 1819.72 | 54.88 | 37.39 | 198 | 94.1 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 694.42 | 143.9 | 70.89 | 361 | 95.18 |  |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2170.63 | 92.06 | 53.01 | 279 | 94.04 | 324 |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 1822.08 | 109.68 | 59.05 | 311 | 94.22 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 676.05 | 295.93 | 122.52 | 639 | 95.25 |  |
|  Transformation | 2G | 300 | 50 | 0 | 0 | 2228.98 | 134.5 | 67.19 | 353 | 93.77 |  |
|  Transformation | 2G | 300 | 1024 | 0 | 0 | 1831.59 | 163.7 | 76.81 | 405 | 93.86 |  |
|  Transformation | 2G | 300 | 10240 | 0 | 0 | 677.09 | 443.23 | 160.74 | 883 | 94.95 |  |
