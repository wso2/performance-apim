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

A [**c5.xlarge** Amazon EC2 instance](https://aws.amazon.com/ec2/instance-types/) was used to install WSO2 API Manager.

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
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 4499.56 | 22.15 | 41.34 | 111 | N/A | N/A |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 1042.72 | 95.54 | 20.82 | 154 | N/A | N/A |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 32.22 | 6082.86 | 7264 | 33023 | N/A | N/A |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 1043.11 | 191.49 | 30.86 | 275 | N/A | N/A |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 38.97 | 12756 | 11803.78 | 52735 | N/A | N/A |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 978.91 | 510.77 | 57.71 | 667 | N/A | N/A |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 3068.31 | 325.63 | 385.56 | 1791 | N/A | N/A |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 934.9 | 1068.77 | 98.41 | 1327 | N/A | N/A |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 3295.4 | 30.28 | 65.9 | 240 | N/A | N/A |
|  Transformation | 2G | 100 | 102400 | 0 | 0 | 91.34 | 1094.08 | 276.1 | 1687 | N/A | N/A |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 3056.3 | 65.36 | 111.18 | 627 | N/A | N/A |
|  Transformation | 2G | 200 | 102400 | 0 | 0 | 83.75 | 2384.17 | 417.35 | 3327 | N/A | N/A |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2781 | 179.59 | 389.09 | 1639 | N/A | N/A |
|  Transformation | 2G | 500 | 102400 | 0 | 0 | 74.41 | 6678.16 | 722.26 | 8447 | N/A | N/A |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2701.2 | 369.86 | 402.06 | 1719 | N/A | N/A |
|  Transformation | 2G | 1000 | 102400 | 0 | 0 | 63.34 | 15503.7 | 1427.32 | 18815 | N/A | N/A |
