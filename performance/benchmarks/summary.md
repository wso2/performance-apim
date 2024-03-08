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
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 3438.24 | 28.98 | 15.28 | 85 | 98.62 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 3290.84 | 30.28 | 15.83 | 88 | 98.68 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 2559.53 | 38.89 | 19.2 | 103 | 98.87 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 701.11 | 142.4 | 32.94 | 229 | 99.41 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 3405.73 | 58.6 | 27.48 | 149 | 98.55 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 3354 | 59.51 | 27.15 | 148 | 98.57 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 2511.02 | 79.46 | 33.16 | 182 | 98.83 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 673.29 | 297.11 | 55.58 | 443 | 99.39 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 3393.38 | 147.2 | 58.56 | 321 | 98.28 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 3288.17 | 151.91 | 59.81 | 329 | 98.37 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 2508.89 | 199.1 | 62.71 | 379 | 98.68 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 645.76 | 773.91 | 101.66 | 1087 | 99.27 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 3182.41 | 314.16 | 107.8 | 619 | 97.72 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 3236.02 | 309.02 | 104.8 | 611 | 97.74 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 2439.52 | 409.88 | 103.21 | 699 | 98.23 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 649.24 | 1537.87 | 171.43 | 2095 | 99.11 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2719.54 | 36.66 | 20.58 | 112 | 98.07 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 2161.31 | 46.15 | 24.51 | 132 | 98.09 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 735.71 | 135.69 | 66.03 | 335 | 98.13 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 0 | 97 | 1030.05 | 212.62 | 1559 | 95.98 |  |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2592.73 | 77 | 37.63 | 202 | 98.02 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 2226.13 | 89.7 | 41.71 | 222 | 97.87 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 774.35 | 258.18 | 106.21 | 559 | 97.84 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 0 | 77 | 2592.51 | 516.25 | 4351 | 88.71 | 344.474 |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2676.93 | 186.67 | 73.5 | 403 | 97.51 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 2181.02 | 229.15 | 88.03 | 487 | 97.4 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 759.75 | 657.88 | 209.13 | 1231 | 97.33 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 0 | 71.6 | 6932.12 | 1098.87 | 9599 | 86.57 | 459.156 |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2538.94 | 393.84 | 195.18 | 755 | 96.58 |  |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 2155.84 | 463.8 | 148.15 | 875 | 96.16 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 721.06 | 1384.9 | 308.19 | 2255 | 96.66 |  |
|  Transformation | 2G | 1000 | 102400 | 0 | 0.01 | 47.01 | 17369.68 | 5078.91 | 42751 | 81.26 | 563.951 |
