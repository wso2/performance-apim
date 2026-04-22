# WSO2 API Manager AI API Performance Test Results

During each release, we execute various automated performance test scenarios and publish the results.

| Test Scenarios | Description |
| --- | --- |
| AI API Direct | Direct invocation of the mock AI backend, bypassing the API gateway. |
| AI API Passthrough | AI API invocation through the API gateway to the mock AI backend. |

Our test client is [Apache JMeter](https://jmeter.apache.org/index.html). We test each scenario for a fixed duration of
time. We split the test results into warmup and measurement parts and use the measurement part to compute the
performance metrics.

Test scenarios use a [Netty](https://netty.io/) based back-end service which echoes back any request
posted to it after a specified period of time.

We run the performance tests under different numbers of concurrent users, message sizes (payloads), response sizes and back-end service
delays.

The main performance metrics:

1. **Throughput**: The number of requests that the WSO2 API Manager AI API processes during a specific time interval (e.g. per second).
2. **Response Time**: The end-to-end latency for an operation of invoking an API. The complete distribution of response times was recorded.

In addition to the above metrics, we measure the load average and several memory-related metrics.

The following are the test parameters.

| Test Parameter | Description | Values |
| --- | --- | --- |
| Scenario Name | The name of the test scenario. | Refer to the above table. |
| Heap Size | The amount of memory allocated to the application | 2G |
| Concurrent Users | The number of users accessing the application at the same time. | 100, 500 |
| Message Size (Bytes) | The request payload size in Bytes. | 256, 1024 |

| Response Size (Bytes) | The back-end response payload size in Bytes. | 1024, 102400 |

| Back-end Delay (ms) | The delay added by the back-end service. | 0 |

The duration of each test is **900 seconds**. The warm-up period is **300 seconds**.
The measurement results are collected after the warm-up period.

A [**c5.large** Amazon EC2 instance](https://aws.amazon.com/ec2/instance-types/) was used to install WSO2 API Manager AI API.

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

|  Scenario Name | Heap Size | Concurrent Users | Message Size (Bytes) | Response Size (Bytes) | Back-end Service Delay (ms) | Error % | Throughput (Requests/sec) | Average Response Time (ms) | Standard Deviation of Response Time (ms) | 99th Percentile of Response Time (ms) | WSO2 API Manager GC Throughput (%) | Average WSO2 API Manager Memory Footprint After Full GC (M) |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
|  AI API Direct | 2G | 100 | 256 | 1024 | 0 | 0 | 25912.45 | 2.46 | 5.73 | 35 |  |  |
|  AI API Direct | 2G | 100 | 256 | 102400 | 0 | 0 | 26398.18 | 2.41 | 5.58 | 35 |  |  |
|  AI API Direct | 2G | 100 | 1024 | 1024 | 0 | 0 | 4657.13 | 21.3 | 6.45 | 42 |  |  |
|  AI API Direct | 2G | 100 | 1024 | 102400 | 0 | 0 | 26062.29 | 2.54 | 5.58 | 34 |  |  |
|  AI API Direct | 2G | 500 | 256 | 1024 | 0 | 0 | 4616.1 | 107.91 | 19.77 | 211 |  |  |
|  AI API Direct | 2G | 500 | 256 | 102400 | 0 | 0 | 25597.85 | 7.67 | 48.83 | 301 |  |  |
|  AI API Direct | 2G | 500 | 1024 | 1024 | 0 | 0 | 4601.42 | 108.2 | 20.01 | 212 |  |  |
|  AI API Direct | 2G | 500 | 1024 | 102400 | 0 | 0 | 23925.67 | 7.96 | 51.63 | 305 |  |  |
|  AI API Passthrough | 2G | 100 | 256 | 1024 | 0 | 0 | 2251.17 | 44.37 | 66.9 | 279 |  |  |
|  AI API Passthrough | 2G | 100 | 256 | 102400 | 0 | 0 | 2239.88 | 44.6 | 67.13 | 281 |  |  |
|  AI API Passthrough | 2G | 100 | 1024 | 1024 | 0 | 0 | 180.93 | 552.33 | 321.27 | 1111 |  |  |
|  AI API Passthrough | 2G | 100 | 1024 | 102400 | 0 | 0 | 2233.26 | 44.72 | 66.81 | 279 |  |  |
|  AI API Passthrough | 2G | 500 | 256 | 1024 | 0 | 0 | 296.62 | 1680.35 | 828.17 | 3327 |  |  |
|  AI API Passthrough | 2G | 500 | 256 | 102400 | 0 | 0 | 2107.54 | 237.11 | 357.24 | 1439 |  |  |
|  AI API Passthrough | 2G | 500 | 1024 | 1024 | 0 | 0 | 205.81 | 2419.88 | 1123.8 | 4351 |  |  |
|  AI API Passthrough | 2G | 500 | 1024 | 102400 | 0 | 0 | 2243.89 | 222.71 | 366.26 | 1503 |  |  |
