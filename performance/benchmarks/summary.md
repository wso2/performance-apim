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
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 3538.24 | 28.18 | 23.83 | 110 | 98.29 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 3379.74 | 29.5 | 26.79 | 124 | 98.32 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 2617.39 | 38.1 | 23.17 | 92 | 98.46 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 822.54 | 121.37 | 24.01 | 187 | 98.96 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 3543.39 | 56.35 | 51.25 | 279 | 98.13 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 3461.33 | 57.69 | 49.01 | 269 | 98.2 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 2779.32 | 71.83 | 37.46 | 170 | 98.39 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 786.49 | 254.25 | 38.68 | 359 | 98.93 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 3421.44 | 145.97 | 280.22 | 1111 | 97.84 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 3401.07 | 146.84 | 228.87 | 1015 | 97.86 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 2597.13 | 192.36 | 77.88 | 535 | 98.26 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 724.14 | 690.29 | 78.32 | 943 | 98.9 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 3499.8 | 285.52 | 301.06 | 1343 | 97.32 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 3272.73 | 305.28 | 326.29 | 1407 | 97.53 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 2593.03 | 385.78 | 108.17 | 747 | 97.88 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 701.57 | 1423.23 | 133.89 | 1879 | 98.79 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2902.9 | 34.36 | 37.12 | 147 | 97.59 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 2202.71 | 45.31 | 48.11 | 190 | 97.66 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 753.52 | 132.58 | 142.03 | 951 | 97.78 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 0 | 95.24 | 1049.14 | 133.83 | 1367 | 95.48 |  |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2700.69 | 73.96 | 62.13 | 329 | 97.56 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 2267.56 | 88.1 | 71.47 | 361 | 97.43 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 767.06 | 260.69 | 219.56 | 1407 | 97.48 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 0 | 81.55 | 2447.49 | 348.37 | 3711 | 92.15 | 394.667 |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2761.81 | 180.95 | 110.58 | 619 | 96.98 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 2270.49 | 220.17 | 124.93 | 691 | 96.9 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 728.16 | 686.35 | 391.53 | 2159 | 96.91 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 0 | 74.74 | 6654.93 | 713.51 | 8447 | 90.31 | 493.593 |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2578.98 | 387.74 | 217.25 | 1311 | 96.47 |  |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 2018.62 | 495.5 | 252.64 | 1439 | 96.55 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 661.66 | 1508.34 | 615.1 | 3471 | 96.52 |  |
|  Transformation | 2G | 1000 | 102400 | 0 | 0 | 61.08 | 16044.83 | 1726.9 | 20607 | 80.8 | 618.625 |
