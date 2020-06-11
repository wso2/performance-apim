# WSO2 API Manager Performance Test Results

During each release, we execute various automated performance test scenarios and publish the results.

| Test Scenarios | Description |
| --- | --- |
| Passthrough | A secured API, which directly invokes the back-end service. |

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
