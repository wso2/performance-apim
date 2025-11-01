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
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 3765.39 | 26.47 | 24.34 | 106 | 98.59 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 3643.54 | 27.36 | 26.69 | 129 | 98.66 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 2783.47 | 35.82 | 24.72 | 89 | 98.93 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 802.25 | 124.44 | 22.8 | 207 | 99.39 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 3714.77 | 53.75 | 48.98 | 263 | 98.53 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 3617.61 | 55.19 | 46.37 | 249 | 98.54 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 2756.81 | 72.42 | 40.04 | 174 | 98.84 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 797.52 | 250.7 | 24.85 | 319 | 99.3 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 3707.16 | 134.79 | 157.45 | 819 | 98.18 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 3546.92 | 140.88 | 166.9 | 859 | 98.28 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 2749.87 | 181.66 | 71.52 | 473 | 98.64 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 735.65 | 679.46 | 42.59 | 795 | 99.36 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 3545.57 | 281.91 | 266.2 | 1287 | 97.44 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 3515.3 | 284.37 | 214.09 | 1215 | 97.75 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 2730.66 | 366.3 | 112.84 | 783 | 98.31 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 705.04 | 1416.34 | 110.22 | 1847 | 99.15 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2816.67 | 35.42 | 37.07 | 144 | 98.16 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 2286.94 | 43.64 | 47.97 | 178 | 98.06 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 772.71 | 129.19 | 143.72 | 951 | 98.22 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 0 | 96.34 | 1037.06 | 129.79 | 1351 | 95.7 |  |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2837.78 | 70.38 | 60.41 | 311 | 97.94 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 2276.11 | 87.77 | 76.87 | 445 | 97.96 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 770.72 | 259.45 | 201.2 | 1271 | 97.93 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 0 | 74.87 | 2663.29 | 480.84 | 4319 | 88.33 | 366.185 |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2889.2 | 172.96 | 130.42 | 743 | 97.32 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 2304.18 | 216.97 | 128.06 | 719 | 97.26 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 772.32 | 647.39 | 394.6 | 2175 | 96.93 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 0 | 71.57 | 6944.07 | 863.53 | 8895 | 86.5 | 479.559 |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2784.51 | 359.17 | 177.51 | 1015 | 96.01 |  |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 2226.31 | 449.22 | 215.01 | 1183 | 96.03 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 664.62 | 1501.99 | 669.5 | 3487 | 94.23 |  |
|  Transformation | 2G | 1000 | 102400 | 0 | 0.04 | 54.87 | 17771.64 | 5437.96 | 41983 | 76.84 | 590.176 |
