# WSO2 API Manager AI API Performance Test Results

During each release, we execute various automated performance test scenarios and publish the results.

| Test Scenarios | Description |
| --- | --- |
| AI API Direct | Direct invocation of the mock AI backend, bypassing the API gateway. |
| AI API Auth No Guardrails | AI API invocation through the API gateway with OAuth2 authentication enabled and no guardrails. |
| AI API Request PII Masking | AI API invocation through the API gateway with authentication and PII masking on the request only. |
| AI API PII Masking | AI API invocation through the API gateway with authentication and PII masking on request and response. |
| AI API Advanced Guardrails | AI API invocation through the API gateway with authentication, request PII masking, URL and JSON schema guardrails, and response PII masking. |

The direct back-end scenario is included as the baseline for comparing the additional gateway features exercised by the
other scenarios. All gateway-based scenarios are executed through the AI API runtime path in WSO2 API Manager with the
standard API control points in place, including request handling associated with throttling and analytics flows. As a
result, the reported numbers reflect the end-to-end gateway processing cost of the configured authentication and
guardrail combination relative to the direct back-end baseline.

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

| Response Size (Bytes) | The back-end response payload size in Bytes. | 10240 |

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
|  AI API Direct | 2G | 100 | 1024 | 10240 | 10 | 0 | 9248.36 | 10.75 | 1.43 | 12 | N/A | N/A |
|  AI API Auth No Guardrails | 2G | 100 | 1024 | 10240 | 10 | 0 | 1033.84 | 96.67 | 80.45 | 377 | 98.14 |  |
|  AI API Request PII Masking | 2G | 100 | 1024 | 10240 | 10 | 0 | 922.42 | 108.36 | 93.26 | 423 | 98.06 |  |
|  AI API PII Masking | 2G | 100 | 1024 | 10240 | 10 | 0 | 962.12 | 103.91 | 102.86 | 409 | 97.78 |  |
|  AI API Direct | 2G | 100 | 10240 | 10240 | 10 | 0 | 9202.93 | 10.8 | 1.45 | 12 | N/A | N/A |
|  AI API Auth No Guardrails | 2G | 100 | 10240 | 10240 | 10 | 0 | 1214.04 | 82.31 | 76.19 | 331 | 97.85 |  |
|  AI API Request PII Masking | 2G | 100 | 10240 | 10240 | 10 | 0 | 441.25 | 226.68 | 209.21 | 759 | 98.53 |  |
|  AI API PII Masking | 2G | 100 | 10240 | 10240 | 10 | 0 | 373.47 | 267.79 | 249.58 | 895 | 98.53 |  |
