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
|  Passthrough | 2G | 50 | 50 | 0 | 0 | 2754.64 | 18.06 | 18.42 | 98 | 94.06 | 327 |
|  Passthrough | 2G | 50 | 1024 | 0 | 0 | 2705.25 | 18.4 | 18.56 | 91 | 94.1 |  |
|  Passthrough | 2G | 50 | 10240 | 0 | 0 | 1938.85 | 25.67 | 19.02 | 95 | 95.44 |  |
|  Passthrough | 2G | 50 | 102400 | 0 | 0 | 519.54 | 96.05 | 23.19 | 176 | 98.05 |  |
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 2819.88 | 35.35 | 27.13 | 155 | 94.1 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 2800.06 | 35.62 | 27.38 | 149 | 94.26 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 1916.9 | 52.02 | 30.48 | 174 | 95.58 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 518.97 | 192.49 | 36.59 | 317 | 98.07 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 2832.56 | 70.49 | 42.21 | 228 | 94.07 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 2797.17 | 71.39 | 41.94 | 233 | 94.12 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 1935.67 | 103.17 | 48.94 | 281 | 95.52 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 496.59 | 402.88 | 59.76 | 595 | 98.13 |  |
|  Passthrough | 2G | 300 | 50 | 0 | 0 | 2810.8 | 106.61 | 55.34 | 301 | 94.13 |  |
|  Passthrough | 2G | 300 | 1024 | 0 | 0 | 2782.01 | 107.71 | 54.31 | 295 | 94.04 |  |
|  Passthrough | 2G | 300 | 10240 | 0 | 0 | 1945.8 | 154.02 | 62.39 | 377 | 95.47 |  |
|  Passthrough | 2G | 300 | 102400 | 0 | 0 | 482.53 | 621.6 | 80.09 | 883 | 98.01 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 2804.02 | 178.19 | 78.99 | 427 | 93.87 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 2717.59 | 183.91 | 77.17 | 427 | 93.91 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 1956.73 | 255.52 | 86.9 | 523 | 95.32 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 476.86 | 1047.68 | 113.62 | 1407 | 98.04 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 2723.82 | 367.21 | 130.07 | 723 | 93.29 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 2576.01 | 388.25 | 130.43 | 751 | 93.87 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 1893.93 | 527.89 | 139.95 | 911 | 95.26 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 462.14 | 2159.4 | 200.82 | 2815 | 97.82 |  |
|  Transformation | 2G | 50 | 50 | 0 | 0 | 2192.99 | 22.71 | 21.16 | 120 | 93.95 | 350 |
|  Transformation | 2G | 50 | 1024 | 0 | 0 | 1874.52 | 26.58 | 22.91 | 128 | 94.2 |  |
|  Transformation | 2G | 50 | 10240 | 0 | 0 | 709.49 | 70.3 | 40.26 | 204 | 95.34 |  |
|  Transformation | 2G | 50 | 102400 | 0 | 0.09 | 91.31 | 547.62 | 310.3 | 895 | 95.88 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2287.07 | 43.61 | 32.17 | 171 | 93.96 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 1861.84 | 53.6 | 36.64 | 196 | 94.25 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 698.33 | 143.02 | 70.59 | 357 | 95.43 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 0 | 100.19 | 997.27 | 178.92 | 1463 | 95.64 |  |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2328.93 | 85.75 | 50.02 | 261 | 93.77 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 1849.2 | 107.99 | 59.21 | 311 | 93.9 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 698.73 | 286.21 | 120.64 | 623 | 95.26 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 99.92 | 18378.74 | 8.85 | 77.61 | 33 | 93.91 |  |
|  Transformation | 2G | 300 | 50 | 0 | 0 | 2288.98 | 130.93 | 65.84 | 347 | 93.63 | 326 |
|  Transformation | 2G | 300 | 1024 | 0 | 0 | 1837.94 | 163.12 | 76.56 | 401 | 94.09 |  |
|  Transformation | 2G | 300 | 10240 | 0 | 0 | 685.24 | 437.86 | 162.27 | 887 | 95.25 |  |
|  Transformation | 2G | 300 | 102400 | 0 | 100 | 22637.86 | 9.93 | 10.27 | 52 | 93.51 | 372 |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2273.33 | 219.89 | 92.23 | 489 | 93.15 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 1849.9 | 270.28 | 105.57 | 575 | 93.95 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 669.5 | 746.44 | 230.54 | 1367 | 95.04 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 0 | 70.93 | 7010.37 | 4844.18 | 43007 | 90.75 | 352 |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2158.27 | 463.27 | 151.01 | 863 | 91.97 | 641 |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 1797.04 | 556.38 | 167.36 | 1011 | 93.47 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 587.26 | 1699.77 | 362.71 | 2767 | 92.88 | 435 |
|  Transformation | 2G | 1000 | 102400 | 0 | 100 | 21991.34 | 30.71 | 34.77 | 166 | 96.08 |  |
