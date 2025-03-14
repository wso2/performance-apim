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
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 3357.68 | 29.67 | 15.76 | 87 | 98.56 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 3336.09 | 29.87 | 15.51 | 86 | 98.59 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 2544.55 | 39.11 | 19.3 | 105 | 98.78 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 744.44 | 134.08 | 32.73 | 222 | 99.32 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 3483.8 | 57.28 | 27.52 | 149 | 98.48 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 3450.78 | 57.82 | 27.54 | 150 | 98.46 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 2599.97 | 76.72 | 32.5 | 179 | 98.71 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 693.66 | 288.34 | 55.81 | 435 | 99.29 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 3342.06 | 149.45 | 59.73 | 327 | 98.19 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 3233.75 | 154.47 | 61.36 | 339 | 98.23 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 2541.17 | 196.61 | 64.88 | 385 | 98.54 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 675.88 | 739.39 | 100.87 | 1031 | 99.2 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 3292.55 | 303.7 | 106.81 | 607 | 97.54 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 3013.07 | 331.95 | 114.72 | 655 | 97.61 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 2555.12 | 391.33 | 107.23 | 687 | 98.12 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 643.61 | 1551.54 | 171.56 | 2095 | 99.04 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2651.24 | 37.59 | 21.22 | 115 | 98.01 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 2201.13 | 45.3 | 24.65 | 133 | 98.04 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 740.61 | 134.75 | 65.67 | 333 | 98.1 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 0 | 90.3 | 1106.65 | 232.67 | 1687 | 95.18 | 311 |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2568.75 | 77.73 | 38.15 | 204 | 97.98 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 2156.06 | 92.6 | 45.67 | 241 | 97.86 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 733.04 | 272.76 | 112.21 | 595 | 97.92 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 0 | 74.7 | 2670.03 | 504.26 | 4383 | 88.65 | 349.65 |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2635.39 | 189.61 | 75.05 | 409 | 97.37 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 2127.81 | 234.91 | 93.03 | 507 | 97.33 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 781.17 | 639.84 | 211.99 | 1231 | 97.06 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 0 | 70.3 | 7051.35 | 1123.3 | 9663 | 86.56 | 463.906 |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2599.17 | 384.69 | 131.02 | 751 | 96.5 |  |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 2005.88 | 498.36 | 161.19 | 959 | 96.52 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 673.83 | 1482.16 | 348.22 | 2463 | 95.25 |  |
|  Transformation | 2G | 1000 | 102400 | 0 | 0 | 58.49 | 16754.05 | 4810.3 | 43519 | 80.8 | 557.655 |
