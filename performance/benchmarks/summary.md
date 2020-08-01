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
|  Passthrough | 2G | 50 | 50 | 0 | 0 | 2917.35 | 17.05 | 18.82 | 92 | 94.34 |  |
|  Passthrough | 2G | 50 | 1024 | 0 | 0 | 2862.26 | 17.38 | 17.5 | 91 | 94.82 |  |
|  Passthrough | 2G | 50 | 10240 | 0 | 0 | 1995.16 | 24.95 | 17.39 | 80 | 96.01 |  |
|  Passthrough | 2G | 50 | 102400 | 0 | 0 | 534.05 | 93.44 | 24.23 | 174 | 98.54 |  |
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 2978.65 | 33.47 | 26.35 | 152 | 94.55 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 2965.23 | 33.62 | 25.7 | 152 | 94.46 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 1999.06 | 49.89 | 27.99 | 165 | 95.93 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 509.15 | 196.22 | 40.8 | 327 | 98.58 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 3170.46 | 62.97 | 39.16 | 216 | 94.14 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 2941.92 | 67.87 | 41.71 | 228 | 94.46 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 1972.72 | 101.24 | 47.24 | 275 | 95.94 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 479.58 | 417.15 | 69.99 | 631 | 98.55 |  |
|  Passthrough | 2G | 300 | 50 | 0 | 0 | 3057.83 | 97.98 | 52.74 | 287 | 93.97 |  |
|  Passthrough | 2G | 300 | 1024 | 0 | 0 | 2964.68 | 101.07 | 52.86 | 291 | 94.26 |  |
|  Passthrough | 2G | 300 | 10240 | 0 | 0 | 1982.94 | 151.16 | 62.42 | 365 | 95.71 |  |
|  Passthrough | 2G | 300 | 102400 | 0 | 0 | 460.29 | 651.62 | 92.63 | 911 | 98.58 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 3082.28 | 162.1 | 74.25 | 395 | 93.69 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 2942.33 | 169.82 | 74.88 | 413 | 94.07 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 1981.7 | 252.25 | 87.63 | 519 | 95.58 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 447.21 | 1117 | 126.65 | 1455 | 98.53 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 2889.34 | 346.08 | 124.42 | 691 | 93.87 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 2881.28 | 347.02 | 124.04 | 691 | 93.92 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 1909.72 | 523.52 | 152.88 | 939 | 95.62 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 446.68 | 2233.65 | 177.75 | 2687 | 98.37 |  |
|  Transformation | 2G | 50 | 50 | 0 | 0 | 2327.43 | 21.4 | 21.76 | 121 | 94.07 |  |
|  Transformation | 2G | 50 | 1024 | 0 | 0 | 1965.75 | 25.35 | 21.98 | 124 | 94.66 |  |
|  Transformation | 2G | 50 | 10240 | 0 | 0 | 740.83 | 67.34 | 37.2 | 192 | 95.52 |  |
|  Transformation | 2G | 50 | 102400 | 0 | 0 | 105.11 | 475.75 | 124.52 | 791 | 96.15 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2371.55 | 42.06 | 32.35 | 173 | 93.94 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 1963.21 | 50.83 | 35.5 | 191 | 94.47 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 743.18 | 134.39 | 64.08 | 323 | 95.54 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 0 | 99.3 | 1006.41 | 651.98 | 1479 | 96.07 |  |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2483.4 | 80.41 | 47.92 | 252 | 93.8 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 1998.25 | 99.96 | 55.13 | 287 | 94.05 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 763.1 | 262.05 | 109.07 | 559 | 95.32 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 99.92 | 18858.39 | 8.63 | 65.15 | 32 | 94.98 |  |
|  Transformation | 2G | 300 | 50 | 0 | 0 | 2488.95 | 120.4 | 62.72 | 329 | 93.55 |  |
|  Transformation | 2G | 300 | 1024 | 0 | 0 | 1980.8 | 151.33 | 73 | 383 | 94.23 |  |
|  Transformation | 2G | 300 | 10240 | 0 | 0 | 709.5 | 422.86 | 154.29 | 827 | 95.69 |  |
|  Transformation | 2G | 300 | 102400 | 0 | 100 | 1.5 | 180672.28 | 247.36 | 181247 | 99.47 |  |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2384.08 | 209.69 | 89.57 | 471 | 93.56 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 1908.7 | 261.99 | 103.69 | 563 | 94.18 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 720.49 | 693.73 | 216.11 | 1295 | 95.15 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 100 | 22678.23 | 15.52 | 20.17 | 100 | 98.33 |  |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2324.66 | 430.07 | 145.21 | 819 | 92.2 | 733.667 |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 1896.94 | 527.05 | 166.65 | 967 | 93.26 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 606.31 | 1646.6 | 388.54 | 2623 | 92.1 | 419 |
|  Transformation | 2G | 1000 | 102400 | 0 | 100 | 22109.21 | 30.82 | 39.3 | 198 | 93.85 | 519 |
