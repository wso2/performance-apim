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
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 3612.7 | 27.59 | 29.24 | 131 | 98.56 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 3620.32 | 27.53 | 27.44 | 131 | 98.51 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 2757.4 | 36.16 | 24.29 | 93 | 98.78 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 821.72 | 121.48 | 17.53 | 172 | 99.33 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 3604.73 | 55.39 | 52.88 | 271 | 98.45 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 3495.9 | 57.11 | 49.04 | 250 | 98.46 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 2705.48 | 73.8 | 42.37 | 191 | 98.73 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 782.31 | 255.61 | 27.32 | 341 | 99.3 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 3599.11 | 138.81 | 229.2 | 1003 | 98.02 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 3547.75 | 140.83 | 158.26 | 823 | 98.08 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 2724.57 | 183.36 | 74.55 | 509 | 98.5 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 729.82 | 684.83 | 57.7 | 907 | 99.2 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 3401.52 | 293.73 | 318.59 | 1399 | 97.36 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 3346.55 | 298.65 | 222.83 | 1247 | 97.47 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 2619.81 | 381.71 | 115.2 | 803 | 98.05 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 709.56 | 1407.18 | 107.71 | 1831 | 99.02 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2790.54 | 35.75 | 41.48 | 177 | 98.05 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 2250.68 | 44.34 | 48.42 | 181 | 98.07 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 748.15 | 133.55 | 139.6 | 875 | 98.2 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 0 | 87.81 | 1138.04 | 159.63 | 1543 | 94.85 | 335 |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2797.29 | 71.4 | 60.17 | 285 | 97.87 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 2211.57 | 90.34 | 77.03 | 371 | 97.89 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 743.82 | 268.65 | 225.74 | 1463 | 97.97 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 0 | 73.83 | 2702.7 | 482.49 | 4383 | 88.48 | 368.615 |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2832.44 | 176.45 | 112.1 | 663 | 97.27 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 2269.32 | 220.29 | 124.83 | 699 | 97.24 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 748.63 | 667.3 | 381.91 | 2255 | 97.25 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 0 | 71.27 | 6974.94 | 847.51 | 9087 | 86.85 | 476.529 |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2703.78 | 369.75 | 207.61 | 1231 | 96.26 |  |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 2176.96 | 459.33 | 217.11 | 1231 | 96.36 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 642.34 | 1552.84 | 719.03 | 3759 | 94.49 |  |
|  Transformation | 2G | 1000 | 102400 | 0 | 0 | 57.38 | 17081.64 | 1916.4 | 21887 | 76.58 | 581.84 |
