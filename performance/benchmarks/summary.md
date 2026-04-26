# WSO2 API Manager AI API Performance Test Results

During each release, we execute various automated performance test scenarios and publish the results.

| Test Scenarios | Description |
| --- | --- |
| AI API Direct | Direct invocation of the mock AI backend, bypassing the API gateway. |
| AI API Auth No Guardrails | AI API invocation through the API gateway with authentication enabled and no guardrails. |
| AI API PII Masking | AI API invocation through the API gateway with authentication and PII masking on request and response. |
| AI API Advanced Guardrails | AI API invocation through the API gateway with authentication, request PII masking, URL and JSON schema guardrails, and response PII masking. |

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
| Concurrent Users | The number of users accessing the application at the same time. | 100 |
| Message Size (Bytes) | The request payload size in Bytes. | 1024, 10240 |

| Response Size (Bytes) | The back-end response payload size in Bytes. | 10240, 102400 |

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
|  AI API Direct | 2G | 100 | 1024 | 10240 | 10 | 0 | 9364.77 | 10.63 | 1.34 | 11 | N/A | N/A |
|  AI API Direct | 2G | 100 | 1024 | 102400 | 10 | 0 | 4330.41 | 22.95 | 4.29 | 34 | N/A | N/A |
|  AI API Direct | 2G | 100 | 10240 | 10240 | 10 | 0 | 9325.99 | 10.68 | 1.35 | 11 | N/A | N/A |
|  AI API Direct | 2G | 100 | 10240 | 102400 | 10 | 0 | 4251.52 | 23.37 | 4.54 | 34 | N/A | N/A |
|  AI API Auth No Guardrails | 2G | 100 | 1024 | 10240 | 10 | 0 | 1139.52 | 87.71 | 85.57 | 371 | 97.7 |  |
|  AI API Auth No Guardrails | 2G | 100 | 1024 | 102400 | 10 | 0 | 177.88 | 561.94 | 319.2 | 1119 | 98.64 |  |
|  AI API Auth No Guardrails | 2G | 100 | 10240 | 10240 | 10 | 0 | 858.47 | 116.44 | 99.86 | 457 | 98.15 |  |
|  AI API Auth No Guardrails | 2G | 100 | 10240 | 102400 | 10 | 0 | 179.24 | 557.63 | 318.32 | 1111 | 98.7 |  |
|  AI API PII Masking | 2G | 100 | 1024 | 10240 | 10 | 0 | 65.3 | 1528.13 | 667.45 | 3343 | 99.2 |  |
|  AI API PII Masking | 2G | 100 | 1024 | 102400 | 10 | 0 | 39.01 | 2556.34 | 1467.42 | 5311 | 99.03 |  |
|  AI API PII Masking | 2G | 100 | 10240 | 10240 | 10 | 0 | 0.5 | 165189.27 | 24718.84 | 177151 | 98.79 |  |
|  AI API PII Masking | 2G | 100 | 10240 | 102400 | 10 | 0 | 0.69 | 126420.77 | 12463.35 | 133119 | 99.51 |  |
|  AI API Advanced Guardrails | 2G | 100 | 1024 | 10240 | 10 | 0 | 62.07 | 1608.14 | 687.89 | 3471 | 99.18 |  |
|  AI API Advanced Guardrails | 2G | 100 | 1024 | 102400 | 10 | 0 | 43.89 | 2269.82 | 1309.31 | 4767 | 98.99 |  |
|  AI API Advanced Guardrails | 2G | 100 | 10240 | 10240 | 10 | 0 | 0.69 | 127444.86 | 11252.22 | 134143 | 99.51 |  |
|  AI API Advanced Guardrails | 2G | 100 | 10240 | 102400 | 10 | 0 | 0.57 | 154492.7 | 11572.03 | 161791 | 99.6 |  |
