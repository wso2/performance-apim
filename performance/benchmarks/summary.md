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
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 3662.27 | 27.22 | 26.77 | 125 | 98.65 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 3501.21 | 28.48 | 25.62 | 116 | 98.74 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 2720.74 | 36.65 | 22.69 | 88 | 98.91 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 816.4 | 122.28 | 16.89 | 169 | 99.4 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 3634.8 | 54.93 | 44.72 | 229 | 98.52 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 3476.67 | 57.43 | 41.53 | 209 | 98.59 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 2750.74 | 72.59 | 38.58 | 177 | 98.85 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 770.7 | 259.51 | 24.45 | 329 | 99.4 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 3558.79 | 140.4 | 197.91 | 927 | 98.2 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 3536.45 | 141.29 | 88.3 | 523 | 98.3 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 2723.17 | 183.45 | 74.65 | 509 | 98.62 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 709.27 | 704.71 | 59.68 | 939 | 99.34 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 3518.9 | 283.96 | 295.06 | 1343 | 97.5 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 3513.75 | 284.59 | 149.74 | 915 | 97.79 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 2669.65 | 374.67 | 113.39 | 783 | 98.24 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 700.37 | 1425.93 | 111.9 | 1863 | 99.15 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2881.94 | 34.62 | 35.57 | 143 | 98.11 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 2284.62 | 43.68 | 48.88 | 208 | 98.11 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 764.7 | 130.63 | 134.74 | 735 | 98.3 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 0 | 95.22 | 1049.47 | 131.15 | 1359 | 95.85 |  |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2810.03 | 71.08 | 60.25 | 287 | 97.98 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 2276.57 | 87.76 | 72.15 | 377 | 97.91 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 797.36 | 250.76 | 208.37 | 1375 | 97.91 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 0 | 75.5 | 2642.4 | 463.79 | 4255 | 88.72 | 358.96 |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2864.8 | 174.45 | 120.26 | 675 | 97.35 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 2325.06 | 215.01 | 126.91 | 735 | 97.27 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 762.8 | 655.12 | 411.27 | 2239 | 97.32 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 0 | 71.33 | 6967.18 | 862.96 | 9023 | 87.1 | 475.121 |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2692.16 | 371.4 | 197.71 | 1143 | 95.45 |  |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 2226.14 | 448.97 | 210.41 | 1167 | 95.93 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 677.79 | 1473.44 | 674.82 | 3583 | 94.94 |  |
|  Transformation | 2G | 1000 | 102400 | 0 | 0 | 57.77 | 16998.69 | 1934.96 | 21631 | 77.57 | 587.606 |
