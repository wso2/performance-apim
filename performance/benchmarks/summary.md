# WSO2 API Manager AI API Performance Test Results

During each release, we execute various automated performance test scenarios and publish the results.

| Test Scenarios | Description |
| --- | --- |
| AI API Direct | Direct invocation of the mock AI backend, bypassing the API gateway. |
| AI API Auth No Guardrails | AI API invocation through the API gateway with OAuth2 authentication enabled and no guardrails. Includes throttling and analytics functionalities. |
| AI API Request PII Masking | AI API invocation through the API gateway with authentication and PII masking on the request only. Includes throttling and analytics functionalities. |
| AI API PII Masking | AI API invocation through the API gateway with authentication and PII masking on request and response. Includes throttling and analytics functionalities. |
| AI API Advanced Guardrails | AI API invocation through the API gateway with authentication, request PII masking, URL and JSON schema guardrails, and response PII masking. Includes throttling and analytics functionalities. |

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
| Concurrent Users | The number of users accessing the application at the same time. | 100, 500 |
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
|  AI API Direct | 2G | 100 | 1024 | 10240 | 10 | 0 | 9277.47 | 10.71 | 1.5 | 12 | N/A | N/A |
|  AI API Auth No Guardrails | 2G | 100 | 1024 | 10240 | 10 | 0 | 1223.63 | 81.65 | 74.27 | 327 | 97.89 |  |
|  AI API Request PII Masking | 2G | 100 | 1024 | 10240 | 10 | 0 | 831.72 | 120.17 | 102.54 | 465 | 98.2 |  |
|  AI API PII Masking | 2G | 100 | 1024 | 10240 | 10 | 0 | 728.78 | 137.16 | 118.28 | 515 | 98.32 |  |
|  AI API Advanced Guardrails | 2G | 100 | 1024 | 10240 | 10 | 0 | 683.47 | 146.31 | 129.08 | 535 | 98.34 |  |
|  AI API Direct | 2G | 100 | 1024 | 102400 | 10 | 0 | 4313.76 | 22.98 | 3.89 | 35 | N/A | N/A |
|  AI API Auth No Guardrails | 2G | 100 | 1024 | 102400 | 10 | 0 | 250.83 | 398.61 | 248.99 | 1063 | 98.45 |  |
|  AI API Request PII Masking | 2G | 100 | 1024 | 102400 | 10 | 0 | 263.57 | 379.36 | 240.08 | 1055 | 98.35 |  |
|  AI API PII Masking | 2G | 100 | 1024 | 102400 | 10 | 0 | 119.44 | 836.21 | 499.84 | 1887 | 98.85 |  |
|  AI API Advanced Guardrails | 2G | 100 | 1024 | 102400 | 10 | 0 | 120.62 | 827.95 | 488.5 | 1847 | 98.9 |  |
|  AI API Direct | 2G | 100 | 10240 | 10240 | 10 | 0 | 9258.6 | 10.73 | 1.52 | 12 | N/A | N/A |
|  AI API Auth No Guardrails | 2G | 100 | 10240 | 10240 | 10 | 0 | 924.53 | 108.1 | 89.98 | 423 | 98.27 |  |
|  AI API Request PII Masking | 2G | 100 | 10240 | 10240 | 10 | 0 | 428.72 | 233.28 | 213.98 | 775 | 98.6 |  |
|  AI API PII Masking | 2G | 100 | 10240 | 10240 | 10 | 0 | 387.51 | 257.82 | 245.51 | 919 | 98.53 |  |
|  AI API Advanced Guardrails | 2G | 100 | 10240 | 10240 | 10 | 0 | 327.96 | 304.55 | 273.99 | 1063 | 98.46 |  |
|  AI API Direct | 2G | 100 | 10240 | 102400 | 10 | 0 | 4250.02 | 23.31 | 4.07 | 35 | N/A | N/A |
|  AI API Auth No Guardrails | 2G | 100 | 10240 | 102400 | 10 | 0 | 177.29 | 563.81 | 318.27 | 1119 | 98.84 |  |
|  AI API Request PII Masking | 2G | 100 | 10240 | 102400 | 10 | 0 | 147.57 | 677.27 | 419.71 | 1599 | 98.83 |  |
|  AI API PII Masking | 2G | 100 | 10240 | 102400 | 10 | 0 | 106.88 | 934.49 | 555.12 | 2047 | 98.88 |  |
|  AI API Advanced Guardrails | 2G | 100 | 10240 | 102400 | 10 | 0 | 98.96 | 1008.93 | 594.66 | 2191 | 98.94 |  |
|  AI API Direct | 2G | 500 | 1024 | 10240 | 10 | 0 | 18194.72 | 17.8 | 38.05 | 140 | N/A | N/A |
|  AI API Auth No Guardrails | 2G | 500 | 1024 | 10240 | 10 | 0 | 910.54 | 548.79 | 401.91 | 1575 | 97.87 |  |
|  AI API Request PII Masking | 2G | 500 | 1024 | 10240 | 10 | 0 | 868.62 | 575.28 | 461.39 | 1703 | 97.54 |  |
|  AI API PII Masking | 2G | 500 | 1024 | 10240 | 10 | 0 | 759.77 | 657.44 | 542.31 | 1935 | 97.76 |  |
|  AI API Advanced Guardrails | 2G | 500 | 1024 | 10240 | 10 | 0 | 661.5 | 754.67 | 629.33 | 2207 | 97.81 |  |
|  AI API Direct | 2G | 500 | 1024 | 102400 | 10 | 0 | 4283.94 | 115.52 | 31.46 | 196 | N/A | N/A |
|  AI API Auth No Guardrails | 2G | 500 | 1024 | 102400 | 10 | 0 | 181.86 | 2736.21 | 1262.6 | 4927 | 98.2 |  |
|  AI API Request PII Masking | 2G | 500 | 1024 | 102400 | 10 | 0 | 177.1 | 2808.58 | 1297.79 | 5055 | 98.09 |  |
|  AI API PII Masking | 2G | 500 | 1024 | 102400 | 10 | 0 | 180.59 | 2754.51 | 1471.95 | 5631 | 97.65 |  |
|  AI API Advanced Guardrails | 2G | 500 | 1024 | 102400 | 10 | 0 | 124.97 | 3972.73 | 2099.54 | 7935 | 98.31 |  |
|  AI API Direct | 2G | 500 | 10240 | 10240 | 10 | 0 | 16674.57 | 18.64 | 44.09 | 124 | N/A | N/A |
|  AI API Auth No Guardrails | 2G | 500 | 10240 | 10240 | 10 | 0 | 871.24 | 573.51 | 420.32 | 1623 | 97.97 |  |
|  AI API Request PII Masking | 2G | 500 | 10240 | 10240 | 10 | 0 | 399.96 | 1246.79 | 1223.12 | 4015 | 98.31 |  |
|  AI API PII Masking | 2G | 500 | 10240 | 10240 | 10 | 0 | 368.47 | 1353.47 | 1278.22 | 4223 | 98.35 |  |
|  AI API Advanced Guardrails | 2G | 500 | 10240 | 10240 | 10 | 0 | 304.15 | 1637.57 | 1568.69 | 5151 | 98.32 |  |
|  AI API Direct | 2G | 500 | 10240 | 102400 | 10 | 0 | 1510.58 | 313.2 | 1382.7 | 1687 | N/A | N/A |
|  AI API Auth No Guardrails | 2G | 500 | 10240 | 102400 | 10 | 0 | 176.03 | 2826 | 1303.9 | 5055 | 98.21 |  |
|  AI API Request PII Masking | 2G | 500 | 10240 | 102400 | 10 | 0 | 138.12 | 3598.75 | 1727.6 | 6911 | 98.28 |  |
|  AI API PII Masking | 2G | 500 | 10240 | 102400 | 10 | 0 | 102.19 | 4846.88 | 2398.05 | 9343 | 98.46 |  |
|  AI API Advanced Guardrails | 2G | 500 | 10240 | 102400 | 10 | 0 | 100.14 | 4953.04 | 2415.04 | 9471 | 98.43 |  |
