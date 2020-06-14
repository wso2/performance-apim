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
|  Passthrough | 2G | 50 | 50 | 0 | 0 | 3142.49 | 15.82 | 23.73 | 85 | 94.83 |  |
|  Passthrough | 2G | 50 | 50 | 30 | 0 | 1524.84 | 32.71 | 38.59 | 47 | 97.58 |  |
|  Passthrough | 2G | 50 | 50 | 500 | 0 | 99.53 | 502.6 | 3.49 | 509 | 99.61 |  |
|  Passthrough | 2G | 50 | 50 | 1000 | 0 | 49.8 | 1002.3 | 2.32 | 1007 | 99.64 |  |
|  Passthrough | 2G | 50 | 1024 | 0 | 0 | 3029.29 | 16.42 | 16.27 | 83 | 94.94 |  |
|  Passthrough | 2G | 50 | 1024 | 30 | 0 | 1532.57 | 32.54 | 8.69 | 48 | 97.54 |  |
|  Passthrough | 2G | 50 | 1024 | 500 | 0 | 99.53 | 502.56 | 4.06 | 507 | 99.62 |  |
|  Passthrough | 2G | 50 | 1024 | 1000 | 0 | 49.83 | 1002.36 | 3.36 | 1007 | 99.64 |  |
|  Passthrough | 2G | 50 | 10240 | 0 | 0 | 2093.5 | 23.77 | 14.88 | 79 | 96.45 |  |
|  Passthrough | 2G | 50 | 10240 | 30 | 0 | 1458.41 | 34.19 | 12.32 | 58 | 97.16 |  |
|  Passthrough | 2G | 50 | 10240 | 500 | 0 | 99.42 | 502.94 | 3.81 | 507 | 99.57 |  |
|  Passthrough | 2G | 50 | 10240 | 1000 | 0 | 49.83 | 1002.39 | 2.39 | 1007 | 99.6 |  |
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 3253.09 | 30.63 | 24.04 | 141 | 94.37 |  |
|  Passthrough | 2G | 100 | 50 | 30 | 0 | 2657.97 | 37.53 | 15.18 | 129 | 95.45 |  |
|  Passthrough | 2G | 100 | 50 | 500 | 0 | 199.01 | 502.6 | 4.48 | 509 | 99.55 |  |
|  Passthrough | 2G | 100 | 50 | 1000 | 0 | 99.65 | 1002.49 | 3.57 | 1011 | 99.6 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 3143.03 | 31.71 | 23.43 | 138 | 94.57 |  |
|  Passthrough | 2G | 100 | 1024 | 30 | 0 | 2615.04 | 38.15 | 15.68 | 129 | 95.44 |  |
|  Passthrough | 2G | 100 | 1024 | 500 | 0 | 198.97 | 502.48 | 4.1 | 511 | 99.53 |  |
|  Passthrough | 2G | 100 | 1024 | 1000 | 0 | 99.7 | 1002.52 | 3.96 | 1011 | 99.59 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 2080.04 | 47.94 | 25.08 | 146 | 96.45 |  |
|  Passthrough | 2G | 100 | 10240 | 30 | 0 | 2027.18 | 49.2 | 18.4 | 135 | 96.58 |  |
|  Passthrough | 2G | 100 | 10240 | 500 | 0 | 198.96 | 502.81 | 4.24 | 511 | 99.55 |  |
|  Passthrough | 2G | 100 | 10240 | 1000 | 0 | 99.51 | 1002.58 | 3.25 | 1011 | 99.56 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 3266.4 | 61.09 | 36.34 | 200 | 94.17 |  |
|  Passthrough | 2G | 200 | 50 | 30 | 0 | 3187.71 | 62.62 | 27.67 | 184 | 94.52 |  |
|  Passthrough | 2G | 200 | 50 | 500 | 0 | 397.99 | 502.4 | 4.88 | 511 | 99.37 |  |
|  Passthrough | 2G | 200 | 50 | 1000 | 0 | 199.37 | 1002.6 | 4.45 | 1015 | 99.54 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 3178.4 | 62.8 | 35.6 | 202 | 94.56 |  |
|  Passthrough | 2G | 200 | 1024 | 30 | 0 | 3065.46 | 65.12 | 28.56 | 190 | 94.38 |  |
|  Passthrough | 2G | 200 | 1024 | 500 | 0 | 397.73 | 502.68 | 5.63 | 515 | 99.39 |  |
|  Passthrough | 2G | 200 | 1024 | 1000 | 0 | 199.2 | 1002.67 | 4.65 | 1011 | 99.56 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 2036.24 | 98.08 | 42.69 | 236 | 96.37 |  |
|  Passthrough | 2G | 200 | 10240 | 30 | 0 | 2109.71 | 94.64 | 36.47 | 229 | 96.12 |  |
|  Passthrough | 2G | 200 | 10240 | 500 | 0 | 397.09 | 503.47 | 6.66 | 523 | 99.37 |  |
|  Passthrough | 2G | 200 | 10240 | 1000 | 0 | 199.18 | 1002.93 | 5.3 | 1019 | 99.53 |  |
|  Passthrough | 2G | 300 | 50 | 0 | 0 | 3262.53 | 91.81 | 48.19 | 261 | 93.96 |  |
|  Passthrough | 2G | 300 | 50 | 30 | 0 | 3211.38 | 93.28 | 43 | 240 | 94.24 |  |
|  Passthrough | 2G | 300 | 50 | 500 | 0 | 596.11 | 503.04 | 7.87 | 527 | 99.1 |  |
|  Passthrough | 2G | 300 | 50 | 1000 | 0 | 298.89 | 1002.53 | 5.58 | 1011 | 99.45 |  |
|  Passthrough | 2G | 300 | 1024 | 0 | 0 | 3150.86 | 95.08 | 50.03 | 259 | 94.27 |  |
|  Passthrough | 2G | 300 | 1024 | 30 | 0 | 3094.54 | 96.8 | 40.94 | 249 | 94.37 |  |
|  Passthrough | 2G | 300 | 1024 | 500 | 0 | 596.27 | 503.04 | 7.88 | 527 | 99.08 |  |
|  Passthrough | 2G | 300 | 1024 | 1000 | 0 | 298.87 | 1002.67 | 5.46 | 1011 | 99.48 |  |
|  Passthrough | 2G | 300 | 10240 | 0 | 0 | 2032.91 | 147.44 | 59.14 | 331 | 96.13 |  |
|  Passthrough | 2G | 300 | 10240 | 30 | 0 | 2123.37 | 141.11 | 50.94 | 309 | 96.06 |  |
|  Passthrough | 2G | 300 | 10240 | 500 | 0 | 594.65 | 504.28 | 9.91 | 543 | 98.94 |  |
|  Passthrough | 2G | 300 | 10240 | 1000 | 0 | 298.69 | 1002.69 | 4.95 | 1015 | 99.46 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 3245.82 | 153.89 | 67.66 | 363 | 94.05 |  |
|  Passthrough | 2G | 500 | 50 | 30 | 0 | 3105.85 | 160.83 | 72.09 | 365 | 94.07 |  |
|  Passthrough | 2G | 500 | 50 | 500 | 0 | 985.12 | 507.36 | 17.48 | 603 | 98.19 |  |
|  Passthrough | 2G | 500 | 50 | 1000 | 0 | 497.92 | 1003.14 | 7.62 | 1031 | 99.08 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 3123.71 | 159.94 | 68.19 | 373 | 94.17 |  |
|  Passthrough | 2G | 500 | 1024 | 30 | 0 | 3110.53 | 160.62 | 63.2 | 365 | 94 |  |
|  Passthrough | 2G | 500 | 1024 | 500 | 0 | 987.97 | 506.08 | 15.63 | 591 | 98.17 |  |
|  Passthrough | 2G | 500 | 1024 | 1000 | 0 | 497.73 | 1003.03 | 7.54 | 1019 | 99.2 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 2069.54 | 241.53 | 96.15 | 511 | 95.84 |  |
|  Passthrough | 2G | 500 | 10240 | 30 | 0 | 2068.67 | 241.64 | 79.34 | 471 | 95.86 |  |
|  Passthrough | 2G | 500 | 10240 | 500 | 0 | 977.22 | 511.56 | 21.46 | 619 | 98.11 |  |
|  Passthrough | 2G | 500 | 10240 | 1000 | 0 | 496.99 | 1004.46 | 9.87 | 1055 | 99.16 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 3131.1 | 319.37 | 117.7 | 635 | 93 |  |
|  Passthrough | 2G | 1000 | 50 | 30 | 0 | 3032.59 | 329.7 | 118.24 | 655 | 93.04 |  |
|  Passthrough | 2G | 1000 | 50 | 500 | 0 | 1898.59 | 526.42 | 38.06 | 683 | 95.75 |  |
|  Passthrough | 2G | 1000 | 50 | 1000 | 0 | 989.68 | 1008.65 | 19.45 | 1127 | 97.89 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 2955.17 | 338.47 | 121.91 | 663 | 93.3 |  |
|  Passthrough | 2G | 1000 | 1024 | 30 | 0 | 2939.83 | 340.21 | 119.71 | 663 | 93.85 |  |
|  Passthrough | 2G | 1000 | 1024 | 500 | 0 | 1894.95 | 527.57 | 38.49 | 679 | 95.9 |  |
|  Passthrough | 2G | 1000 | 1024 | 1000 | 0 | 989.9 | 1008.86 | 19.51 | 1119 | 97.81 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 1987.66 | 503.15 | 144.16 | 887 | 95.7 |  |
|  Passthrough | 2G | 1000 | 10240 | 30 | 0 | 1949.97 | 512.81 | 141.05 | 891 | 95.84 |  |
|  Passthrough | 2G | 1000 | 10240 | 500 | 0 | 1715.46 | 582.51 | 76.29 | 827 | 95.81 |  |
|  Passthrough | 2G | 1000 | 10240 | 1000 | 0 | 980.14 | 1017.91 | 32.85 | 1175 | 97.61 |  |
