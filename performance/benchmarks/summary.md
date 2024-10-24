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
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 3507.23 | 28.41 | 15.09 | 84 | 98.57 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 3430.34 | 29.05 | 15.07 | 84 | 98.58 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 2629.11 | 37.86 | 19.16 | 103 | 98.79 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 751.11 | 132.89 | 31.58 | 216 | 99.34 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 3411.88 | 58.49 | 28.45 | 155 | 98.49 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 3355.4 | 59.48 | 27.93 | 151 | 98.54 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 2594.02 | 76.91 | 32.73 | 180 | 98.77 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 699.83 | 285.82 | 50.79 | 415 | 99.36 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 3562.08 | 140.2 | 56.34 | 311 | 98.2 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 3289.86 | 151.82 | 60.4 | 333 | 98.31 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 2604.4 | 191.78 | 61.04 | 369 | 98.59 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 676.4 | 738.87 | 87.84 | 959 | 99.3 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 3371.58 | 296.5 | 102.9 | 587 | 97.7 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 3241.36 | 308.45 | 107.99 | 627 | 97.86 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 2532.34 | 394.88 | 105.24 | 707 | 98.27 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 649.56 | 1537.07 | 165.18 | 2079 | 99.12 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2623.41 | 38.01 | 22.65 | 121 | 98.02 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 2214.96 | 45.03 | 24.91 | 135 | 97.94 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 760.22 | 131.31 | 64.3 | 327 | 98.01 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 0 | 97.35 | 1026.61 | 218.31 | 1567 | 95.84 |  |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2774.31 | 71.96 | 35.56 | 191 | 97.81 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 2214.47 | 90.17 | 43.68 | 231 | 97.75 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 742.59 | 269.29 | 111.38 | 587 | 97.8 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 0 | 76.4 | 2610.11 | 560.66 | 4383 | 88.45 | 348.05 |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2661.93 | 187.7 | 75.18 | 409 | 97.29 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 2141.5 | 233.44 | 90.33 | 497 | 97.19 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 740.65 | 674.82 | 205.6 | 1239 | 97.1 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 0 | 72.84 | 6817.42 | 1172.12 | 9855 | 85.29 | 460.061 |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2604.1 | 383.97 | 142.16 | 783 | 95.59 | 415 |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 2108.16 | 474.19 | 157.39 | 907 | 95.94 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 680.04 | 1469.16 | 357.12 | 2479 | 94.37 |  |
|  Transformation | 2G | 1000 | 102400 | 0 | 0 | 57.19 | 17150.06 | 4099.57 | 37119 | 77.81 | 561.081 |
