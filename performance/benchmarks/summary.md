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
|  Passthrough | 2G | 50 | 50 | 0 | 0 | 2563.16 | 19.42 | 19.17 | 100 | 95.13 |  |
|  Passthrough | 2G | 50 | 1024 | 0 | 0 | 2516.81 | 19.78 | 19.05 | 97 | 95.3 |  |
|  Passthrough | 2G | 50 | 10240 | 0 | 0 | 1804.79 | 27.59 | 18.13 | 89 | 96.5 |  |
|  Passthrough | 2G | 50 | 102400 | 0 | 0 | 488.12 | 102.25 | 25.7 | 190 | 98.68 |  |
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 2623.39 | 38.02 | 28.57 | 164 | 94.95 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 2475.41 | 40.29 | 29.31 | 165 | 94.84 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 1809.76 | 55.12 | 29.67 | 164 | 96.42 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 462.26 | 216.17 | 43.8 | 353 | 98.72 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 2710.04 | 73.67 | 44.43 | 242 | 94.86 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 2627.16 | 76.01 | 43.18 | 243 | 94.83 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 1800.13 | 110.96 | 48.37 | 277 | 96.27 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 439.05 | 455.66 | 70.4 | 667 | 98.77 |  |
|  Passthrough | 2G | 300 | 50 | 0 | 0 | 2650.19 | 113.06 | 58.95 | 327 | 94.57 |  |
|  Passthrough | 2G | 300 | 1024 | 0 | 0 | 2578.75 | 116.21 | 58.12 | 329 | 94.85 |  |
|  Passthrough | 2G | 300 | 10240 | 0 | 0 | 1815.46 | 165.1 | 63.15 | 367 | 96.28 |  |
|  Passthrough | 2G | 300 | 102400 | 0 | 0 | 427.99 | 700.79 | 88.75 | 939 | 98.76 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 2612.58 | 191.31 | 82.67 | 447 | 94.65 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 2570.37 | 194.44 | 80.3 | 441 | 95 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 1764.78 | 283.32 | 93.42 | 551 | 96.21 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 419.26 | 1191.11 | 124.07 | 1511 | 98.7 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 2584.92 | 386.85 | 136.56 | 751 | 94.4 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 2439.56 | 409.9 | 137.04 | 791 | 94.8 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 1723.83 | 579.9 | 162.03 | 1019 | 96.02 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 418.55 | 2383.5 | 179.79 | 2815 | 98.53 |  |
|  Transformation | 2G | 50 | 50 | 0 | 0 | 2106.63 | 23.64 | 21.87 | 122 | 94.66 |  |
|  Transformation | 2G | 50 | 1024 | 0 | 0 | 1732.77 | 28.76 | 23.14 | 127 | 95.35 |  |
|  Transformation | 2G | 50 | 10240 | 0 | 0 | 706.57 | 70.6 | 38.15 | 194 | 95.91 |  |
|  Transformation | 2G | 50 | 102400 | 0 | 0 | 91.42 | 546.84 | 127.59 | 867 | 96.72 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2153.86 | 46.31 | 32.9 | 178 | 94.67 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 1800.82 | 55.41 | 36.6 | 196 | 95.09 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 690.18 | 144.74 | 69.25 | 349 | 95.81 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 0 | 94.41 | 1058.17 | 181.41 | 1519 | 96.38 |  |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2137.41 | 93.44 | 52.5 | 277 | 94.65 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 1803.86 | 110.73 | 58.08 | 305 | 94.85 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 696.88 | 287.05 | 118.71 | 619 | 95.82 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 0 | 89.42 | 2232.01 | 271.5 | 2863 | 95.15 |  |
|  Transformation | 2G | 300 | 50 | 0 | 0 | 2122.77 | 141.19 | 68.83 | 359 | 94.89 |  |
|  Transformation | 2G | 300 | 1024 | 0 | 0 | 1793.46 | 167.17 | 76.91 | 407 | 94.78 |  |
|  Transformation | 2G | 300 | 10240 | 0 | 0 | 666.75 | 449.99 | 163.38 | 883 | 95.94 |  |
|  Transformation | 2G | 300 | 102400 | 0 | 0 | 82.25 | 3634.99 | 352.85 | 4447 | 93.62 |  |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2133.61 | 234.32 | 96.36 | 515 | 94.28 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 1758.34 | 284.38 | 110.33 | 603 | 94.74 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 665.27 | 751.52 | 236.77 | 1375 | 95.79 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 100 | 17342.89 | 16.42 | 108.63 | 105 | 95.73 |  |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2077.64 | 481.08 | 158.17 | 907 | 93.62 | 517 |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 1709.66 | 584.77 | 182.52 | 1079 | 94.18 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 573.33 | 1740.49 | 389.3 | 2735 | 93.34 | 413 |
|  Transformation | 2G | 1000 | 102400 | 0 | 100 | 21846.8 | 31.77 | 32.98 | 159 | 93.75 | 496 |
