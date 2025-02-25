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
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 3523.96 | 28.26 | 15.3 | 86 | 98.67 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 3458.05 | 28.81 | 15.16 | 84 | 98.65 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 2591.83 | 38.41 | 19.15 | 104 | 98.88 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 769.88 | 129.66 | 31.05 | 210 | 99.39 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 3452.83 | 57.81 | 28.4 | 154 | 98.56 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 3529.82 | 56.56 | 26.46 | 144 | 98.57 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 2596.85 | 76.82 | 33.24 | 182 | 98.84 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 699.98 | 285.77 | 50.01 | 413 | 99.39 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 3607.09 | 138.47 | 56.79 | 307 | 98.3 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 3602.78 | 138.62 | 56.19 | 309 | 98.28 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 2575.53 | 193.96 | 63.05 | 375 | 98.65 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 673.19 | 742.36 | 92.16 | 971 | 99.33 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 3512.09 | 284.65 | 100.25 | 567 | 97.78 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 3509.92 | 284.9 | 95.4 | 555 | 97.87 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 2571.05 | 388.92 | 100.46 | 663 | 98.35 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 660.2 | 1512.49 | 134.73 | 1831 | 99.23 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 2688.8 | 37.07 | 21.01 | 114 | 98.14 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 2276.71 | 43.8 | 23.94 | 129 | 98.06 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 721.16 | 138.39 | 67.09 | 341 | 98.19 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 0 | 92.89 | 1075.38 | 211.95 | 1607 | 96.16 |  |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 2465.65 | 80.98 | 40.18 | 214 | 98.06 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 2047.82 | 97.53 | 46.43 | 246 | 97.96 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 727.86 | 274.74 | 114.05 | 595 | 97.96 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 0 | 73.24 | 2724.86 | 526.32 | 4575 | 89.19 | 347.526 |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2600.86 | 192.15 | 76.6 | 419 | 97.52 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 2244.59 | 222.69 | 87.13 | 477 | 97.37 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 747.1 | 669.04 | 214.29 | 1255 | 97.32 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 0 | 73.2 | 6782.33 | 1113.8 | 9535 | 86.54 | 461.5 |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2527.96 | 395.6 | 141.12 | 811 | 96.55 |  |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 2060.28 | 485.29 | 160.13 | 927 | 96.4 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 679.64 | 1469.08 | 368.75 | 2495 | 95.33 |  |
|  Transformation | 2G | 1000 | 102400 | 0 | 0 | 57.11 | 17107.31 | 5177.9 | 44543 | 80.33 | 562.947 |
