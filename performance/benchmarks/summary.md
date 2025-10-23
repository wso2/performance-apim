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
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 3741.01 | 26.65 | 27.49 | 134 | 98.62 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 3595.43 | 27.73 | 27.74 | 131 | 98.66 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 2717.72 | 36.69 | 22.59 | 87 | 98.94 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 835.54 | 119.49 | 16.4 | 164 | 99.38 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 3636.64 | 54.9 | 48.72 | 265 | 98.56 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 3571.8 | 55.9 | 42.86 | 216 | 98.61 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 2744.14 | 72.76 | 41.37 | 190 | 98.84 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 775.72 | 257.82 | 24.53 | 325 | 99.4 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 3592.62 | 139.06 | 188.37 | 911 | 98.15 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 3554.2 | 140.59 | 187.05 | 903 | 98.22 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 2726.13 | 183.27 | 70.52 | 455 | 98.64 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 731.39 | 683.41 | 43.13 | 803 | 99.35 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 3404.92 | 293.44 | 323.09 | 1375 | 97.46 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 3458.57 | 288.97 | 265.41 | 1319 | 97.74 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 2714.61 | 368.46 | 110.54 | 767 | 98.32 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 721.65 | 1383.91 | 108.68 | 1807 | 99.15 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2847.59 | 35.03 | 35.15 | 151 | 98.18 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 2246.52 | 44.43 | 52.01 | 197 | 98.11 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 766.12 | 130.41 | 136.77 | 907 | 98.23 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 0 | 95.09 | 1050.58 | 129.84 | 1367 | 95.88 |  |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2823.55 | 70.72 | 60.85 | 311 | 97.92 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 2254.58 | 88.61 | 73.6 | 399 | 98.01 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 762.56 | 262.02 | 221.21 | 1423 | 98.05 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 0 | 75.95 | 2626.14 | 488.72 | 4319 | 88.51 | 363 |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2835.85 | 176.24 | 106.3 | 635 | 97.37 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 2308.2 | 216.55 | 126.14 | 743 | 97.34 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 761.3 | 656.28 | 387.97 | 2207 | 97.28 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 0 | 71.71 | 6933.69 | 879.52 | 8959 | 86.74 | 472.176 |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2707.03 | 369.34 | 173.46 | 987 | 95.96 |  |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 2208.08 | 452.93 | 202.33 | 1111 | 96.04 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 667.55 | 1494.99 | 665.56 | 3567 | 94.25 |  |
|  Transformation | 2G | 1000 | 102400 | 0 | 0 | 59.18 | 16551.34 | 1795.26 | 21247 | 77.19 | 586.753 |
