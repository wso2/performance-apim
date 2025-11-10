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
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 3550.11 | 28.09 | 27.97 | 115 | 98.69 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 3436.75 | 29.01 | 25.94 | 102 | 98.71 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 2634.6 | 37.85 | 26.2 | 94 | 98.95 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 792.24 | 126.03 | 21.28 | 179 | 99.41 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 3459.56 | 57.72 | 50.33 | 265 | 98.61 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 3406.99 | 58.59 | 44.97 | 217 | 98.64 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 2649.82 | 75.35 | 41.83 | 182 | 98.89 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 730.73 | 273.79 | 33.96 | 361 | 99.42 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 3494.07 | 142.98 | 181.99 | 943 | 98.28 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 3371.72 | 148.2 | 176.85 | 927 | 98.34 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 2636.32 | 189.5 | 78.88 | 531 | 98.67 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 703.55 | 710.4 | 57.08 | 847 | 99.36 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 3430.33 | 291.27 | 305.59 | 1471 | 97.8 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 3437.56 | 290.76 | 254.8 | 1399 | 97.81 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 2637.55 | 379.17 | 119.59 | 831 | 98.34 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 679 | 1470.08 | 132.59 | 1919 | 99.16 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2654.62 | 37.59 | 41.37 | 160 | 98.27 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 2154.18 | 46.33 | 53.29 | 191 | 98.2 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 719.68 | 138.83 | 151.93 | 983 | 98.27 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 0 | 91.54 | 1091.1 | 167.43 | 1519 | 96.02 |  |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2652.1 | 75.32 | 71.57 | 367 | 98.08 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 2199.36 | 90.84 | 81.84 | 413 | 97.93 |  |
