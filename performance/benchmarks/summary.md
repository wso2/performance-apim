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
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 3164.41 | 31.5 | 17.36 | 96 | 98.62 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 3069.81 | 32.47 | 16.92 | 94 | 98.64 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 2471.99 | 40.27 | 20.14 | 108 | 98.84 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 710.6 | 140.5 | 34.24 | 229 | 99.33 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 3346.41 | 59.63 | 28.78 | 155 | 98.49 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 3192.85 | 62.51 | 29.46 | 160 | 98.56 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 2440.94 | 81.74 | 34.4 | 189 | 98.79 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 667.65 | 299.61 | 56.06 | 453 | 99.3 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 3175.56 | 157.32 | 63.51 | 349 | 98.24 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 3274.01 | 152.57 | 60.28 | 333 | 98.24 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 2473.46 | 202 | 64.75 | 387 | 98.57 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 622.59 | 802.61 | 106.21 | 1135 | 99.2 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 2992.86 | 334.08 | 114.23 | 659 | 97.68 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 2878.36 | 347.41 | 117.99 | 683 | 97.72 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 2256.39 | 443.06 | 114.91 | 759 | 98.19 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 613.48 | 1627.49 | 173.99 | 2191 | 99.05 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2556.09 | 39.01 | 22.14 | 119 | 98.14 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 2060.75 | 48.4 | 27.14 | 145 | 98.08 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 689.87 | 144.7 | 71.56 | 367 | 98.14 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 0 | 91.45 | 1092.35 | 254.36 | 1759 | 94.93 | 308 |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2473.58 | 80.73 | 39.81 | 212 | 97.99 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 2010.62 | 99.33 | 48.3 | 257 | 97.91 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 708.03 | 282.4 | 116.61 | 619 | 97.93 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 0 | 73.79 | 2703.85 | 572.04 | 4543 | 88.58 | 349.1 |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2500.33 | 199.87 | 79.82 | 441 | 97.46 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 1975.61 | 253.02 | 98.33 | 543 | 97.43 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 711.36 | 702.71 | 220.63 | 1311 | 97.33 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 0 | 68.39 | 7257.28 | 1268.12 | 11391 | 86.13 | 459.062 |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2481.39 | 402.9 | 135.39 | 783 | 96.55 |  |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 2010.62 | 497.18 | 160.29 | 939 | 96.52 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 710.2 | 1405.38 | 344.44 | 2351 | 96.72 |  |
|  Transformation | 2G | 1000 | 102400 | 0 | 0 | 61.35 | 15995.77 | 1774.38 | 20607 | 81.29 | 558.692 |
