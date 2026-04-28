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
|  AI API Direct | 2G | 100 | 1024 | 10240 | 10 | 0 | 9351.65 | 10.65 | 1.42 | 11 | N/A | N/A |
|  AI API Direct | 2G | 100 | 1024 | 102400 | 10 | 0 | 4325.78 | 22.95 | 4.42 | 34 | N/A | N/A |
|  AI API Direct | 2G | 100 | 10240 | 10240 | 10 | 0 | 9325.45 | 10.67 | 1.42 | 11 | N/A | N/A |
|  AI API Direct | 2G | 100 | 10240 | 102400 | 10 | 0 | 4250.37 | 23.36 | 4.5 | 34 | N/A | N/A |
|  AI API Direct | 2G | 500 | 1024 | 10240 | 10 | 0 | 27931.7 | 17.69 | 4.4 | 40 | N/A | N/A |
|  AI API Direct | 2G | 500 | 1024 | 102400 | 10 | 0 | 4119.42 | 121.06 | 56.36 | 255 | N/A | N/A |
|  AI API Direct | 2G | 500 | 10240 | 10240 | 10 | 0 | 14823.33 | 33.55 | 21.2 | 74 | N/A | N/A |
|  AI API Direct | 2G | 500 | 10240 | 102400 | 10 | 0 | 1510.88 | 330.75 | 181.41 | 979 | N/A | N/A |
|  AI API Auth No Guardrails | 2G | 100 | 1024 | 10240 | 10 | 0 | 1237.55 | 80.75 | 77.5 | 341 | 97.7 |  |
|  AI API Auth No Guardrails | 2G | 100 | 1024 | 102400 | 10 | 0 | 183.35 | 545.08 | 317.89 | 1143 | 98.75 |  |
|  AI API Auth No Guardrails | 2G | 100 | 10240 | 10240 | 10 | 0 | 927.89 | 107.73 | 93.95 | 431 | 98.19 |  |
|  AI API Auth No Guardrails | 2G | 100 | 10240 | 102400 | 10 | 0 | 181.85 | 549.57 | 323.36 | 1223 | 98.69 |  |
|  AI API Auth No Guardrails | 2G | 500 | 1024 | 10240 | 10 | 0 | 946.16 | 528.18 | 417.92 | 1615 | 97.72 |  |
|  AI API Auth No Guardrails | 2G | 500 | 1024 | 102400 | 10 | 0 | 183.27 | 2715.39 | 1253.62 | 4895 | 98.06 |  |
|  AI API Auth No Guardrails | 2G | 500 | 10240 | 10240 | 10 | 0 | 849.19 | 588.06 | 484.63 | 1823 | 97.86 |  |
|  AI API Auth No Guardrails | 2G | 500 | 10240 | 102400 | 10 | 0 | 200.2 | 2486.4 | 1154.28 | 4511 | 98.03 |  |
|  AI API PII Masking | 2G | 100 | 1024 | 10240 | 10 | 0 | 765.39 | 130.64 | 117.61 | 505 | 98.19 |  |
|  AI API PII Masking | 2G | 100 | 1024 | 102400 | 10 | 0 | 129.53 | 771.2 | 457.8 | 1743 | 98.77 |  |
|  AI API PII Masking | 2G | 100 | 10240 | 10240 | 10 | 0 | 399.93 | 250.06 | 244.71 | 931 | 98.37 |  |
|  AI API PII Masking | 2G | 100 | 10240 | 102400 | 10 | 0 | 116.49 | 857.34 | 513.14 | 1919 | 98.84 |  |
|  AI API PII Masking | 2G | 500 | 1024 | 10240 | 10 | 0 | 743.15 | 672.09 | 566.63 | 2007 | 97.62 |  |
|  AI API PII Masking | 2G | 500 | 1024 | 102400 | 10 | 0 | 135.79 | 3657.15 | 1985.19 | 7455 | 98.06 |  |
|  AI API PII Masking | 2G | 500 | 10240 | 10240 | 10 | 0 | 394.67 | 1263.72 | 1184.73 | 3919 | 98.26 |  |
|  AI API PII Masking | 2G | 500 | 10240 | 102400 | 10 | 0 | 115.8 | 4286.67 | 2174.13 | 8383 | 98.24 |  |
|  AI API Advanced Guardrails | 2G | 100 | 1024 | 10240 | 10 | 0 | 695.87 | 143.72 | 131.87 | 563 | 98.13 |  |
|  AI API Advanced Guardrails | 2G | 100 | 1024 | 102400 | 10 | 0 | 132.06 | 756.48 | 453.63 | 1727 | 98.76 |  |
|  AI API Advanced Guardrails | 2G | 100 | 10240 | 10240 | 10 | 0 | 319.82 | 312.63 | 280.85 | 1003 | 98.64 |  |
|  AI API Advanced Guardrails | 2G | 100 | 10240 | 102400 | 10 | 0 | 104.45 | 956.18 | 573.11 | 2111 | 98.86 |  |
|  AI API Advanced Guardrails | 2G | 500 | 1024 | 10240 | 10 | 0 | 654.37 | 763.04 | 658.45 | 2351 | 97.66 |  |
|  AI API Advanced Guardrails | 2G | 500 | 1024 | 102400 | 10 | 0 | 129.74 | 3827.17 | 2048.42 | 7711 | 98.13 |  |
|  AI API Advanced Guardrails | 2G | 500 | 10240 | 10240 | 10 | 0 | 310.74 | 1603.4 | 1641.91 | 5503 | 98.14 |  |
|  AI API Advanced Guardrails | 2G | 500 | 10240 | 102400 | 10 | 0 | 99.8 | 4969.07 | 2465.74 | 9535 | 98.34 |  |
