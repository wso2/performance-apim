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
|  Passthrough | 2G | 50 | 50 | 0 | 0 | 2939.35 | 16.92 | 18.2 | 93 | 94.47 |  |
|  Passthrough | 2G | 50 | 1024 | 0 | 0 | 2797.64 | 17.78 | 20.09 | 91 | 94.36 |  |
|  Passthrough | 2G | 50 | 10240 | 0 | 0 | 2006.39 | 24.8 | 18.24 | 86 | 95.88 |  |
|  Passthrough | 2G | 50 | 102400 | 0 | 0 | 527.79 | 94.55 | 25.2 | 181 | 98.47 |  |
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 3056.65 | 32.61 | 25.82 | 150 | 94.46 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 2993.59 | 33.3 | 26.79 | 152 | 94.26 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 1996.35 | 49.95 | 27.75 | 163 | 96.05 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 513.82 | 194.43 | 41.1 | 323 | 98.56 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 3124.73 | 63.88 | 38.64 | 212 | 94.18 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 2925.77 | 68.24 | 39.77 | 220 | 94.35 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 1973.34 | 101.2 | 45.82 | 265 | 95.82 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 472.83 | 423.07 | 70.35 | 635 | 98.61 |  |
|  Passthrough | 2G | 300 | 50 | 0 | 0 | 3176.88 | 94.29 | 50.33 | 275 | 93.95 |  |
|  Passthrough | 2G | 300 | 1024 | 0 | 0 | 2972.32 | 100.8 | 53.54 | 301 | 93.94 |  |
|  Passthrough | 2G | 300 | 10240 | 0 | 0 | 2012.52 | 148.9 | 61.53 | 359 | 95.7 |  |
|  Passthrough | 2G | 300 | 102400 | 0 | 0 | 478.93 | 626.27 | 87.27 | 871 | 98.54 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 3048.66 | 163.88 | 74.97 | 407 | 93.97 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 2928.28 | 170.61 | 73.83 | 411 | 94.28 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 1997.53 | 250.27 | 90.99 | 531 | 95.58 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 458.07 | 1090.58 | 122.02 | 1407 | 98.54 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 2969.33 | 336.82 | 122.46 | 675 | 93.42 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 2782.02 | 359.4 | 124.07 | 703 | 93.83 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 1945.34 | 513.83 | 157.48 | 959 | 95.46 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 454.75 | 2194.47 | 179.81 | 2655 | 98.31 |  |
|  Transformation | 2G | 50 | 50 | 0 | 0 | 2417.42 | 20.59 | 20.99 | 118 | 93.99 |  |
|  Transformation | 2G | 50 | 1024 | 0 | 0 | 1992.64 | 24.99 | 22.4 | 127 | 94.39 |  |
|  Transformation | 2G | 50 | 10240 | 0 | 0 | 764.27 | 65.26 | 36.73 | 187 | 95.43 |  |
|  Transformation | 2G | 50 | 102400 | 0 | 0 | 101.5 | 492.49 | 131.52 | 823 | 96.21 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2470.02 | 40.37 | 31.21 | 166 | 93.76 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 1999.18 | 49.9 | 34.71 | 186 | 94.4 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 758.42 | 131.66 | 64 | 321 | 95.53 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 99.84 | 16389.29 | 5.17 | 41.29 | 11 | 96.06 |  |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2471.31 | 80.79 | 48.27 | 255 | 94.04 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 1987.36 | 100.48 | 54.69 | 287 | 94.24 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 752.4 | 265.82 | 112.05 | 575 | 95.19 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 95.69 | 1989.62 | 97.82 | 427.91 | 2303 | 94.51 |  |
|  Transformation | 2G | 300 | 50 | 0 | 0 | 2484.99 | 120.57 | 61.97 | 325 | 93.56 |  |
|  Transformation | 2G | 300 | 1024 | 0 | 0 | 2033.58 | 147.39 | 70.59 | 369 | 94.2 |  |
|  Transformation | 2G | 300 | 10240 | 0 | 0 | 736.92 | 407.16 | 155.13 | 819 | 95.49 |  |
|  Transformation | 2G | 300 | 102400 | 0 | 0 | 69.79 | 4281.63 | 2828.91 | 6559 | 97.05 |  |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2480.89 | 201.44 | 88.1 | 459 | 93.2 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 2012.59 | 248.41 | 99.07 | 535 | 93.86 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 691.29 | 723.19 | 219.06 | 1279 | 95.35 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 0 | 81.96 | 6064.63 | 467.54 | 7135 | 91.79 |  |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2365.51 | 422.7 | 142.95 | 803 | 92.23 |  |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 1891.53 | 528.52 | 165.58 | 971 | 93.38 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 609.3 | 1638.37 | 390.15 | 2687 | 91.43 | 455.333 |
|  Transformation | 2G | 1000 | 102400 | 0 | 100 | 5.01 | 180671.49 | 265.12 | 181247 | 99.13 |  |
