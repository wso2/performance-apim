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
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 3583.85 | 27.81 | 27.82 | 132 | 98.49 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 3505.27 | 28.44 | 26.43 | 116 | 98.5 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 2645.22 | 37.69 | 25.97 | 96 | 98.76 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 811.12 | 123.07 | 18.57 | 178 | 99.26 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 3500.53 | 57.04 | 50.2 | 267 | 98.42 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 3376.4 | 59.14 | 48.33 | 247 | 98.47 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 2668.29 | 74.83 | 43.18 | 193 | 98.69 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 742.27 | 269.5 | 29.93 | 367 | 99.28 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 3444.7 | 145.05 | 122.01 | 639 | 98.11 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 3428.67 | 145.74 | 129.3 | 719 | 98.1 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 2656.31 | 188.07 | 75.7 | 507 | 98.54 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 722.59 | 691.75 | 57.75 | 903 | 99.18 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 3248.66 | 307.63 | 324.18 | 1439 | 97.34 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 3237.52 | 308.82 | 208.19 | 1231 | 97.4 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 2507.58 | 398.81 | 126.57 | 843 | 97.99 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 700.13 | 1426.36 | 115.94 | 1855 | 98.99 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2743.87 | 36.36 | 38.32 | 165 | 98.01 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 2181.9 | 45.74 | 52.94 | 200 | 98.05 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 746.01 | 133.91 | 140.02 | 903 | 98.15 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 0 | 90.43 | 1105.02 | 158.31 | 1511 | 94.86 | 317 |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2700.21 | 73.97 | 65.39 | 335 | 97.9 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 2213.55 | 90.22 | 76.49 | 359 | 97.83 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 748.38 | 267.2 | 227.8 | 1455 | 97.9 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 0 | 72.54 | 2750.13 | 505.85 | 4511 | 88.04 | 376.071 |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2729.13 | 183.12 | 114.8 | 643 | 97.27 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 2189.38 | 228.36 | 126.49 | 703 | 97.27 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 758.34 | 658.47 | 402.38 | 2255 | 97.2 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 0 | 72.3 | 6876.32 | 884.69 | 8959 | 86.7 | 480.676 |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2655.07 | 376.62 | 195.85 | 1119 | 96.16 |  |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 2116.71 | 472.39 | 221.79 | 1239 | 96.02 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 625.71 | 1594.12 | 707.42 | 3807 | 94.05 |  |
|  Transformation | 2G | 1000 | 102400 | 0 | 0 | 59.4 | 16500.9 | 1576.41 | 20479 | 78.92 | 578.062 |
