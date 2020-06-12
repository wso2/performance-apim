# WSO2 API Manager Performance Test Results

During each release, we execute various automated performance test scenarios and publish the results.

| Test Scenarios | Description |
| --- | --- |
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
| Message Size (Bytes) | The request payload size in Bytes. | 50, 1024, 10240 |
| Back-end Delay (ms) | The delay added by the back-end service. | 0, 30, 500, 1000 |

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
|  Transformation | 2G | 50 | 50 | 0 | 0 | 2184.13 | 22.83 | 38.38 | 110 | 95.2 |  |
|  Transformation | 2G | 50 | 50 | 30 | 0 | 1450.91 | 34.42 | 10.42 | 99 | 96.64 |  |
|  Transformation | 2G | 50 | 50 | 500 | 0 | 99.42 | 503.36 | 5.78 | 515 | 99.58 |  |
|  Transformation | 2G | 50 | 50 | 1000 | 0 | 49.81 | 1002.76 | 4.37 | 1007 | 99.61 |  |
|  Transformation | 2G | 50 | 1024 | 0 | 0 | 1822.96 | 27.36 | 22.01 | 124 | 95.17 |  |
|  Transformation | 2G | 50 | 1024 | 30 | 0 | 1345.45 | 37.11 | 12.28 | 106 | 96.42 |  |
|  Transformation | 2G | 50 | 1024 | 500 | 0 | 99.34 | 503.65 | 5.32 | 515 | 99.56 |  |
|  Transformation | 2G | 50 | 1024 | 1000 | 0 | 49.79 | 1003.99 | 7.01 | 1023 | 99.61 |  |
|  Transformation | 2G | 50 | 10240 | 0 | 0 | 704.8 | 70.8 | 38 | 196 | 96.06 |  |
|  Transformation | 2G | 50 | 10240 | 30 | 0 | 642.66 | 77.66 | 25.05 | 163 | 96.36 |  |
|  Transformation | 2G | 50 | 10240 | 500 | 0 | 98.02 | 510.05 | 8.46 | 547 | 99.41 |  |
|  Transformation | 2G | 50 | 10240 | 1000 | 0 | 49.64 | 1006.3 | 4.74 | 1019 | 99.52 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2298.47 | 43.42 | 30.95 | 165 | 94.53 |  |
|  Transformation | 2G | 100 | 50 | 30 | 0 | 2092.47 | 47.71 | 18.84 | 139 | 94.92 |  |
|  Transformation | 2G | 100 | 50 | 500 | 0 | 198.77 | 503.28 | 5.13 | 515 | 99.44 |  |
|  Transformation | 2G | 100 | 50 | 1000 | 0 | 99.6 | 1003.18 | 6.72 | 1019 | 99.58 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 1846.88 | 54.07 | 35.94 | 186 | 94.94 |  |
|  Transformation | 2G | 100 | 1024 | 30 | 0 | 1770.72 | 56.4 | 21.97 | 155 | 95.17 |  |
|  Transformation | 2G | 100 | 1024 | 500 | 0 | 198.68 | 503.41 | 4.7 | 519 | 99.4 |  |
|  Transformation | 2G | 100 | 1024 | 1000 | 0 | 99.59 | 1002.8 | 3.7 | 1011 | 99.54 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 698.39 | 143.06 | 66.92 | 341 | 96.05 |  |
|  Transformation | 2G | 100 | 10240 | 30 | 0 | 721.49 | 138.42 | 49.39 | 287 | 95.85 |  |
|  Transformation | 2G | 100 | 10240 | 500 | 0 | 193.47 | 516.83 | 15.35 | 575 | 99.04 |  |
|  Transformation | 2G | 100 | 10240 | 1000 | 0 | 98.92 | 1009.73 | 9.43 | 1055 | 99.38 |  |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2376.45 | 84.05 | 47.35 | 245 | 94.59 |  |
|  Transformation | 2G | 200 | 50 | 30 | 0 | 2303.5 | 86.73 | 38.43 | 226 | 94.43 |  |
|  Transformation | 2G | 200 | 50 | 500 | 0 | 397.47 | 503.2 | 5.64 | 523 | 99.13 |  |
|  Transformation | 2G | 200 | 50 | 1000 | 0 | 199.18 | 1002.56 | 4.27 | 1011 | 99.46 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 1873.47 | 106.63 | 58.22 | 295 | 94.74 |  |
|  Transformation | 2G | 200 | 1024 | 30 | 0 | 1880.04 | 106.29 | 44.99 | 265 | 94.67 |  |
|  Transformation | 2G | 200 | 1024 | 500 | 0 | 396.68 | 504.33 | 7.07 | 535 | 99.05 |  |
|  Transformation | 2G | 200 | 1024 | 1000 | 0 | 198.95 | 1003.21 | 5.25 | 1023 | 99.38 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 700.92 | 285.38 | 112.15 | 599 | 96.08 |  |
|  Transformation | 2G | 200 | 10240 | 30 | 0 | 711.23 | 281.17 | 101.48 | 555 | 95.91 |  |
|  Transformation | 2G | 200 | 10240 | 500 | 0 | 352.65 | 567.02 | 61.1 | 755 | 98.06 |  |
|  Transformation | 2G | 200 | 10240 | 1000 | 0 | 195.5 | 1021.29 | 23.39 | 1119 | 98.98 |  |
|  Transformation | 2G | 300 | 50 | 0 | 0 | 2271.78 | 131.93 | 107.69 | 333 | 94.29 |  |
|  Transformation | 2G | 300 | 50 | 30 | 0 | 2154.52 | 139.12 | 108.17 | 317 | 94.62 |  |
|  Transformation | 2G | 300 | 50 | 500 | 0 | 593.53 | 505.39 | 10.42 | 559 | 98.59 |  |
|  Transformation | 2G | 300 | 50 | 1000 | 0 | 298.64 | 1003.06 | 5.5 | 1023 | 99.32 |  |
|  Transformation | 2G | 300 | 1024 | 0 | 0 | 1843.54 | 162.61 | 71.84 | 381 | 95.22 |  |
|  Transformation | 2G | 300 | 1024 | 30 | 0 | 1842.6 | 162.69 | 69 | 365 | 94.93 |  |
|  Transformation | 2G | 300 | 1024 | 500 | 0 | 589.03 | 509.24 | 15.79 | 587 | 98.33 |  |
|  Transformation | 2G | 300 | 1024 | 1000 | 0 | 298.64 | 1003.33 | 5.53 | 1023 | 99.25 |  |
|  Transformation | 2G | 300 | 10240 | 0 | 0 | 690.41 | 434.61 | 157.31 | 843 | 96.01 |  |
|  Transformation | 2G | 300 | 10240 | 30 | 0 | 680.17 | 441.18 | 147.49 | 827 | 95.94 |  |
|  Transformation | 2G | 300 | 10240 | 500 | 0 | 435.53 | 688.4 | 113.69 | 939 | 97.37 |  |
|  Transformation | 2G | 300 | 10240 | 1000 | 0 | 282.68 | 1060 | 66.76 | 1287 | 98.44 |  |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2244.28 | 222.73 | 90.42 | 481 | 94.16 |  |
|  Transformation | 2G | 500 | 50 | 30 | 0 | 2216.37 | 225.53 | 87.83 | 467 | 94.09 |  |
|  Transformation | 2G | 500 | 50 | 500 | 0 | 970.37 | 515.14 | 24.81 | 627 | 97.4 |  |
|  Transformation | 2G | 500 | 50 | 1000 | 0 | 496.88 | 1004.78 | 9.9 | 1055 | 98.76 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 1809.4 | 276.31 | 103.82 | 571 | 94.88 |  |
|  Transformation | 2G | 500 | 1024 | 30 | 0 | 1782.49 | 280.54 | 107 | 563 | 94.98 |  |
|  Transformation | 2G | 500 | 1024 | 500 | 0 | 958.74 | 521.42 | 26.64 | 631 | 97.18 |  |
|  Transformation | 2G | 500 | 1024 | 1000 | 0 | 496.01 | 1006.64 | 11.72 | 1071 | 98.58 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 640.33 | 780.45 | 235.6 | 1399 | 95.96 |  |
|  Transformation | 2G | 500 | 10240 | 30 | 0 | 673.49 | 742.13 | 204.89 | 1263 | 95.64 |  |
|  Transformation | 2G | 500 | 10240 | 500 | 0 | 527.88 | 946.65 | 191.93 | 1327 | 96.65 |  |
|  Transformation | 2G | 500 | 10240 | 1000 | 0 | 403.1 | 1238.71 | 176.82 | 1647 | 97.48 |  |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2105.61 | 474.89 | 155.06 | 879 | 93.09 |  |
|  Transformation | 2G | 1000 | 50 | 30 | 0 | 2120.4 | 471.5 | 151.07 | 867 | 93.51 |  |
|  Transformation | 2G | 1000 | 50 | 500 | 0 | 1707.93 | 585.15 | 69.32 | 815 | 94.13 |  |
|  Transformation | 2G | 1000 | 50 | 1000 | 0 | 977.27 | 1021.31 | 31.27 | 1151 | 96.9 |  |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 1749.98 | 571.31 | 167.61 | 1023 | 94.14 |  |
|  Transformation | 2G | 1000 | 1024 | 30 | 0 | 1760.76 | 567.81 | 173.37 | 1023 | 94 |  |
|  Transformation | 2G | 1000 | 1024 | 500 | 0 | 1508.86 | 662.13 | 106.68 | 987 | 94.18 |  |
|  Transformation | 2G | 1000 | 1024 | 1000 | 0 | 964.86 | 1034.73 | 41.7 | 1199 | 96.53 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 595.98 | 1675.14 | 361.69 | 2575 | 92.65 |  |
|  Transformation | 2G | 1000 | 10240 | 30 | 0 | 651.08 | 1533.14 | 298.36 | 2271 | 95.14 |  |
|  Transformation | 2G | 1000 | 10240 | 500 | 0 | 594.59 | 1678.85 | 393.72 | 2655 | 92.31 | 496 |
|  Transformation | 2G | 1000 | 10240 | 1000 | 0 | 523.05 | 1906.42 | 385.68 | 2767 | 94.12 |  |
