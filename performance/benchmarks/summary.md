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
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 3501.92 | 28.45 | 14.94 | 83 | 98.55 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 3449.68 | 28.88 | 15.18 | 85 | 98.57 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 2613.68 | 38.07 | 19.14 | 104 | 98.82 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 756.77 | 131.87 | 32.02 | 216 | 99.37 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 3611.47 | 55.25 | 26.13 | 143 | 98.43 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 3520.42 | 56.67 | 26.23 | 144 | 98.47 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 2639.08 | 75.57 | 32.59 | 178 | 98.74 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 712.52 | 280.71 | 51.61 | 411 | 99.35 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 3591.87 | 139.05 | 56.29 | 309 | 98.18 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 3451.9 | 144.69 | 57.85 | 319 | 98.24 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 2600.51 | 192.07 | 62.16 | 371 | 98.57 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 675.78 | 739.43 | 85.7 | 951 | 99.3 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 3572.5 | 279.82 | 96.25 | 551 | 97.69 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 3393.76 | 294.58 | 101.29 | 583 | 97.65 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 2569.12 | 389.21 | 97.85 | 655 | 98.25 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 652.99 | 1529.1 | 165.33 | 2063 | 99.09 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2817 | 35.38 | 19.43 | 106 | 97.97 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 2298.96 | 43.37 | 24.24 | 129 | 97.89 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 793.99 | 125.68 | 60.7 | 307 | 98 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 0 | 95.27 | 1049.01 | 233.2 | 1639 | 95.35 | 311 |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2819.12 | 70.81 | 34.69 | 187 | 97.83 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 2256.99 | 88.47 | 42.06 | 224 | 97.72 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 784.34 | 254.89 | 106.73 | 555 | 97.74 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 0 | 79.1 | 2522.13 | 527.06 | 4287 | 88.09 | 346.619 |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2763.67 | 180.8 | 73.18 | 401 | 97.26 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 2248 | 222.32 | 86.05 | 475 | 97.18 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 777.32 | 643.19 | 209.84 | 1223 | 96.86 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 0 | 72.54 | 6847.9 | 1135.05 | 9599 | 85.83 | 462.882 |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2698.83 | 370.5 | 124.52 | 723 | 95.81 |  |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 2217.16 | 450.95 | 146.8 | 851 | 95.79 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 737.47 | 1354.23 | 323.33 | 2223 | 96.56 |  |
|  Transformation | 2G | 1000 | 102400 | 0 | 0 | 63.63 | 15430.04 | 1757.7 | 19967 | 79.78 | 561.37 |
