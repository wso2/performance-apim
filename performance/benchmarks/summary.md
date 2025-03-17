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
| Concurrent Users | The number of users accessing the application at the same time. | 100, 200, 500, 1000 |
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
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 3454.29 | 28.85 | 15.42 | 86 | 98.64 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 3376.12 | 29.52 | 15.8 | 87 | 98.66 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 2561.03 | 38.88 | 19.33 | 104 | 98.89 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 748.36 | 133.42 | 29.99 | 212 | 99.37 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 3573.51 | 55.86 | 26.35 | 144 | 98.51 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 3490.65 | 57.18 | 26.58 | 144 | 98.55 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 2611.12 | 76.42 | 33.01 | 179 | 98.83 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 721.49 | 277.23 | 50.59 | 405 | 99.38 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 3454.48 | 144.59 | 59.44 | 327 | 98.3 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 3396.34 | 147.08 | 58.45 | 319 | 98.32 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 2558.67 | 195.26 | 63.22 | 377 | 98.67 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 675.3 | 739.96 | 84.32 | 947 | 99.34 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 3549.7 | 281.65 | 97.66 | 555 | 97.77 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 3533.34 | 282.98 | 95.12 | 555 | 97.77 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 2585.87 | 386.75 | 94.55 | 655 | 98.32 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 640.76 | 1557.92 | 163.74 | 2079 | 99.14 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2778.27 | 35.89 | 20.27 | 110 | 98.1 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 2224.97 | 44.83 | 25.04 | 134 | 98.03 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 740.57 | 134.85 | 66.63 | 337 | 98.12 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 0 | 98.86 | 1010.89 | 212.03 | 1535 | 95.87 |  |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2799.29 | 71.33 | 35.43 | 189 | 97.94 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 2237.43 | 89.25 | 42.75 | 229 | 97.87 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 740.92 | 269.91 | 114.19 | 595 | 97.94 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 0 | 74.86 | 2664.28 | 522.16 | 4447 | 88.62 | 343 |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2785.02 | 179.43 | 72.39 | 397 | 97.42 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 2232.98 | 223.86 | 86.96 | 477 | 97.31 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 737.21 | 678.01 | 208.2 | 1255 | 97.33 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 0 | 71.64 | 6922.19 | 1095.87 | 9663 | 86.33 | 471.727 |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2662.72 | 375.62 | 127.17 | 731 | 96.28 |  |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 2086.19 | 479.16 | 158.97 | 919 | 96.22 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 725.58 | 1376.68 | 332.64 | 2287 | 96.66 |  |
|  Transformation | 2G | 1000 | 102400 | 0 | 0 | 59.49 | 16504.57 | 1949.91 | 21375 | 79.55 | 564.19 |
