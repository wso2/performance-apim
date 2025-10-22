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
| Message Size (Bytes) | The request payload size in Bytes. | 50, 102400 |
| Back-end Delay (ms) | The delay added by the back-end service. | 0 |

The duration of each test is **900 seconds**. The warm-up period is **300 seconds**.
The measurement results are collected after the warm-up period.

A [**c5.xlarge** Amazon EC2 instance](https://aws.amazon.com/ec2/instance-types/) was used to install WSO2 API Manager.

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
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 4285.4 | 23.26 | 43.17 | 110 | N/A | N/A |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 1007.56 | 99.03 | 24.39 | 166 | N/A | N/A |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 37.95 | 5124.51 | 6268.13 | 30079 | N/A | N/A |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 1063.01 | 187.91 | 37.66 | 287 | N/A | N/A |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 2728.19 | 183.14 | 415.73 | 1679 | N/A | N/A |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 1002.6 | 498.77 | 57.38 | 655 | N/A | N/A |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 3735.67 | 267.43 | 316.18 | 1375 | N/A | N/A |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 927.84 | 1076.89 | 100.95 | 1343 | N/A | N/A |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 3334.98 | 29.91 | 63.07 | 167 | N/A | N/A |
|  Transformation | 2G | 100 | 102400 | 0 | 0 | 91.84 | 1088.25 | 277.18 | 1687 | N/A | N/A |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 3147.22 | 63.48 | 104.96 | 611 | N/A | N/A |
|  Transformation | 2G | 200 | 102400 | 0 | 0 | 84.32 | 2366.67 | 431.72 | 3327 | N/A | N/A |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 3169.43 | 157.57 | 343.54 | 1367 | N/A | N/A |
|  Transformation | 2G | 500 | 102400 | 0 | 0 | 74.67 | 6656.29 | 712.49 | 8319 | N/A | N/A |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2958.02 | 337.79 | 374.84 | 1623 | N/A | N/A |
|  Transformation | 2G | 1000 | 102400 | 0 | 0 | 66.28 | 14833.68 | 1596.46 | 18687 | N/A | N/A |
