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
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 3431.31 | 29.06 | 30.03 | 141 | 98.54 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 3352.74 | 29.74 | 27.55 | 119 | 98.57 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 2569.58 | 38.81 | 24.58 | 95 | 98.77 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 770.64 | 129.54 | 19.01 | 184 | 99.26 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 3409.06 | 58.57 | 50.09 | 254 | 98.42 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 3306.67 | 60.38 | 48.71 | 247 | 98.49 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 2596.23 | 76.91 | 40.92 | 185 | 98.72 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 731.76 | 273.4 | 30.76 | 373 | 99.25 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 3361.89 | 148.64 | 229.56 | 1019 | 98.07 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 3328.63 | 150.12 | 146.73 | 791 | 98.1 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 2557.26 | 195.38 | 81.59 | 579 | 98.51 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 692.51 | 721.74 | 64.3 | 959 | 99.15 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 3263.54 | 306.22 | 299.03 | 1391 | 97.36 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 3102.87 | 322.25 | 242.78 | 1335 | 97.47 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 2471.08 | 404.75 | 122.26 | 847 | 98.03 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 684.14 | 1459.38 | 116.74 | 1919 | 99 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2647.48 | 37.68 | 39.38 | 161 | 98.09 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 2135.97 | 46.72 | 52.15 | 211 | 98.06 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 743.94 | 134.29 | 137.81 | 807 | 98.13 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 0 | 89.17 | 1120.8 | 167.59 | 1559 | 95.03 | 335 |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2647.88 | 75.43 | 65.69 | 329 | 97.94 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 2112.93 | 94.55 | 82.28 | 405 | 97.89 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 752.3 | 265.56 | 226.59 | 1463 | 97.87 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 0 | 74.74 | 2670.21 | 502.66 | 4415 | 88.41 | 364.115 |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2654.61 | 188.25 | 117.71 | 663 | 97.35 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 2151.61 | 232.37 | 135.7 | 775 | 97.27 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 748.8 | 667.59 | 380.29 | 2159 | 96.98 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 0 | 70.79 | 7006.13 | 903.08 | 9215 | 87.05 | 482 |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2582.2 | 387.33 | 187.28 | 1071 | 96.14 |  |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 2104.18 | 475.19 | 216.75 | 1239 | 96.25 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 644.76 | 1548.2 | 682.49 | 3663 | 93.71 |  |
|  Transformation | 2G | 1000 | 102400 | 0 | 0 | 57.65 | 17005.7 | 1702.46 | 20991 | 77.47 | 588.662 |
