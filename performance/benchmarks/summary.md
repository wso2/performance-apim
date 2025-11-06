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
| Message Size (Bytes) | The request payload size in Bytes. | 50, 1024, 10240, 102400 |
| Back-end Delay (ms) | The delay added by the back-end service. | 0 |

The duration of each test is **900 seconds**. The warm-up period is **300 seconds**.
The measurement results are collected after the warm-up period.

A [**c5.large** Amazon EC2 instance](https://aws.amazon.com/ec2/instance-types/) was used to install WSO2 API Manager.

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
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 3614.94 | 27.58 | 28.77 | 135 | 98.47 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 3502.84 | 28.46 | 28.31 | 133 | 98.49 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 2689.24 | 37.08 | 24.39 | 94 | 98.73 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 832.68 | 119.89 | 17.4 | 171 | 99.24 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 3515.77 | 56.8 | 60.65 | 317 | 98.41 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 3475.32 | 57.46 | 54.51 | 295 | 98.41 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 2739.46 | 72.88 | 41.51 | 178 | 98.69 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 812.78 | 245.95 | 27.96 | 333 | 99.21 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 3510.25 | 142.35 | 234.12 | 1039 | 97.98 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 3481.08 | 143.51 | 199.51 | 951 | 97.96 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 2675.83 | 186.7 | 74.92 | 489 | 98.48 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 742.18 | 673.4 | 60.13 | 891 | 99.16 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 3332.87 | 299.84 | 300.9 | 1383 | 97.32 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 3270.25 | 305.77 | 242.28 | 1303 | 97.34 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 2520.4 | 396.81 | 123.65 | 839 | 97.96 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 710.48 | 1405.67 | 115.19 | 1847 | 98.98 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2728.02 | 36.57 | 39.65 | 158 | 98.04 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 2179.38 | 45.77 | 48.96 | 191 | 98.03 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 755.05 | 132.32 | 140.69 | 839 | 98.18 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 0 | 91.56 | 1091.23 | 166.55 | 1511 | 94.46 | 360 |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2694.37 | 74.14 | 61.33 | 325 | 97.86 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 2185.64 | 91.4 | 76.98 | 377 | 97.81 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 749.5 | 266.8 | 225.87 | 1495 | 97.92 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 0 | 74.23 | 2688.26 | 494.73 | 4447 | 88.21 | 373.036 |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2739.94 | 182.41 | 111.25 | 623 | 97.28 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 2225.24 | 224.7 | 131.97 | 739 | 97.13 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 749.49 | 666.48 | 368.78 | 2095 | 97.19 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 0 | 71.83 | 6917.1 | 908.89 | 8959 | 86.75 | 480.273 |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2622.67 | 381.27 | 172.77 | 975 | 96.06 |  |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 2118.88 | 471.76 | 226.84 | 1263 | 96.19 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 657.76 | 1519.15 | 666.61 | 3567 | 93.8 |  |
|  Transformation | 2G | 1000 | 102400 | 0 | 0 | 54.64 | 17551.45 | 3251.39 | 38655 | 77.64 | 591.957 |
