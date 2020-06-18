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
|  Passthrough | 2G | 50 | 50 | 0 | 0 | 2930.49 | 17.01 | 31.76 | 84 | 95.45 |  |
|  Passthrough | 2G | 50 | 50 | 30 | 0 | 1528.06 | 32.68 | 23.91 | 47 | 97.66 |  |
|  Passthrough | 2G | 50 | 50 | 500 | 0 | 99.43 | 502.86 | 3.83 | 509 | 99.63 |  |
|  Passthrough | 2G | 50 | 50 | 1000 | 0 | 49.84 | 1002.5 | 2.74 | 1007 | 99.65 |  |
|  Passthrough | 2G | 50 | 1024 | 0 | 0 | 2851.39 | 17.48 | 16.01 | 81 | 95.58 |  |
|  Passthrough | 2G | 50 | 1024 | 30 | 0 | 1529.71 | 32.64 | 8.61 | 47 | 97.56 |  |
|  Passthrough | 2G | 50 | 1024 | 500 | 0 | 99.46 | 502.94 | 4.69 | 509 | 99.65 |  |
|  Passthrough | 2G | 50 | 1024 | 1000 | 0 | 49.81 | 1002.41 | 2.82 | 1007 | 99.64 |  |
|  Passthrough | 2G | 50 | 10240 | 0 | 0 | 1930.3 | 25.83 | 16.07 | 80 | 96.58 |  |
|  Passthrough | 2G | 50 | 10240 | 30 | 0 | 1437.83 | 34.72 | 12.06 | 59 | 97.31 |  |
|  Passthrough | 2G | 50 | 10240 | 500 | 0 | 99.43 | 503.25 | 4.51 | 509 | 99.6 |  |
|  Passthrough | 2G | 50 | 10240 | 1000 | 0 | 49.8 | 1002.54 | 2.98 | 1007 | 99.63 |  |
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 2996.81 | 33.3 | 24.53 | 142 | 95.11 |  |
|  Passthrough | 2G | 100 | 50 | 30 | 0 | 2583.05 | 38.66 | 16.17 | 130 | 95.62 |  |
|  Passthrough | 2G | 100 | 50 | 500 | 0 | 199.06 | 502.59 | 2.97 | 509 | 99.58 |  |
|  Passthrough | 2G | 100 | 50 | 1000 | 0 | 99.66 | 1002.32 | 3 | 1007 | 99.66 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 2912.17 | 34.27 | 23.13 | 136 | 95.42 |  |
|  Passthrough | 2G | 100 | 1024 | 30 | 0 | 2543.53 | 39.26 | 16.67 | 132 | 95.56 |  |
|  Passthrough | 2G | 100 | 1024 | 500 | 0 | 198.97 | 502.82 | 4.17 | 511 | 99.56 |  |
|  Passthrough | 2G | 100 | 1024 | 1000 | 0 | 99.66 | 1002.55 | 4.59 | 1011 | 99.63 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 1878.08 | 53.16 | 25.69 | 150 | 96.85 |  |
|  Passthrough | 2G | 100 | 10240 | 30 | 0 | 1878.24 | 53.14 | 19.92 | 147 | 96.63 |  |
|  Passthrough | 2G | 100 | 10240 | 500 | 0 | 198.93 | 502.96 | 3.46 | 511 | 99.56 |  |
|  Passthrough | 2G | 100 | 10240 | 1000 | 0 | 99.58 | 1002.49 | 2.63 | 1011 | 99.65 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 3036.88 | 65.78 | 35.99 | 201 | 95.12 |  |
|  Passthrough | 2G | 200 | 50 | 30 | 0 | 3009.37 | 66.38 | 28.9 | 184 | 95.24 |  |
|  Passthrough | 2G | 200 | 50 | 500 | 0 | 397.65 | 502.91 | 5.76 | 515 | 99.42 |  |
|  Passthrough | 2G | 200 | 50 | 1000 | 0 | 199.29 | 1002.47 | 3.91 | 1011 | 99.55 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 2923.53 | 68.33 | 36.4 | 199 | 95.32 |  |
|  Passthrough | 2G | 200 | 1024 | 30 | 0 | 2876.98 | 69.44 | 28.87 | 192 | 95.16 |  |
|  Passthrough | 2G | 200 | 1024 | 500 | 0 | 397.77 | 502.84 | 5.15 | 515 | 99.42 |  |
|  Passthrough | 2G | 200 | 1024 | 1000 | 0 | 199.25 | 1002.51 | 4.26 | 1011 | 99.56 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 1875.84 | 106.51 | 43.64 | 249 | 96.66 |  |
|  Passthrough | 2G | 200 | 10240 | 30 | 0 | 1914.05 | 104.35 | 38.95 | 241 | 96.67 |  |
|  Passthrough | 2G | 200 | 10240 | 500 | 0 | 397.45 | 503.27 | 5.19 | 519 | 99.4 |  |
|  Passthrough | 2G | 200 | 10240 | 1000 | 0 | 199.19 | 1002.57 | 4.01 | 1011 | 99.53 |  |
|  Passthrough | 2G | 300 | 50 | 0 | 0 | 3152.03 | 95.05 | 57.58 | 253 | 94.63 |  |
|  Passthrough | 2G | 300 | 50 | 30 | 0 | 3124.43 | 95.88 | 49.57 | 242 | 94.94 |  |
|  Passthrough | 2G | 300 | 50 | 500 | 0 | 595.92 | 503.34 | 8.74 | 535 | 99.18 |  |
|  Passthrough | 2G | 300 | 50 | 1000 | 0 | 298.88 | 1002.31 | 3.33 | 1007 | 99.52 |  |
|  Passthrough | 2G | 300 | 1024 | 0 | 0 | 3000.85 | 99.85 | 47.19 | 259 | 95.16 |  |
|  Passthrough | 2G | 300 | 1024 | 30 | 0 | 2961.92 | 101.16 | 41.39 | 252 | 95.08 |  |
|  Passthrough | 2G | 300 | 1024 | 500 | 0 | 596.06 | 503.2 | 7.55 | 531 | 99.05 |  |
|  Passthrough | 2G | 300 | 1024 | 1000 | 0 | 299.04 | 1002.8 | 5.46 | 1019 | 99.48 |  |
|  Passthrough | 2G | 300 | 10240 | 0 | 0 | 1955.21 | 153.32 | 58.25 | 333 | 96.57 |  |
|  Passthrough | 2G | 300 | 10240 | 30 | 0 | 2020.77 | 148.3 | 54.26 | 323 | 96.54 |  |
|  Passthrough | 2G | 300 | 10240 | 500 | 0 | 594.7 | 504.3 | 9.01 | 543 | 99.04 |  |
|  Passthrough | 2G | 300 | 10240 | 1000 | 0 | 298.87 | 1002.68 | 4.54 | 1015 | 99.47 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 3103.56 | 160.99 | 67.67 | 369 | 94.6 |  |
|  Passthrough | 2G | 500 | 50 | 30 | 0 | 3038.72 | 164.41 | 63.48 | 363 | 94.79 |  |
|  Passthrough | 2G | 500 | 50 | 500 | 0 | 987.96 | 505.87 | 14.63 | 583 | 98.39 |  |
|  Passthrough | 2G | 500 | 50 | 1000 | 0 | 497.56 | 1003.21 | 7.67 | 1031 | 99.23 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 2981.46 | 167.59 | 69.84 | 379 | 94.79 |  |
|  Passthrough | 2G | 500 | 1024 | 30 | 0 | 2970.33 | 168.22 | 64.85 | 371 | 94.9 |  |
|  Passthrough | 2G | 500 | 1024 | 500 | 0 | 987.15 | 506.52 | 14.94 | 587 | 98.31 |  |
|  Passthrough | 2G | 500 | 1024 | 1000 | 0 | 497.93 | 1002.89 | 6.78 | 1019 | 99.22 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 1934.19 | 258.5 | 87.35 | 507 | 96.69 |  |
|  Passthrough | 2G | 500 | 10240 | 30 | 0 | 1995.24 | 250.56 | 83.82 | 481 | 96.23 |  |
|  Passthrough | 2G | 500 | 10240 | 500 | 0 | 976.89 | 511.65 | 21.89 | 619 | 98.18 |  |
|  Passthrough | 2G | 500 | 10240 | 1000 | 0 | 497.15 | 1004.05 | 8.65 | 1047 | 99.22 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 3038.55 | 329.09 | 121.51 | 655 | 93.56 |  |
|  Passthrough | 2G | 1000 | 50 | 30 | 0 | 2998.11 | 333.56 | 116.82 | 651 | 93.6 |  |
|  Passthrough | 2G | 1000 | 50 | 500 | 0 | 1898.18 | 526.65 | 36.97 | 675 | 96.12 |  |
|  Passthrough | 2G | 1000 | 50 | 1000 | 0 | 990.1 | 1007.88 | 17.55 | 1111 | 98.06 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 2933.65 | 340.91 | 115.24 | 663 | 93.97 |  |
|  Passthrough | 2G | 1000 | 1024 | 30 | 0 | 2864.7 | 349.13 | 119.14 | 679 | 94.23 |  |
|  Passthrough | 2G | 1000 | 1024 | 500 | 0 | 1898.57 | 526.36 | 35.86 | 671 | 96.27 |  |
|  Passthrough | 2G | 1000 | 1024 | 1000 | 0 | 990.04 | 1008.31 | 18.35 | 1111 | 98.11 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 1916.24 | 521.68 | 159.99 | 991 | 96.17 |  |
|  Passthrough | 2G | 1000 | 10240 | 30 | 0 | 1932.72 | 517.33 | 134.46 | 871 | 96.13 |  |
|  Passthrough | 2G | 1000 | 10240 | 500 | 0 | 1699.38 | 588.04 | 81.34 | 843 | 96.06 |  |
|  Passthrough | 2G | 1000 | 10240 | 1000 | 0 | 978.58 | 1020.06 | 35.26 | 1183 | 97.78 |  |
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
