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
|  Passthrough | 2G | 100 | 50 | 0 | 100 | 5754.15 | 17.28 | 13.73 | 50 | 98.9 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 100 | 5692.3 | 17.47 | 14.24 | 49 | 98.91 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 100 | 4292 | 23.21 | 17.39 | 62 | 99.07 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 100 | 1560.4 | 63.99 | 15.62 | 101 | 99.38 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 100 | 5245.09 | 38.03 | 25.48 | 103 | 98.79 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 100 | 5016.44 | 39.77 | 27.16 | 110 | 98.9 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 100 | 4171.57 | 47.84 | 28.19 | 119 | 98.97 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 100 | 1520.08 | 131.45 | 30.63 | 195 | 99.35 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 100 | 5094.29 | 98.01 | 41.32 | 220 | 98.46 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 100 | 4916.18 | 101.57 | 43.38 | 226 | 98.45 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 100 | 4135.48 | 120.74 | 46.46 | 263 | 98.88 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 100 | 1510.16 | 331.21 | 74.52 | 473 | 99.18 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 100 | 5264.65 | 189.77 | 65.15 | 393 | 98.24 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 100 | 5223.15 | 191.28 | 62.76 | 387 | 98.23 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 100 | 4308.4 | 232.01 | 69.82 | 459 | 98.44 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 100 | 1570.61 | 636.47 | 145.7 | 999 | 98.98 |  |
|  Transformation | 2G | 100 | 50 | 0 | 100 | 5608.3 | 17.73 | 12.84 | 48 | 98.93 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 100 | 5624.07 | 17.68 | 14.78 | 54 | 98.91 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 100 | 4630.59 | 21.5 | 16.24 | 56 | 99.04 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 100 | 1685.68 | 59.23 | 14.53 | 94 | 99.35 |  |
|  Transformation | 2G | 200 | 50 | 0 | 100 | 5553.29 | 35.91 | 21.6 | 91 | 98.81 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 100 | 5412.9 | 36.85 | 20.43 | 89 | 98.85 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 100 | 4586.43 | 43.5 | 27.29 | 109 | 98.97 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 100 | 1654.62 | 120.75 | 28.04 | 179 | 99.32 |  |
|  Transformation | 2G | 500 | 50 | 0 | 100 | 5598.39 | 89.15 | 38.38 | 192 | 98.26 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 100 | 5284.82 | 94.48 | 32.37 | 180 | 98.32 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 100 | 4527.12 | 110.29 | 44.31 | 245 | 98.71 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 100 | 1599.82 | 312.61 | 70.31 | 441 | 99.22 |  |
|  Transformation | 2G | 1000 | 50 | 0 | 100 | 5595.58 | 178.56 | 61.66 | 371 | 98.23 |  |
|  Transformation | 2G | 1000 | 1024 | 0 | 100 | 5465.9 | 182.8 | 64.55 | 385 | 97.61 | 627 |
|  Transformation | 2G | 1000 | 10240 | 0 | 100 | 4490.97 | 222.52 | 65.56 | 429 | 98.51 |  |
|  Transformation | 2G | 1000 | 102400 | 0 | 100 | 1661.36 | 601.71 | 138.66 | 943 | 98.94 |  |
