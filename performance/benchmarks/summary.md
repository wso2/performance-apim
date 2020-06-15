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
|  Transformation | 2G | 50 | 50 | 0 | 0 | 2213.01 | 22.5 | 26.91 | 112 | 94.92 |  |
|  Transformation | 2G | 50 | 50 | 30 | 0 | 1443.85 | 34.55 | 25.6 | 98 | 96.64 |  |
|  Transformation | 2G | 50 | 50 | 500 | 0 | 99.47 | 502.89 | 4.63 | 511 | 99.57 |  |
|  Transformation | 2G | 50 | 50 | 1000 | 0 | 49.8 | 1002.42 | 1.97 | 1007 | 99.64 |  |
|  Transformation | 2G | 50 | 1024 | 0 | 0 | 1799.8 | 27.68 | 22.66 | 125 | 95.14 |  |
|  Transformation | 2G | 50 | 1024 | 30 | 0 | 1337.64 | 37.29 | 12.18 | 106 | 96.43 |  |
|  Transformation | 2G | 50 | 1024 | 500 | 0 | 99.43 | 502.95 | 4.05 | 509 | 99.5 |  |
|  Transformation | 2G | 50 | 1024 | 1000 | 0 | 49.78 | 1003.35 | 4.6 | 1015 | 99.62 |  |
|  Transformation | 2G | 50 | 10240 | 0 | 0 | 686.78 | 72.65 | 38.79 | 197 | 96.17 |  |
|  Transformation | 2G | 50 | 10240 | 30 | 0 | 645.37 | 77.33 | 24.89 | 164 | 96.42 |  |
|  Transformation | 2G | 50 | 10240 | 500 | 0 | 98.38 | 508.32 | 7.14 | 539 | 99.39 |  |
|  Transformation | 2G | 50 | 10240 | 1000 | 0 | 49.66 | 1005.52 | 5.21 | 1023 | 99.5 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2260.49 | 44.12 | 31.81 | 169 | 94.8 |  |
|  Transformation | 2G | 100 | 50 | 30 | 0 | 2047.98 | 48.73 | 19.54 | 142 | 95 |  |
|  Transformation | 2G | 100 | 50 | 500 | 0 | 198.91 | 502.95 | 5.1 | 515 | 99.4 |  |
|  Transformation | 2G | 100 | 50 | 1000 | 0 | 99.59 | 1003.12 | 4.61 | 1015 | 99.56 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 1867.33 | 53.43 | 35.21 | 186 | 94.85 |  |
|  Transformation | 2G | 100 | 1024 | 30 | 0 | 1748.31 | 57.09 | 23.17 | 159 | 95.15 |  |
|  Transformation | 2G | 100 | 1024 | 500 | 0 | 198.72 | 503.48 | 5.24 | 523 | 99.41 |  |
|  Transformation | 2G | 100 | 1024 | 1000 | 0 | 99.64 | 1002.8 | 4.77 | 1015 | 99.54 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 702.42 | 142.2 | 67.01 | 341 | 96.07 |  |
|  Transformation | 2G | 100 | 10240 | 30 | 0 | 704.76 | 141.7 | 50.49 | 293 | 95.91 |  |
|  Transformation | 2G | 100 | 10240 | 500 | 0 | 194.04 | 515.41 | 14.39 | 571 | 98.98 |  |
|  Transformation | 2G | 100 | 10240 | 1000 | 0 | 99.04 | 1008.23 | 7.64 | 1039 | 99.35 |  |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2217.77 | 90.05 | 49.18 | 257 | 94.75 |  |
|  Transformation | 2G | 200 | 50 | 30 | 0 | 2265.55 | 88.14 | 37.09 | 225 | 94.46 |  |
|  Transformation | 2G | 200 | 50 | 500 | 0 | 397.41 | 503.35 | 6.29 | 527 | 99.16 |  |
|  Transformation | 2G | 200 | 50 | 1000 | 0 | 199.13 | 1004.12 | 9.71 | 1047 | 99.46 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 1872.66 | 106.67 | 55.84 | 289 | 95.03 |  |
|  Transformation | 2G | 200 | 1024 | 30 | 0 | 1865.57 | 107.08 | 44.55 | 269 | 94.59 |  |
|  Transformation | 2G | 200 | 1024 | 500 | 0 | 396.06 | 504.81 | 8.13 | 543 | 99.03 |  |
|  Transformation | 2G | 200 | 1024 | 1000 | 0 | 199.15 | 1003.4 | 5.92 | 1031 | 99.37 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 677.4 | 295.28 | 119.83 | 623 | 96.23 |  |
|  Transformation | 2G | 200 | 10240 | 30 | 0 | 694.93 | 287.86 | 104.48 | 567 | 96.06 |  |
|  Transformation | 2G | 200 | 10240 | 500 | 0 | 353.85 | 565.05 | 60.42 | 755 | 98 |  |
|  Transformation | 2G | 200 | 10240 | 1000 | 0 | 196.1 | 1018.41 | 19.71 | 1103 | 98.96 |  |
|  Transformation | 2G | 300 | 50 | 0 | 0 | 2266.14 | 132.22 | 64.47 | 337 | 94.26 |  |
|  Transformation | 2G | 300 | 50 | 30 | 0 | 2228.36 | 134.51 | 55.14 | 311 | 94.51 |  |
|  Transformation | 2G | 300 | 50 | 500 | 0 | 593.82 | 505.18 | 9.99 | 559 | 98.59 |  |
|  Transformation | 2G | 300 | 50 | 1000 | 0 | 298.63 | 1003.03 | 5.64 | 1023 | 99.32 |  |
|  Transformation | 2G | 300 | 1024 | 0 | 0 | 1851.93 | 161.89 | 73.48 | 387 | 95.02 |  |
|  Transformation | 2G | 300 | 1024 | 30 | 0 | 1829.36 | 163.88 | 68.54 | 363 | 94.86 |  |
|  Transformation | 2G | 300 | 1024 | 500 | 0 | 589.61 | 508.68 | 13.94 | 575 | 98.35 |  |
|  Transformation | 2G | 300 | 1024 | 1000 | 0 | 298.56 | 1003.2 | 5.58 | 1023 | 99.25 |  |
|  Transformation | 2G | 300 | 10240 | 0 | 0 | 681.71 | 440.22 | 156.33 | 851 | 96.06 |  |
|  Transformation | 2G | 300 | 10240 | 30 | 0 | 688.16 | 435.95 | 149.66 | 827 | 96 |  |
|  Transformation | 2G | 300 | 10240 | 500 | 0 | 423.35 | 707.9 | 121.19 | 963 | 97.44 |  |
|  Transformation | 2G | 300 | 10240 | 1000 | 0 | 284.92 | 1051.65 | 59.5 | 1255 | 98.48 |  |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2241.77 | 223 | 98.11 | 475 | 94.26 |  |
|  Transformation | 2G | 500 | 50 | 30 | 0 | 2175.45 | 229.81 | 87.91 | 479 | 93.91 |  |
|  Transformation | 2G | 500 | 50 | 500 | 0 | 969.74 | 515.45 | 24.01 | 623 | 97.35 |  |
|  Transformation | 2G | 500 | 50 | 1000 | 0 | 496.82 | 1005.2 | 10.51 | 1063 | 98.73 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 1782.75 | 280.51 | 106.77 | 583 | 94.8 |  |
|  Transformation | 2G | 500 | 1024 | 30 | 0 | 1841.02 | 271.53 | 98.67 | 547 | 94.73 |  |
|  Transformation | 2G | 500 | 1024 | 500 | 0 | 954.37 | 523.79 | 28.97 | 639 | 97.19 |  |
|  Transformation | 2G | 500 | 1024 | 1000 | 0 | 496.14 | 1006.42 | 11.19 | 1063 | 98.54 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 664 | 752.59 | 224.26 | 1319 | 95.89 |  |
|  Transformation | 2G | 500 | 10240 | 30 | 0 | 656.62 | 761.21 | 208.81 | 1303 | 95.94 |  |
|  Transformation | 2G | 500 | 10240 | 500 | 0 | 556.45 | 898.22 | 191.19 | 1343 | 96.38 |  |
|  Transformation | 2G | 500 | 10240 | 1000 | 0 | 396.93 | 1256.82 | 183.9 | 1671 | 97.53 |  |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2135.08 | 468.25 | 147.39 | 863 | 93.29 |  |
|  Transformation | 2G | 1000 | 50 | 30 | 0 | 2126.66 | 470.1 | 148.74 | 855 | 93.03 |  |
|  Transformation | 2G | 1000 | 50 | 500 | 0 | 1715.68 | 582.29 | 66.73 | 795 | 94.19 |  |
|  Transformation | 2G | 1000 | 50 | 1000 | 0 | 977.32 | 1021.6 | 31.34 | 1151 | 96.85 |  |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 1791.67 | 557.86 | 170.4 | 1015 | 93.79 |  |
|  Transformation | 2G | 1000 | 1024 | 30 | 0 | 1742.93 | 573.6 | 175.84 | 1039 | 94.03 |  |
|  Transformation | 2G | 1000 | 1024 | 500 | 0 | 1522.11 | 656.47 | 104.63 | 979 | 93.99 |  |
|  Transformation | 2G | 1000 | 1024 | 1000 | 0 | 963.75 | 1035.75 | 42.53 | 1199 | 96.58 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 583.37 | 1711.18 | 374.99 | 2655 | 93.02 | 483 |
|  Transformation | 2G | 1000 | 10240 | 30 | 0 | 588.23 | 1697.24 | 317.53 | 2511 | 92.81 |  |
|  Transformation | 2G | 1000 | 10240 | 500 | 0 | 571.27 | 1745.8 | 422.03 | 2815 | 91.59 | 478 |
|  Transformation | 2G | 1000 | 10240 | 1000 | 0 | 524.66 | 1901.39 | 380.3 | 2719 | 94.15 |  |
