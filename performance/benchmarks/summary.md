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
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 3614.7 | 27.58 | 28.24 | 130 | 98.5 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 3458.24 | 28.83 | 28.75 | 134 | 98.49 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 2528.12 | 39.45 | 25.7 | 99 | 98.76 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 755.05 | 132.21 | 20.04 | 192 | 99.27 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 3386.88 | 58.96 | 50.48 | 261 | 98.43 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 3328.04 | 59.99 | 47.56 | 243 | 98.43 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 2567.67 | 77.76 | 45.23 | 207 | 98.7 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 722.3 | 276.98 | 33.36 | 385 | 99.25 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 3350.58 | 149.13 | 262.87 | 1079 | 97.99 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 3302.96 | 151.29 | 110.1 | 639 | 98.12 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 2537.23 | 196.93 | 77.84 | 527 | 98.48 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 754.78 | 662.21 | 57.85 | 867 | 99.12 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 3222.41 | 310.15 | 244.97 | 1327 | 97.36 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 3094.83 | 323.01 | 250.69 | 1375 | 97.43 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 2423.52 | 412.68 | 121.06 | 827 | 98.01 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 667.96 | 1494.67 | 118.83 | 1943 | 99 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2573.27 | 38.78 | 42.44 | 182 | 98.07 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 2101.22 | 47.5 | 51.37 | 199 | 98.09 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 738.2 | 135.35 | 144.49 | 959 | 98.19 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 0 | 89.99 | 1110.75 | 164.66 | 1551 | 94.95 | 329 |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2790.17 | 71.59 | 69.63 | 377 | 97.81 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 2269.15 | 88.04 | 76.18 | 391 | 97.75 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 776.95 | 257.37 | 221.71 | 1495 | 97.81 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 0 | 74.95 | 2661.8 | 479.96 | 4351 | 88.42 | 364.76 |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2666.13 | 187.46 | 109.95 | 611 | 97.31 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 2195.83 | 227.66 | 136.43 | 795 | 97.23 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 767.72 | 651.07 | 381.09 | 2207 | 97.09 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 0 | 71.85 | 6916.7 | 918.3 | 9087 | 86.76 | 479.794 |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2624.05 | 381.15 | 180.46 | 1019 | 96.14 |  |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 2159.48 | 463.07 | 216.56 | 1239 | 96.12 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 657.94 | 1517.74 | 689.17 | 3663 | 94.3 |  |
|  Transformation | 2G | 1000 | 102400 | 0 | 0 | 59.51 | 16463.44 | 1826.48 | 21503 | 78.06 | 585.868 |
