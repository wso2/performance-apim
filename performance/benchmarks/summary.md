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
|  AI API Advanced Guardrails | 2G | 100 | 1024 | 10240 | 10 | 0 | 58.79 | 1696.84 | 630.29 | 3423 | 99.29 |  |
|  AI API Advanced Guardrails | 2G | 100 | 1024 | 102400 | 10 | 0 | 39.38 | 2530.08 | 1436.89 | 5215 | 99.16 |  |
|  AI API Advanced Guardrails | 2G | 100 | 10240 | 10240 | 10 | 0 | 0.66 | 135336.23 | 9923.87 | 141311 | 99.58 |  |
|  AI API Advanced Guardrails | 2G | 100 | 10240 | 102400 | 10 | 0 | 0.72 | 119196.54 | 14075.09 | 125951 | 99.56 |  |
|  AI API Advanced Guardrails | 2G | 500 | 1024 | 10240 | 10 | 0 | 61.29 | 8066.65 | 7096.63 | 23935 | 99.25 |  |
|  AI API Advanced Guardrails | 2G | 500 | 1024 | 102400 | 10 | 0 | 37 | 13260.74 | 6689.54 | 25215 | 99.02 |  |
|  AI API Advanced Guardrails | 2G | 500 | 10240 | 10240 | 10 | 100 | 23.7 | 17413.04 | 48067.8 | 366591 | 99.46 |  |
|  AI API Advanced Guardrails | 2G | 500 | 10240 | 102400 | 10 | 100 | 5.02 | 85525.02 | 88194.16 | 208895 | 99.56 |  |
|  AI API Auth No Guardrails | 2G | 100 | 1024 | 10240 | 10 | 0 | 950.53 | 105.15 | 87.54 | 413 | 98.31 |  |
|  AI API Auth No Guardrails | 2G | 100 | 1024 | 102400 | 10 | 0 | 189.3 | 528 | 303.24 | 1055 | 98.78 |  |
|  AI API Auth No Guardrails | 2G | 100 | 10240 | 10240 | 10 | 0 | 913.5 | 109.42 | 91.54 | 425 | 98.32 |  |
|  AI API Auth No Guardrails | 2G | 100 | 10240 | 102400 | 10 | 0 | 188.64 | 529.87 | 303.07 | 1055 | 98.8 |  |
|  AI API Auth No Guardrails | 2G | 500 | 1024 | 10240 | 10 | 0 | 922.65 | 541.64 | 405.15 | 1583 | 97.88 |  |
|  AI API Auth No Guardrails | 2G | 500 | 1024 | 102400 | 10 | 0 | 180.49 | 2756.12 | 1271.81 | 4927 | 98.24 |  |
|  AI API Auth No Guardrails | 2G | 500 | 10240 | 10240 | 10 | 0 | 907.78 | 550.46 | 429.77 | 1639 | 97.92 |  |
|  AI API Auth No Guardrails | 2G | 500 | 10240 | 102400 | 10 | 0 | 257.43 | 1936.3 | 955.51 | 3855 | 97.52 |  |
|  AI API Direct | 2G | 100 | 1024 | 10240 | 10 | 0 | 9378.68 | 10.61 | 1.43 | 11 | N/A | N/A |
|  AI API Direct | 2G | 100 | 1024 | 102400 | 10 | 0 | 4270.54 | 23.25 | 4.34 | 34 | N/A | N/A |
|  AI API Direct | 2G | 100 | 10240 | 10240 | 10 | 0 | 9342.25 | 10.65 | 1.47 | 11 | N/A | N/A |
|  AI API Direct | 2G | 100 | 10240 | 102400 | 10 | 0 | 4205.06 | 23.61 | 4.56 | 35 | N/A | N/A |
|  AI API Direct | 2G | 500 | 1024 | 10240 | 10 | 0 | 27342.42 | 18.07 | 4.73 | 44 | N/A | N/A |
|  AI API Direct | 2G | 500 | 1024 | 102400 | 10 | 0 | 4106.2 | 121.42 | 57.44 | 265 | N/A | N/A |
|  AI API Direct | 2G | 500 | 10240 | 10240 | 10 | 0 | 14822.32 | 33.54 | 21.42 | 75 | N/A | N/A |
|  AI API Direct | 2G | 500 | 10240 | 102400 | 10 | 0 | 1508.31 | 331.25 | 182.7 | 983 | N/A | N/A |
|  AI API PII Masking | 2G | 100 | 1024 | 10240 | 10 | 0 | 57.51 | 1736.46 | 605.59 | 3359 | 99.31 |  |
|  AI API PII Masking | 2G | 100 | 1024 | 102400 | 10 | 0 | 39.38 | 2530.83 | 1435 | 5151 | 99.19 |  |
|  AI API PII Masking | 2G | 100 | 10240 | 10240 | 10 | 0 | 0.54 | 161218.32 | 11792.44 | 168959 | 99.65 |  |
|  AI API PII Masking | 2G | 100 | 10240 | 102400 | 10 | 0 | 0.62 | 139960.1 | 18184.01 | 149503 | 99.61 |  |
|  AI API PII Masking | 2G | 500 | 1024 | 10240 | 10 | 0 | 66.74 | 7404.32 | 6715.71 | 22527 | 99.27 |  |
|  AI API PII Masking | 2G | 500 | 1024 | 102400 | 10 | 0 | 33.95 | 14478.97 | 7413.34 | 27647 | 98.99 |  |
|  AI API PII Masking | 2G | 500 | 10240 | 10240 | 10 | 99.99 | 15.37 | 29655.34 | 101447.5 | 606207 | 99.57 |  |
|  AI API PII Masking | 2G | 500 | 10240 | 102400 | 10 | 99.87 | 14.51 | 10184.28 | 4183.17 | 11071 | 99.49 |  |
