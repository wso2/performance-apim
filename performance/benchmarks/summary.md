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
| Heap Size | The amount of memory allocated to the application | 4G |
| Concurrent Users | The number of users accessing the application at the same time. | 100, 200 |
| Message Size (Bytes) | The request payload size in Bytes. | 1024, 10240 |

| Response Size (Bytes) | The back-end response payload size in Bytes. | 10240, 102400 |

| Back-end Delay (ms) | The delay added by the back-end service. | 10 |

The duration of each test is **900 seconds**. The warm-up period is **300 seconds**.
The measurement results are collected after the warm-up period.

A [**c5.xlarge** Amazon EC2 instance](https://aws.amazon.com/ec2/instance-types/) was used to install WSO2 API Manager AI API.

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
|  AI API Direct | 4G | 100 | 1024 | 10240 | 10 | 0 | 9412.18 | 10.58 | 1.4 | 11 | N/A | N/A |
|  AI API Direct | 4G | 100 | 1024 | 102400 | 10 | 0 | 7897.46 | 12.51 | 1.34 | 18 | N/A | N/A |
|  AI API Direct | 4G | 100 | 10240 | 10240 | 10 | 0 | 9370.06 | 10.62 | 1.46 | 11 | N/A | N/A |
|  AI API Direct | 4G | 100 | 10240 | 102400 | 10 | 0 | 7821.09 | 12.64 | 1.39 | 19 | N/A | N/A |
|  AI API Direct | 4G | 200 | 1024 | 10240 | 10 | 0 | 18608.91 | 10.69 | 1.98 | 12 | N/A | N/A |
|  AI API Direct | 4G | 200 | 1024 | 102400 | 10 | 0 | 9034.29 | 21.92 | 4.82 | 37 | N/A | N/A |
|  AI API Direct | 4G | 200 | 10240 | 10240 | 10 | 0 | 18485.68 | 10.76 | 2.12 | 12 | N/A | N/A |
|  AI API Direct | 4G | 200 | 10240 | 102400 | 10 | 0 | 7467.06 | 26.56 | 15.6 | 89 | N/A | N/A |
|  AI API Auth No Guardrails | 4G | 100 | 1024 | 10240 | 10 | 0 | 1897.04 | 52.66 | 28.08 | 106 | 99.04 |  |
|  AI API Auth No Guardrails | 4G | 100 | 1024 | 102400 | 10 | 0 | 451.1 | 221.7 | 125.06 | 451 | 99.11 |  |
|  AI API Auth No Guardrails | 4G | 100 | 10240 | 10240 | 10 | 0 | 2287.84 | 43.66 | 30.3 | 137 | 98.86 |  |
|  AI API Auth No Guardrails | 4G | 100 | 10240 | 102400 | 10 | 0 | 276.63 | 361.45 | 200.85 | 707 | 99.32 |  |
|  AI API Auth No Guardrails | 4G | 200 | 1024 | 10240 | 10 | 0 | 2457.31 | 81.33 | 62.8 | 222 | 98.74 |  |
|  AI API Auth No Guardrails | 4G | 200 | 1024 | 102400 | 10 | 0 | 461.79 | 432.99 | 252.14 | 867 | 98.99 |  |
|  AI API Auth No Guardrails | 4G | 200 | 10240 | 10240 | 10 | 0 | 1815.62 | 110.08 | 67.93 | 234 | 99.01 |  |
|  AI API Auth No Guardrails | 4G | 200 | 10240 | 102400 | 10 | 0 | 471.85 | 423.75 | 243.6 | 843 | 98.94 |  |
|  AI API PII Masking | 4G | 100 | 1024 | 10240 | 10 | 0 | 99.33 | 1006.01 | 244.25 | 1671 | 99.63 |  |
|  AI API PII Masking | 4G | 100 | 1024 | 102400 | 10 | 0 | 84.76 | 1178.31 | 676.63 | 2383 | 99.53 |  |
|  AI API PII Masking | 4G | 100 | 10240 | 10240 | 10 | 0 | 1.13 | 80722.8 | 5379.75 | 83967 | 99.71 |  |
|  AI API PII Masking | 4G | 100 | 10240 | 102400 | 10 | 0 | 0.98 | 93012.73 | 9373.99 | 97791 | 99.8 |  |
|  AI API PII Masking | 4G | 200 | 1024 | 10240 | 10 | 0 | 96.26 | 2073.56 | 1072.84 | 5119 | 99.64 |  |
|  AI API PII Masking | 4G | 200 | 1024 | 102400 | 10 | 0 | 92.96 | 2144.91 | 1347.7 | 4543 | 99.5 |  |
|  AI API PII Masking | 4G | 200 | 10240 | 10240 | 10 | 94.79 | 0.87 | 179081.91 | 7386.69 | 182271 | 99.7 |  |
|  AI API PII Masking | 4G | 200 | 10240 | 102400 | 10 | 0 | 1.11 | 157570.98 | 11613.71 | 165887 | 99.78 |  |
|  AI API Advanced Guardrails | 4G | 100 | 1024 | 10240 | 10 | 0 | 104.57 | 955.47 | 268.59 | 1711 | 99.65 |  |
|  AI API Advanced Guardrails | 4G | 100 | 1024 | 102400 | 10 | 0 | 90.62 | 1102.18 | 641.17 | 2255 | 99.52 |  |
|  AI API Advanced Guardrails | 4G | 100 | 10240 | 10240 | 10 | 0 | 1.2 | 75732.11 | 6646.16 | 79359 | 99.52 |  |
|  AI API Advanced Guardrails | 4G | 100 | 10240 | 102400 | 10 | 0 | 1.18 | 77033.69 | 6745.35 | 80895 | 99.79 |  |
|  AI API Advanced Guardrails | 4G | 200 | 1024 | 10240 | 10 | 0 | 118.26 | 1687.62 | 1244.62 | 4927 | 99.64 |  |
|  AI API Advanced Guardrails | 4G | 200 | 1024 | 102400 | 10 | 0 | 76.18 | 2616.91 | 1584.88 | 5439 | 99.55 |  |
|  AI API Advanced Guardrails | 4G | 200 | 10240 | 10240 | 10 | 93.87 | 0.89 | 178403.82 | 9646.67 | 182271 | 99.8 |  |
|  AI API Advanced Guardrails | 4G | 200 | 10240 | 102400 | 10 | 0 | 1.15 | 152796.55 | 12324.74 | 160767 | 99.8 |  |
