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
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 3645.91 | 27.33 | 15.5 | 85 | 98.49 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 3405.2 | 29.27 | 16.83 | 91 | 98.55 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 2582.82 | 38.57 | 20.39 | 106 | 98.77 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 735.57 | 135.74 | 32.84 | 219 | 99.29 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 3516.75 | 56.76 | 30.79 | 160 | 98.43 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 3503.36 | 56.97 | 31.38 | 163 | 98.41 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 2596.64 | 76.86 | 36.17 | 186 | 98.7 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 679.89 | 294.24 | 60.44 | 441 | 99.29 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 3374.98 | 148.02 | 68.77 | 355 | 98.12 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 3318.27 | 150.56 | 68.01 | 353 | 98.15 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 2652.84 | 188.32 | 68.37 | 383 | 98.49 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 648.81 | 770.31 | 112.7 | 1071 | 99.19 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 3532.85 | 283.06 | 115.55 | 611 | 97.4 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 3245.95 | 308.17 | 117.11 | 635 | 97.47 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 2503.74 | 399.49 | 111.33 | 699 | 97.9 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 630.06 | 1584.15 | 163.82 | 2039 | 98.99 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2724.54 | 36.61 | 22.53 | 119 | 98.05 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 2112.52 | 47.23 | 28.3 | 146 | 98.06 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 753.9 | 132.44 | 66.6 | 331 | 98.01 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 0 | 92.32 | 1082.72 | 241.1 | 1703 | 95.26 | 319 |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2718.57 | 73.45 | 41.02 | 210 | 97.87 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 2159.6 | 92.48 | 48.95 | 251 | 97.83 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 757.48 | 263.98 | 116.75 | 595 | 97.83 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 0 | 71.58 | 2784.28 | 575.02 | 4767 | 89.02 | 359.444 |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2582.21 | 193.54 | 89.99 | 461 | 97.34 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 2164.09 | 231 | 103.04 | 539 | 97.25 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 692.08 | 721.98 | 238.72 | 1351 | 97.23 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 0 | 69.52 | 7154.96 | 1146.41 | 9919 | 86.65 | 470.806 |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2386.38 | 418.97 | 158.62 | 859 | 96.17 |  |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 2219.23 | 450.59 | 163.64 | 907 | 96.13 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 717.38 | 1392.07 | 374.21 | 2447 | 94.24 |  |
|  Transformation | 2G | 1000 | 102400 | 0 | 0 | 63.11 | 15547.02 | 1706.16 | 19711 | 78.97 | 562.35 |
