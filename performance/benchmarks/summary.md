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
|  Passthrough | 2G | 50 | 50 | 0 | 0 | 2690.06 | 18.5 | 21.03 | 101 | 93.96 |  |
|  Passthrough | 2G | 50 | 1024 | 0 | 0 | 2580.05 | 19.29 | 19.8 | 96 | 94.3 |  |
|  Passthrough | 2G | 50 | 10240 | 0 | 0 | 1895.81 | 26.25 | 19.4 | 93 | 95.63 | 361 |
|  Passthrough | 2G | 50 | 102400 | 0 | 0 | 504.84 | 98.85 | 24.38 | 181 | 98.08 |  |
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 2743.32 | 36.34 | 29.2 | 164 | 94.03 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 2686.2 | 37.12 | 29.69 | 164 | 94.13 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 1898.34 | 52.54 | 30.63 | 173 | 95.8 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 500.12 | 199.75 | 38.45 | 319 | 98.08 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 2761.39 | 72.31 | 43.38 | 239 | 94.07 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 2684.34 | 74.4 | 44.28 | 247 | 94.01 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 1911.13 | 104.52 | 47.88 | 281 | 95.62 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 484.29 | 413.09 | 61.34 | 607 | 98.11 |  |
|  Passthrough | 2G | 300 | 50 | 0 | 0 | 2778.09 | 107.87 | 56.21 | 305 | 94.05 |  |
|  Passthrough | 2G | 300 | 1024 | 0 | 0 | 2693.99 | 111.24 | 55.6 | 309 | 94.35 |  |
|  Passthrough | 2G | 300 | 10240 | 0 | 0 | 1873.9 | 159.94 | 63.09 | 371 | 95.48 |  |
|  Passthrough | 2G | 300 | 102400 | 0 | 0 | 473.88 | 632.89 | 79.3 | 879 | 98.13 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 2739.43 | 182.43 | 79.1 | 433 | 93.88 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 2581.7 | 193.6 | 79.9 | 439 | 94.34 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 1868.5 | 267.57 | 91.95 | 555 | 95.52 | 291 |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 463.09 | 1078.77 | 110.81 | 1399 | 98.06 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 2649.94 | 377.41 | 134.49 | 747 | 93.25 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 2529.45 | 395.37 | 132.31 | 763 | 93.84 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 1843.4 | 542.35 | 144.36 | 943 | 95.16 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 453.65 | 2200.03 | 214.85 | 2911 | 97.73 |  |
|  Transformation | 2G | 50 | 50 | 0 | 0 | 2151.28 | 23.15 | 22.14 | 126 | 94.17 |  |
|  Transformation | 2G | 50 | 1024 | 0 | 0 | 1817.34 | 27.42 | 23.4 | 133 | 94.4 |  |
|  Transformation | 2G | 50 | 10240 | 0 | 0 | 706.62 | 70.59 | 40.68 | 205 | 95.13 |  |
|  Transformation | 2G | 50 | 102400 | 0 | 100 | 24154.91 | 1.6 | 1.31 | 6 | 93.94 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2167.78 | 46.03 | 33.83 | 179 | 94.03 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 1824.82 | 54.69 | 36.31 | 194 | 94.5 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 677.25 | 147.5 | 72.26 | 363 | 95.49 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 96.62 | 2530.35 | 38.59 | 190.77 | 1135 | 95.72 |  |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2176.76 | 91.75 | 53.3 | 279 | 93.71 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 1793.47 | 111.41 | 60.12 | 317 | 94.09 | 327 |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 700.77 | 285.43 | 118.98 | 623 | 95.07 | 301 |
|  Transformation | 2G | 200 | 102400 | 0 | 99.09 | 6640.41 | 28.06 | 222.96 | 92 | 94.32 |  |
|  Transformation | 2G | 300 | 50 | 0 | 0 | 2172.97 | 137.94 | 69.57 | 365 | 93.8 |  |
|  Transformation | 2G | 300 | 1024 | 0 | 0 | 1842.53 | 162.71 | 76.9 | 409 | 94.08 |  |
|  Transformation | 2G | 300 | 10240 | 0 | 0 | 664.03 | 451.87 | 164.76 | 903 | 95.29 |  |
|  Transformation | 2G | 300 | 102400 | 0 | 100 | 22842.45 | 10.03 | 9.78 | 49 | 94.44 |  |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2186.01 | 228.69 | 95.2 | 507 | 93.15 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 1796.1 | 278.42 | 109.18 | 595 | 93.99 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 669.81 | 746.14 | 222.79 | 1351 | 95.01 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 100 | 22418.99 | 16.08 | 20.3 | 100 | 92.86 |  |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2120.14 | 471.6 | 151.46 | 875 | 92.77 |  |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 1737.23 | 575.28 | 176.08 | 1047 | 93.24 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 585.53 | 1704.59 | 377.51 | 2767 | 91.26 | 445.667 |
|  Transformation | 2G | 1000 | 102400 | 0 | 100 | 22940.48 | 30.7 | 52.39 | 279 | 92.11 | 491 |
