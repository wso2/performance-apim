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
| Message Size (Bytes) | The request payload size in Bytes. | 50, 102400 |
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
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 2193.5 | 45.51 | 41.36 | 146 | N/A | N/A |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 443.55 | 225.3 | 42.73 | 349 | N/A | N/A |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 2092.53 | 95.49 | 60.95 | 265 | N/A | N/A |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 411.96 | 485.48 | 120.75 | 791 | N/A | N/A |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 220.4 | 2256.5 | 8117.22 | 44031 | N/A | N/A |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 432.8 | 1154.16 | 111.73 | 1487 | N/A | N/A |
|  Passthrough | 2G | 1000 | 50 | 0 | 0.04 | 106.51 | 9320.01 | 23899.71 | 147455 | N/A | N/A |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 424.12 | 2352.36 | 209.18 | 2943 | N/A | N/A |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 1517.76 | 65.82 | 89.62 | 603 | N/A | N/A |
|  Transformation | 2G | 100 | 102400 | 0 | 0 | 56.61 | 1763.53 | 386.98 | 2767 | N/A | N/A |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 1356.43 | 147.38 | 180.29 | 1003 | N/A | N/A |
|  Transformation | 2G | 200 | 102400 | 0 | 0 | 52.42 | 3800.54 | 477.04 | 4863 | N/A | N/A |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 1101.5 | 453.96 | 413.27 | 1879 | N/A | N/A |
|  Transformation | 2G | 500 | 102400 | 0 | 0 | 47.08 | 10510.65 | 780.11 | 12159 | N/A | N/A |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 1289.15 | 775.53 | 459.64 | 2367 | N/A | N/A |
|  Transformation | 2G | 1000 | 102400 | 0 | 0 | 36.22 | 26797.06 | 2606.12 | 33279 | N/A | N/A |
