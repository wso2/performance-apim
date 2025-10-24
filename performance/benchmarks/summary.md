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
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 3696.29 | 26.97 | 25.31 | 109 | 98.61 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 3655.29 | 27.27 | 33.24 | 161 | 98.62 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 2802.06 | 35.58 | 23.69 | 90 | 98.89 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 831.6 | 120.04 | 16.82 | 168 | 99.43 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 3646.33 | 54.75 | 52.3 | 267 | 98.54 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 3619.27 | 55.16 | 43.91 | 221 | 98.56 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 2766.8 | 72.16 | 44.46 | 225 | 98.84 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 789.91 | 253.13 | 29.39 | 347 | 99.39 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 3666.64 | 136.28 | 148.7 | 783 | 98.21 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 3587.77 | 139.25 | 128.7 | 735 | 98.26 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 2760.53 | 180.95 | 73.06 | 497 | 98.64 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 740.32 | 675.16 | 40.84 | 783 | 99.34 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 3600.71 | 277.49 | 269.69 | 1287 | 97.68 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 3392.52 | 294.62 | 206.66 | 1215 | 97.58 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 2657.99 | 376.23 | 110.85 | 771 | 98.17 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 701.88 | 1422.89 | 112.8 | 1847 | 99.13 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2818.67 | 35.39 | 40.35 | 171 | 98.11 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 2293.53 | 43.51 | 46.86 | 173 | 98.08 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 786.97 | 126.94 | 130.75 | 695 | 98.18 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 0 | 95.55 | 1045.61 | 133.22 | 1359 | 95.48 |  |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2828.42 | 70.61 | 61.94 | 343 | 97.9 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 2298.26 | 86.92 | 76.92 | 353 | 97.85 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 782.06 | 255.68 | 212.86 | 1407 | 98.01 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 0 | 75.38 | 2647.57 | 507.84 | 4479 | 88.28 | 368.444 |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2843.94 | 175.73 | 106.21 | 599 | 97.38 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 2317.62 | 215.7 | 133.12 | 759 | 97.29 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 775.13 | 644.9 | 403.76 | 2239 | 97.22 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 0 | 74.71 | 6654.69 | 867.24 | 8639 | 86.67 | 473.059 |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2735.89 | 365.58 | 176.53 | 1019 | 95.97 |  |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 2184.38 | 457.65 | 218.03 | 1207 | 96.18 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 645.55 | 1545.52 | 702.7 | 3647 | 93.51 |  |
|  Transformation | 2G | 1000 | 102400 | 0 | 0.01 | 55.24 | 17724.26 | 4830.15 | 41727 | 77.04 | 581.466 |
