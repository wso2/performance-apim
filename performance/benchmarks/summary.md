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
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 3419.99 | 29.14 | 15.49 | 86 | 98.7 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 3391.22 | 29.39 | 15.57 | 86 | 98.7 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 2572.95 | 38.71 | 19.25 | 102 | 98.92 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 723.83 | 137.92 | 33.7 | 225 | 99.44 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 3480.65 | 57.34 | 27.3 | 148 | 98.59 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 3387.01 | 58.93 | 27.57 | 150 | 98.64 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 2503.44 | 79.72 | 33.2 | 183 | 98.88 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 706.46 | 283.13 | 52.1 | 419 | 99.41 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 3543.13 | 140.98 | 56.91 | 311 | 98.3 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 3404.86 | 146.71 | 57.96 | 321 | 98.36 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 2629.1 | 190 | 61.03 | 363 | 98.69 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 678.26 | 736.85 | 96.65 | 1015 | 99.31 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 3203.89 | 312.08 | 108.46 | 623 | 97.73 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 3255.78 | 307.15 | 103.2 | 599 | 97.77 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 2460.35 | 406.4 | 107.09 | 703 | 98.23 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 658.68 | 1515.96 | 169 | 2079 | 99.16 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2654.45 | 37.57 | 21.18 | 115 | 98.21 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 2303.07 | 43.3 | 23.23 | 126 | 98.14 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 772.44 | 129.21 | 63.77 | 323 | 98.16 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 0 | 96.92 | 1031.06 | 241.26 | 1687 | 95.48 | 308 |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2723.56 | 73.3 | 36.25 | 194 | 98.06 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 2317.6 | 86.16 | 40.22 | 215 | 97.89 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 774.29 | 258.21 | 109.61 | 571 | 97.98 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 0 | 80.34 | 2484.82 | 465.2 | 3983 | 89.56 | 346.8 |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2753.59 | 181.47 | 72.36 | 395 | 97.51 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 2199.09 | 227.31 | 87.89 | 485 | 97.42 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 761.19 | 656.61 | 203.31 | 1207 | 97.14 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 0 | 74.4 | 6683.31 | 1097.92 | 9407 | 86.61 | 457.594 |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2651.95 | 377.06 | 125.9 | 727 | 96.41 |  |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 2244.68 | 445.49 | 148.87 | 871 | 96.38 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 650.19 | 1534.88 | 360.57 | 2591 | 93.57 |  |
|  Transformation | 2G | 1000 | 102400 | 0 | 0 | 62.96 | 15572.48 | 1982.64 | 20479 | 78.53 | 574.985 |
