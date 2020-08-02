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
| Concurrent Users | The number of users accessing the application at the same time. | 50, 100, 200, 300, 500, 1000 |
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
|  Passthrough | 2G | 50 | 50 | 0 | 0 | 2938.13 | 16.93 | 18.37 | 93 | 94.61 |  |
|  Passthrough | 2G | 50 | 1024 | 0 | 0 | 2901.89 | 17.14 | 16.97 | 91 | 94.81 |  |
|  Passthrough | 2G | 50 | 10240 | 0 | 0 | 2049.49 | 24.28 | 17.16 | 78 | 96.1 |  |
|  Passthrough | 2G | 50 | 102400 | 0 | 0 | 524.95 | 95.05 | 24.58 | 179 | 98.49 |  |
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 2952.36 | 33.75 | 26.19 | 152 | 94.65 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 2968.19 | 33.58 | 27.51 | 152 | 93.98 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 2022.83 | 49.28 | 28.07 | 163 | 95.85 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 507.15 | 196.99 | 41.49 | 327 | 98.57 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 3085.71 | 64.69 | 40.43 | 220 | 94.31 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 3012.48 | 66.27 | 39.2 | 220 | 94.35 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 1982.52 | 100.72 | 45.54 | 263 | 95.92 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 477.46 | 418.98 | 67.95 | 623 | 98.62 |  |
|  Passthrough | 2G | 300 | 50 | 0 | 0 | 3103.2 | 96.53 | 51.88 | 281 | 93.96 |  |
|  Passthrough | 2G | 300 | 1024 | 0 | 0 | 2902.43 | 103.23 | 52.72 | 289 | 94.34 |  |
|  Passthrough | 2G | 300 | 10240 | 0 | 0 | 1991.44 | 150.49 | 61.61 | 359 | 96 |  |
|  Passthrough | 2G | 300 | 102400 | 0 | 0 | 464.36 | 645.91 | 90.63 | 903 | 98.62 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 3105.74 | 160.85 | 73.89 | 397 | 93.88 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 2942.81 | 169.76 | 73.27 | 405 | 94.34 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 1976.89 | 252.86 | 90.12 | 523 | 95.7 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 449.99 | 1110.18 | 124.21 | 1439 | 98.58 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 2958.25 | 337.99 | 123.1 | 675 | 93.51 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 2773.53 | 360.58 | 127.84 | 719 | 93.96 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 1908.4 | 523.94 | 159.82 | 967 | 95.73 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 443.48 | 2249.46 | 181.39 | 2719 | 98.41 |  |
|  Transformation | 2G | 50 | 50 | 0 | 0 | 2331.07 | 21.35 | 20.66 | 118 | 94.31 |  |
|  Transformation | 2G | 50 | 1024 | 0 | 0 | 1978.73 | 25.17 | 22.34 | 127 | 94.5 |  |
|  Transformation | 2G | 50 | 10240 | 0 | 0 | 759.49 | 65.67 | 36.54 | 187 | 95.45 |  |
|  Transformation | 2G | 50 | 102400 | 0 | 0 | 103.48 | 483.11 | 129.23 | 803 | 96.16 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2352.91 | 42.39 | 31.67 | 170 | 94.23 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 1989.77 | 50.13 | 34.39 | 184 | 94.48 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 762.34 | 130.96 | 63.63 | 321 | 95.27 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 69.56 | 295.7 | 336.97 | 1393.47 | 1351 | 95.99 |  |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2413.17 | 82.75 | 48.42 | 257 | 93.93 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 1993.46 | 100.19 | 54.95 | 289 | 94.26 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 734.98 | 272.1 | 111.58 | 583 | 95.43 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 100 | 21529.37 | 7.23 | 6.39 | 32 | 95.55 |  |
|  Transformation | 2G | 300 | 50 | 0 | 0 | 2436.64 | 122.97 | 63.45 | 333 | 93.87 |  |
|  Transformation | 2G | 300 | 1024 | 0 | 0 | 1944.34 | 154.17 | 72.4 | 379 | 94.24 |  |
|  Transformation | 2G | 300 | 10240 | 0 | 0 | 711.28 | 421.83 | 154.13 | 835 | 95.6 |  |
|  Transformation | 2G | 300 | 102400 | 0 | 100 | 19755.64 | 11.14 | 51.33 | 58 | 97.7 |  |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2373.59 | 210.59 | 90.05 | 479 | 93.64 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 1930.78 | 258.9 | 103.41 | 559 | 94.05 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 716.87 | 697.27 | 222.1 | 1279 | 95.24 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 99.92 | 17083.53 | 22.33 | 197.62 | 104 | 92.82 |  |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2283 | 437.97 | 145.99 | 823 | 92.64 |  |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 1918.51 | 520.96 | 166.01 | 963 | 93.36 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 628.36 | 1588.31 | 388.44 | 2623 | 92.27 | 451.5 |
|  Transformation | 2G | 1000 | 102400 | 0 | 100 | 20808.52 | 33.59 | 34.85 | 166 | 96.64 |  |
