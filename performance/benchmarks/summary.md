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

| Back-end Delay (ms) | The delay added by the back-end service. | 10 |

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
|  AI API Direct | 2G | 100 | 256 | 1024 | 10 | 0 | 9567.57 | 10.4 | 1.18 | 11 |  |  |
|  AI API Direct | 2G | 100 | 256 | 102400 | 10 | 0 | 9570.14 | 10.41 | 1.16 | 11 |  |  |
|  AI API Direct | 2G | 100 | 1024 | 1024 | 10 | 0 | 7573.56 | 13.03 | 1.73 | 20 |  |  |
|  AI API Direct | 2G | 100 | 1024 | 102400 | 10 | 0 | 9571.04 | 10.41 | 1.16 | 11 |  |  |
|  AI API Direct | 2G | 500 | 256 | 1024 | 10 | 0 | 8401.07 | 58.4 | 19.21 | 113 |  |  |
|  AI API Direct | 2G | 500 | 256 | 102400 | 10 | 0 | 42731 | 11.39 | 3.82 | 36 |  |  |
|  AI API Direct | 2G | 500 | 1024 | 1024 | 10 | 0 | 8445.78 | 58.09 | 18.66 | 111 |  |  |
|  AI API Direct | 2G | 500 | 1024 | 102400 | 10 | 0 | 42648.57 | 11.41 | 3.82 | 36 |  |  |
|  AI API Passthrough | 2G | 100 | 256 | 1024 | 10 | 0 | 2141.57 | 46.65 | 48.23 | 217 |  |  |
|  AI API Passthrough | 2G | 100 | 256 | 102400 | 10 | 0 | 2204.4 | 45.32 | 47.12 | 219 |  |  |
|  AI API Passthrough | 2G | 100 | 1024 | 1024 | 10 | 0 | 198.28 | 504.13 | 292.23 | 1019 |  |  |
|  AI API Passthrough | 2G | 100 | 1024 | 102400 | 10 | 0 | 2169.43 | 46.04 | 48.03 | 221 |  |  |
|  AI API Passthrough | 2G | 500 | 256 | 1024 | 10 | 0 | 300.02 | 1661.75 | 838.73 | 3391 |  |  |
|  AI API Passthrough | 2G | 500 | 256 | 102400 | 10 | 0 | 2229.13 | 224.13 | 364.19 | 1487 |  |  |
|  AI API Passthrough | 2G | 500 | 1024 | 1024 | 10 | 0 | 186.28 | 2671.39 | 1235.23 | 4799 |  |  |
|  AI API Passthrough | 2G | 500 | 1024 | 102400 | 10 | 0 | 2098.42 | 238.16 | 358.33 | 1431 |  |  |
