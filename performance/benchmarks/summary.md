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
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 3321.21 | 30 | 16.42 | 91 | 98.56 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 3181.42 | 31.32 | 17.03 | 94 | 98.64 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 2441.71 | 40.77 | 20.2 | 108 | 98.85 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 716.07 | 139.42 | 33.87 | 229 | 99.31 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 3273.97 | 60.96 | 29.75 | 161 | 98.51 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 3194.98 | 62.47 | 29.78 | 162 | 98.51 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 2421.87 | 82.39 | 34.09 | 186 | 98.76 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 673.76 | 296.9 | 55.05 | 445 | 99.32 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 3430.44 | 145.61 | 59.18 | 325 | 98.07 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 3333.72 | 149.85 | 59.87 | 331 | 98.23 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 2438.18 | 204.9 | 65.04 | 391 | 98.54 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 639.69 | 781.19 | 100.02 | 1079 | 99.22 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 3081.53 | 324.54 | 113.19 | 643 | 97.64 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 2970.35 | 336.58 | 113.13 | 655 | 97.72 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 2309.51 | 432.89 | 112.88 | 739 | 98.17 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 632.44 | 1578.77 | 181.24 | 2175 | 99.06 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2595.38 | 38.42 | 22.23 | 120 | 98.15 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 2105.58 | 47.37 | 26.92 | 143 | 98.06 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 721.92 | 138.27 | 67.25 | 339 | 98.12 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 0 | 92.48 | 1080.47 | 212.32 | 1615 | 95.63 |  |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2664.81 | 74.93 | 36.37 | 194 | 97.96 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 2211.32 | 90.29 | 43.42 | 229 | 97.82 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 728.36 | 274.55 | 113.12 | 599 | 97.87 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 0 | 76.71 | 2600.8 | 522.26 | 4351 | 88.41 | 350.15 |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2601.25 | 192.09 | 78.26 | 429 | 97.42 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 2063.35 | 242.26 | 95.57 | 523 | 97.35 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 723.41 | 690.94 | 218.41 | 1279 | 97.29 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 0 | 71.4 | 6954.01 | 1160.15 | 9663 | 85.81 | 464.029 |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2454.14 | 407.48 | 132.78 | 771 | 96.53 |  |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 2045.78 | 488.74 | 156.87 | 911 | 96.54 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 707.54 | 1411.33 | 328.81 | 2319 | 96.67 |  |
|  Transformation | 2G | 1000 | 102400 | 0 | 0 | 48.34 | 16878.92 | 4191.55 | 38655 | 80.2 | 558.246 |
