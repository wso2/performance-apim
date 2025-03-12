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
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 3417.24 | 29.15 | 15.5 | 86 | 98.54 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 3306.2 | 30.13 | 16.17 | 89 | 98.59 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 2589.78 | 38.43 | 19.34 | 105 | 98.79 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 727.06 | 137.3 | 33.27 | 226 | 99.32 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 3403.88 | 58.62 | 28.45 | 155 | 98.5 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 3400.91 | 58.67 | 27.59 | 149 | 98.47 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 2506.23 | 79.6 | 33.99 | 188 | 98.76 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 701.33 | 285.2 | 54.23 | 431 | 99.28 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 3508.39 | 142.36 | 58.7 | 321 | 98.16 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 3428.82 | 145.68 | 58.21 | 321 | 98.22 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 2709.5 | 184.33 | 61.4 | 363 | 98.51 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 730.1 | 684.51 | 101.01 | 975 | 99.18 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 3100.26 | 322.5 | 114.45 | 647 | 97.61 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 3141.29 | 318.35 | 108.22 | 623 | 97.63 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 2378.5 | 420.33 | 107.37 | 727 | 98.21 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 629.96 | 1585.12 | 175.59 | 2143 | 99.06 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2607.19 | 38.23 | 22.13 | 120 | 98.14 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 2115.95 | 47.13 | 27.47 | 147 | 98.07 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 743.87 | 134.19 | 65.2 | 327 | 98.11 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 0 | 95.6 | 1045.16 | 233.15 | 1631 | 95.23 | 329 |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2911.8 | 68.54 | 33.68 | 181 | 97.72 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 2356.67 | 84.71 | 42.7 | 226 | 97.78 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 724.97 | 275.83 | 114.41 | 595 | 97.9 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 0 | 74.56 | 2675.83 | 522.08 | 4383 | 88.91 | 348.421 |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2670.61 | 187.09 | 76.08 | 413 | 97.38 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 2066.79 | 241.87 | 94.39 | 519 | 97.4 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 728.3 | 686.25 | 215.22 | 1279 | 97.37 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 0 | 71.37 | 6944.99 | 1074.03 | 9599 | 86.43 | 461.656 |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2501 | 399.76 | 135.17 | 779 | 96.56 |  |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 2063.58 | 484.56 | 154.5 | 907 | 96.49 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 593.87 | 1682.07 | 380.04 | 2767 | 91.49 |  |
|  Transformation | 2G | 1000 | 102400 | 0 | 0 | 62.09 | 15806.39 | 1807.06 | 20479 | 79.15 | 565.639 |
