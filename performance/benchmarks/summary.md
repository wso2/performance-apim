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
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 3582.79 | 27.82 | 27.08 | 117 | 98.62 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 3464.92 | 28.77 | 26.88 | 121 | 98.66 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 2695.44 | 36.99 | 23.62 | 92 | 98.88 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 802.82 | 124.34 | 16.52 | 171 | 99.39 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 3575.39 | 55.84 | 47.47 | 242 | 98.51 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 3445.32 | 57.95 | 46.78 | 243 | 98.56 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 2730.87 | 73.11 | 42.2 | 195 | 98.82 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 734.86 | 272.25 | 24.64 | 341 | 99.39 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 3506.76 | 142.47 | 206.23 | 963 | 98.15 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 3498.48 | 142.81 | 80.04 | 475 | 98.25 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 2632.5 | 189.78 | 72.73 | 499 | 98.64 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 700.27 | 713.69 | 43.35 | 827 | 99.36 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 3472.14 | 287.93 | 198.81 | 1199 | 97.7 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 3411.33 | 293.16 | 130.82 | 799 | 97.79 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 2663.29 | 375.49 | 108.81 | 763 | 98.28 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 692.49 | 1442.16 | 121.79 | 1911 | 99.13 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2733.12 | 36.5 | 39.17 | 176 | 98.15 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 2176.91 | 45.85 | 49.69 | 187 | 98.15 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 743.49 | 134.14 | 140.47 | 699 | 98.22 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 0 | 93.38 | 1070 | 133.68 | 1391 | 95.92 |  |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2748.22 | 72.68 | 61.02 | 295 | 97.94 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 2156.62 | 92.63 | 75.33 | 385 | 97.93 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 737.6 | 271.12 | 228.09 | 1511 | 98.03 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 0 | 72.24 | 2761.1 | 484.05 | 4415 | 88.98 | 361.458 |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2725.23 | 183.37 | 113.9 | 687 | 97.42 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 2193.5 | 227.9 | 134.62 | 835 | 97.41 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 722.85 | 690.7 | 411.79 | 2431 | 97.36 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 0 | 69.71 | 7128.28 | 921.38 | 9279 | 87.41 | 474.312 |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2587.95 | 386.42 | 194.55 | 1143 | 96.01 |  |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 2063.1 | 484.65 | 224.38 | 1271 | 96.02 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 623.78 | 1601.78 | 728.68 | 3743 | 94.7 |  |
|  Transformation | 2G | 1000 | 102400 | 0 | 0 | 58.56 | 16789.2 | 1944.46 | 22143 | 78.31 | 576.25 |
