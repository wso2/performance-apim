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

|  Scenario Name | Heap Size | Concurrent Users | Message Size (Bytes) | Response Size (Bytes) | Back-end Service Delay (ms) | Error % | Throughput (Requests/sec) | Average Response Time (ms) | Standard Deviation of Response Time (ms) | 99th Percentile of Response Time (ms) | WSO2 API Manager AI API GC Throughput (%) | Average WSO2 API Manager AI API Memory Footprint After Full GC (M) |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
|  AI API Direct | 2G | 100 | 256 | 1024 | 10 | 0 | 9485.28 | 10.5 | 1.26 | 11 | N/A | N/A |
|  AI API Direct | 2G | 100 | 256 | 102400 | 10 | 0 | 4347.03 | 22.88 | 4.54 | 36 | N/A | N/A |
|  AI API Direct | 2G | 100 | 1024 | 1024 | 10 | 0 | 9486.94 | 10.5 | 1.24 | 11 | N/A | N/A |
|  AI API Direct | 2G | 100 | 1024 | 102400 | 10 | 0 | 4335.14 | 22.92 | 4.55 | 35 | N/A | N/A |
|  AI API Direct | 2G | 500 | 256 | 1024 | 10 | 0 | 43947.25 | 11.24 | 3.44 | 34 | N/A | N/A |
|  AI API Direct | 2G | 500 | 256 | 102400 | 10 | 0 | 4287.71 | 116.4 | 41.97 | 225 | N/A | N/A |
|  AI API Direct | 2G | 500 | 1024 | 1024 | 10 | 0 | 43882.06 | 11.25 | 3.4 | 34 | N/A | N/A |
|  AI API Direct | 2G | 500 | 1024 | 102400 | 10 | 0 | 4289.41 | 116.35 | 41.88 | 224 | N/A | N/A |
|  AI API Passthrough | 2G | 100 | 256 | 1024 | 10 | 0 | 2245.06 | 44.49 | 45.51 | 209 | 97.25 |  |
|  AI API Passthrough | 2G | 100 | 256 | 102400 | 10 | 0 | 195.37 | 511.59 | 295.32 | 1023 | 98.68 |  |
|  AI API Passthrough | 2G | 100 | 1024 | 1024 | 10 | 0 | 2238.04 | 44.64 | 45.38 | 212 | 97.17 |  |
|  AI API Passthrough | 2G | 100 | 1024 | 102400 | 10 | 0 | 209.42 | 477.34 | 274.96 | 955 | 98.68 |  |
|  AI API Passthrough | 2G | 500 | 256 | 1024 | 10 | 0 | 2209.95 | 226.09 | 365.02 | 1495 | 96.75 |  |
|  AI API Passthrough | 2G | 500 | 256 | 102400 | 10 | 0 | 196.27 | 2537.13 | 1174.09 | 4543 | 97.99 |  |
|  AI API Passthrough | 2G | 500 | 1024 | 1024 | 10 | 0 | 2145.39 | 232.86 | 376.59 | 1535 | 96.77 |  |
|  AI API Passthrough | 2G | 500 | 1024 | 102400 | 10 | 0 | 186.28 | 2671.9 | 1235.79 | 4799 | 98.06 |  |
