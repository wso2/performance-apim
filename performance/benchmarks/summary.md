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
|  Passthrough | 2G | 50 | 50 | 0 | 0 | 2694.99 | 18.46 | 20.09 | 99 | 94.33 |  |
|  Passthrough | 2G | 50 | 1024 | 0 | 0 | 2595.32 | 19.17 | 18.87 | 95 | 94.77 |  |
|  Passthrough | 2G | 50 | 10240 | 0 | 0 | 1940.27 | 25.65 | 18.7 | 98 | 95.93 |  |
|  Passthrough | 2G | 50 | 102400 | 0 | 0 | 532.08 | 93.77 | 23.77 | 177 | 98.45 |  |
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 2766.15 | 36.03 | 29.1 | 169 | 94.1 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 2724.68 | 36.59 | 29.33 | 164 | 94.3 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 1900.06 | 52.49 | 30.53 | 178 | 96.01 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 514.39 | 194.2 | 38.77 | 323 | 98.46 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 2739.54 | 72.89 | 43.35 | 235 | 94.57 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 2702.77 | 73.89 | 43.02 | 250 | 94.53 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 1926.9 | 103.64 | 48.87 | 283 | 95.79 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 496.36 | 403.09 | 62.07 | 591 | 98.51 |  |
|  Passthrough | 2G | 300 | 50 | 0 | 0 | 2764.71 | 108.4 | 57.47 | 311 | 94.22 |  |
|  Passthrough | 2G | 300 | 1024 | 0 | 0 | 2708.83 | 110.63 | 56.29 | 307 | 94.47 |  |
|  Passthrough | 2G | 300 | 10240 | 0 | 0 | 1906.75 | 157.19 | 63.17 | 369 | 95.85 |  |
|  Passthrough | 2G | 300 | 102400 | 0 | 0 | 498.46 | 601.8 | 76.36 | 831 | 98.46 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 2779.97 | 179.77 | 78.5 | 423 | 94.33 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 2666.69 | 187.42 | 79.72 | 431 | 94.43 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 1917.55 | 260.72 | 88.09 | 535 | 95.58 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 483.04 | 1034.34 | 112.38 | 1367 | 98.42 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 2586.07 | 386.68 | 136.56 | 763 | 93.78 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 2554.42 | 391.46 | 132.68 | 759 | 94.01 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 1841.84 | 542.69 | 144.64 | 931 | 95.52 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 477.29 | 2090.8 | 185.41 | 2655 | 98.16 |  |
|  Transformation | 2G | 50 | 50 | 0 | 0 | 2153.93 | 23.12 | 22.45 | 127 | 94.13 |  |
|  Transformation | 2G | 50 | 1024 | 0 | 0 | 1778.16 | 28.02 | 23.73 | 133 | 94.76 |  |
|  Transformation | 2G | 50 | 10240 | 0 | 0 | 688.46 | 72.46 | 40.99 | 209 | 95.64 |  |
|  Transformation | 2G | 50 | 102400 | 0 | 0 | 98.78 | 506.05 | 130.7 | 835 | 96.09 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2175.97 | 45.85 | 34.14 | 179 | 94.26 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 1802.48 | 55.36 | 37.91 | 198 | 94.52 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 706.42 | 141.4 | 69.79 | 353 | 95.42 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 0 | 97.59 | 1023.88 | 191.22 | 1511 | 95.8 |  |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2184.48 | 91.44 | 52.75 | 277 | 94.15 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 1806.53 | 110.59 | 59.31 | 311 | 94.56 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 674.33 | 296.64 | 121.15 | 639 | 95.56 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 99.44 | 9018.87 | 20.23 | 184.03 | 47 | 93.32 |  |
|  Transformation | 2G | 300 | 50 | 0 | 0 | 2212.98 | 135.46 | 67.09 | 351 | 93.9 |  |
|  Transformation | 2G | 300 | 1024 | 0 | 0 | 1773.37 | 169.08 | 78.7 | 415 | 94.43 |  |
|  Transformation | 2G | 300 | 10240 | 0 | 0 | 685.67 | 437.63 | 156.54 | 863 | 95.48 |  |
|  Transformation | 2G | 300 | 102400 | 0 | 0 | 73.83 | 4049.03 | 1754.49 | 5247 | 92.64 |  |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2157.61 | 231.69 | 96.71 | 519 | 93.78 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 1760.85 | 283.99 | 108.8 | 591 | 94.41 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 678.4 | 736.86 | 218.89 | 1327 | 95.35 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 99.97 | 18886.71 | 20.04 | 300.24 | 99 | 88.74 | 473.5 |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2013.56 | 496.65 | 161.75 | 931 | 92.77 | 648 |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 1697.46 | 588.91 | 174.11 | 1071 | 93.71 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 610.04 | 1637.34 | 358.92 | 2687 | 92.78 | 509.5 |
|  Transformation | 2G | 1000 | 102400 | 0 | 100 | 23631.79 | 28.73 | 36.37 | 179 | 96.06 |  |
