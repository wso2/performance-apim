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
|  Passthrough | 2G | 100 | 50 | 0 | 100 | 10344.21 | 8 | 13.35 | 43 | 99.83 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 100 | 8022.73 | 10.77 | 320.19 | 45 | 99.61 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 100 | 10515.28 | 7.78 | 53.71 | 41 | 99.4 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 100 | 11875.76 | 6.7 | 5.22 | 27 | 99.74 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 100 | 7676.37 | 22.18 | 518.67 | 94 | 99.69 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 100 | 8815.38 | 18.58 | 238.8 | 91 | 99.78 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 100 | 10379.59 | 15.04 | 119.2 | 85 | 99.89 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 100 | 9066.86 | 17.65 | 531.54 | 71 | 99.72 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 100 | 7259.99 | 56.96 | 401.27 | 232 | 99.78 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 100 | 9586.38 | 38.62 | 78.78 | 202 | 99.72 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 100 | 8902.55 | 42.01 | 456.42 | 202 | 99.69 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 100 | 9420.76 | 33.06 | 142.67 | 177 | 99.57 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 100 | 9428.39 | 64.29 | 129.28 | 395 | 99.72 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 100 | 7081.78 | 98.52 | 1854.31 | 393 | 99.64 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 100 | 9181.84 | 64.14 | 765.42 | 379 | 99.78 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 100 | 9263.56 | 56.82 | 579.25 | 377 | 99.74 |  |
|  Transformation | 2G | 100 | 50 | 0 | 100 | 9117.32 | 9.21 | 323.12 | 37 | 99.68 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 100 | 9753.35 | 8.51 | 197.36 | 35 | 99.83 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 100 | 9298.76 | 8.05 | 160.63 | 29 | 99.54 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 100 | 11507.07 | 6.92 | 5.35 | 27 | 99.77 |  |
|  Transformation | 2G | 200 | 50 | 0 | 100 | 9408.14 | 17.1 | 222.65 | 83 | 99.74 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 100 | 9077.17 | 17.78 | 458.56 | 76 | 99.66 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 100 | 10069.72 | 15.68 | 141.76 | 85 | 99.62 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 100 | 11231.53 | 13.72 | 14.19 | 70 | 99.72 |  |
|  Transformation | 2G | 500 | 50 | 0 | 100 | 7691.08 | 51.93 | 565.49 | 214 | 99.79 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 100 | 30.73 | 11754.67 | 79046.53 | 602111 | 99.71 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 100 | 10677.05 | 33.31 | 41.17 | 200 | 99.68 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 100 | 1625.21 | 75.88 | 3135.3 | 200 | 99.78 |  |
|  Transformation | 2G | 1000 | 50 | 0 | 100 | 3624.08 | 235.14 | 5261.99 | 439 | 99.77 |  |
|  Transformation | 2G | 1000 | 1024 | 0 | 100 | 9280.91 | 60.1 | 601.22 | 397 | 99.87 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 100 | 8717.94 | 72.35 | 1079.7 | 421 | 99.75 |  |
|  Transformation | 2G | 1000 | 102400 | 0 | 100 | 10756.26 | 51.96 | 80.12 | 389 | 99.74 |  |
