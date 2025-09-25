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
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 3620.01 | 27.54 | 26.23 | 119 | 98.46 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 3459.19 | 28.83 | 29.2 | 133 | 98.53 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 2771.22 | 35.98 | 23.7 | 89 | 98.7 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 782.45 | 127.61 | 19.07 | 186 | 99.28 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 3428.98 | 58.24 | 48.38 | 255 | 98.41 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 3400.56 | 58.73 | 46.26 | 242 | 98.44 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 2654.29 | 75.23 | 42.26 | 188 | 98.69 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 735.67 | 271.94 | 30.6 | 373 | 99.25 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 3508.12 | 142.44 | 161.66 | 839 | 98.02 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 3356.42 | 148.87 | 116.66 | 663 | 98.1 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 2608.18 | 191.55 | 76.04 | 523 | 98.49 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 701.16 | 712.87 | 64.68 | 959 | 99.15 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 3238.19 | 308.7 | 297.73 | 1399 | 97.37 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 3233.42 | 309.17 | 201.61 | 1215 | 97.36 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 2467.61 | 405.27 | 118.02 | 803 | 98.02 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 695.51 | 1435.83 | 112.01 | 1871 | 98.99 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2732.18 | 36.52 | 40.11 | 160 | 97.99 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 2203.45 | 45.3 | 50.98 | 206 | 98.01 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 746.32 | 133.87 | 134.17 | 735 | 98.14 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 0 | 96.4 | 1036.79 | 153.71 | 1431 | 94.94 | 315 |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2660.36 | 75.08 | 66.18 | 359 | 97.81 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 2206.89 | 90.53 | 78.47 | 455 | 97.84 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 789.01 | 253.47 | 212.91 | 1399 | 97.81 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 0 | 72.03 | 2769 | 518.08 | 4575 | 88.39 | 372.037 |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2688.27 | 185.9 | 135.58 | 767 | 97.33 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 2227.19 | 224.47 | 126.12 | 707 | 97.24 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 786.73 | 635.11 | 396.88 | 2255 | 97.13 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 0 | 68.71 | 7228.16 | 869.24 | 9343 | 86.96 | 482.485 |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2638.34 | 378.99 | 186.78 | 1095 | 96.19 |  |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 2114.81 | 472.79 | 216.39 | 1215 | 95.96 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 633.22 | 1575.5 | 707.08 | 3711 | 93.63 |  |
|  Transformation | 2G | 1000 | 102400 | 0 | 0 | 59.09 | 16606.18 | 1815.67 | 21631 | 78.58 | 585.652 |
