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
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 3855.2 | 25.86 | 24.03 | 107 | 98.58 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 3539.08 | 28.18 | 27.04 | 124 | 98.67 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 2665.92 | 37.4 | 25.57 | 96 | 98.93 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 805.65 | 123.91 | 17.52 | 173 | 99.4 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 3546.49 | 56.31 | 42.47 | 215 | 98.58 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 3444.36 | 57.97 | 41.78 | 212 | 98.6 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 2680.4 | 74.5 | 40.34 | 184 | 98.87 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 766.65 | 260.87 | 27.8 | 345 | 99.42 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 3676.69 | 135.91 | 117.28 | 675 | 98.14 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 3578.7 | 139.62 | 114.9 | 651 | 98.31 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 2690.82 | 185.66 | 72.23 | 491 | 98.62 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 710.24 | 703.73 | 56.37 | 875 | 99.34 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 3513.91 | 284.42 | 298.17 | 1335 | 97.73 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 3193.62 | 313.1 | 193.64 | 1119 | 97.68 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 2706.65 | 369.52 | 107.62 | 771 | 98.25 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 682.41 | 1463.33 | 125.93 | 1919 | 99.17 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2723.26 | 36.64 | 36.87 | 152 | 98.14 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 2270.04 | 43.95 | 48.66 | 186 | 98.08 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 776.11 | 128.73 | 149.26 | 975 | 98.2 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 0 | 96.56 | 1034.77 | 128.42 | 1335 | 95.98 |  |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2749.79 | 72.64 | 59.54 | 289 | 97.96 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 2323.35 | 85.98 | 73.84 | 369 | 97.89 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 785.72 | 254.52 | 218.82 | 1471 | 97.94 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 0 | 76.7 | 2602.01 | 489.49 | 4255 | 88.19 | 362 |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2789.7 | 179.14 | 115.9 | 659 | 97.36 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 2298.83 | 217.47 | 128.43 | 751 | 97.31 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 770.68 | 648.52 | 378.41 | 2207 | 97.27 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 0 | 71.71 | 6930.13 | 887.84 | 9087 | 86.93 | 474.424 |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2691.43 | 371.44 | 228.94 | 1383 | 95.96 |  |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 2172.44 | 460.12 | 209.1 | 1175 | 95.93 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 685.57 | 1457.93 | 679.34 | 3487 | 94.7 |  |
|  Transformation | 2G | 1000 | 102400 | 0 | 0 | 57.69 | 17028.65 | 1885.59 | 21631 | 76.45 | 592.566 |
