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
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 3679.42 | 27.07 | 14.69 | 82 | 98.59 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 3607.55 | 27.61 | 14.97 | 83 | 98.59 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 2747.92 | 36.21 | 18.61 | 101 | 98.85 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 814.04 | 122.6 | 30.64 | 202 | 99.36 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 3707.14 | 53.82 | 26.49 | 143 | 98.45 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 3711.23 | 53.76 | 25.02 | 136 | 98.47 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 2806.84 | 71.05 | 31.45 | 172 | 98.77 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 752.15 | 265.89 | 47.49 | 387 | 99.37 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 3744.06 | 133.37 | 54.33 | 299 | 98.23 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 3703.88 | 134.84 | 54.36 | 299 | 98.24 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 2713.19 | 184.09 | 60.86 | 361 | 98.62 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 682.5 | 732.22 | 86.8 | 947 | 99.32 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 3771.27 | 265.14 | 93.23 | 527 | 97.65 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 3580.53 | 279.26 | 96.67 | 555 | 97.77 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 2684.96 | 372.5 | 99.33 | 651 | 98.04 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 706.93 | 1412.5 | 133.96 | 1735 | 99.19 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2917.58 | 34.15 | 19.19 | 104 | 97.98 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 2323.7 | 42.9 | 24.53 | 132 | 97.96 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 797.35 | 125.15 | 61.05 | 309 | 98.04 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 0 | 101.72 | 982.4 | 232.11 | 1567 | 95.42 | 315 |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2948.35 | 67.69 | 33.84 | 182 | 97.82 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 2396.9 | 83.3 | 39.96 | 212 | 97.72 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 816.73 | 244.72 | 104.41 | 547 | 97.7 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 0 | 81.51 | 2449.01 | 527.26 | 4223 | 87.88 | 351.913 |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2814.53 | 177.52 | 71.47 | 393 | 97.29 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 2292.47 | 218.02 | 85.71 | 467 | 97.25 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 777.88 | 642.6 | 211.5 | 1215 | 96.94 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 0 | 73.74 | 6739.16 | 1138.01 | 9471 | 86.35 | 463.824 |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2649.02 | 377.46 | 137.26 | 751 | 95.92 | 416 |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 2129.26 | 469.48 | 154.58 | 895 | 95.7 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 631.94 | 1580 | 364.91 | 2623 | 92.56 |  |
|  Transformation | 2G | 1000 | 102400 | 0 | 0.01 | 60.48 | 16219.03 | 5783.64 | 48127 | 81.03 | 554.164 |
