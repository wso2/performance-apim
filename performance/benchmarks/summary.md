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
| Concurrent Users | The number of users accessing the application at the same time. | 50, 100, 200, 300, 500, 1000 |
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
|  Passthrough | 2G | 50 | 50 | 0 | 0 | 2732.16 | 18.21 | 19.16 | 97 | 94.42 |  |
|  Passthrough | 2G | 50 | 1024 | 0 | 0 | 2701.7 | 18.41 | 19.27 | 102 | 94.25 |  |
|  Passthrough | 2G | 50 | 10240 | 0 | 0 | 2007.07 | 24.79 | 18.49 | 92 | 95.81 |  |
|  Passthrough | 2G | 50 | 102400 | 0 | 0 | 544.09 | 91.7 | 23.04 | 178 | 98.46 |  |
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 2829.53 | 35.23 | 28.67 | 166 | 94.27 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 2832.36 | 35.2 | 28.1 | 160 | 94.18 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 1975.1 | 50.49 | 29.81 | 174 | 95.7 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 523.76 | 190.73 | 37.28 | 313 | 98.54 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 2857.6 | 69.87 | 42.87 | 237 | 94.22 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 2821.63 | 70.77 | 41.88 | 232 | 94.06 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 2003.42 | 99.68 | 47.42 | 277 | 95.58 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 513.24 | 389.85 | 59.52 | 579 | 98.43 |  |
|  Passthrough | 2G | 300 | 50 | 0 | 0 | 2855.35 | 104.93 | 55.47 | 299 | 94.02 |  |
|  Passthrough | 2G | 300 | 1024 | 0 | 0 | 2789.91 | 107.4 | 53.4 | 293 | 94.32 |  |
|  Passthrough | 2G | 300 | 10240 | 0 | 0 | 1981.41 | 151.25 | 61.72 | 377 | 95.52 |  |
|  Passthrough | 2G | 300 | 102400 | 0 | 0 | 510.55 | 587.58 | 76.16 | 827 | 98.42 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 2820.55 | 177.16 | 77.99 | 419 | 94.16 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 2698.29 | 185.23 | 78.18 | 427 | 94.36 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 1937.35 | 258.08 | 87.08 | 527 | 95.65 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 500.73 | 997.87 | 110.55 | 1335 | 98.37 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 2699.02 | 370.54 | 131.26 | 731 | 93.66 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 2626.66 | 380.76 | 127.93 | 735 | 93.83 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 1923.03 | 519.82 | 137.15 | 879 | 95.31 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 494.09 | 2020.21 | 186.68 | 2591 | 97.99 |  |
|  Transformation | 2G | 50 | 50 | 0 | 100 | 76.45 | 653.5 | 372.07 | 1311 | 98.76 |  |
|  Transformation | 2G | 50 | 1024 | 0 | 100 | 75.96 | 657.68 | 372.96 | 1327 | 98.75 |  |
|  Transformation | 2G | 50 | 10240 | 0 | 100 | 76.96 | 649.22 | 368.98 | 1303 | 98.75 |  |
|  Transformation | 2G | 50 | 102400 | 0 | 100 | 73.71 | 676.99 | 382.88 | 1343 | 98.8 |  |
|  Transformation | 2G | 100 | 50 | 0 | 100 | 75.44 | 1322.72 | 757.92 | 2639 | 98.77 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 100 | 76.01 | 1311.78 | 751.44 | 2607 | 98.76 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 100 | 76.03 | 1311.98 | 753.16 | 2623 | 98.77 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 100 | 72.58 | 1373.06 | 781.07 | 2735 | 98.81 |  |
|  Transformation | 2G | 200 | 50 | 0 | 100 | 75.21 | 2644.62 | 1520.03 | 5247 | 98.73 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 100 | 76.35 | 2608.27 | 1501.24 | 5183 | 98.7 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 100 | 75.92 | 2620.88 | 1508.66 | 5215 | 98.74 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 100 | 71.66 | 2773.82 | 1586.99 | 5503 | 98.74 |  |
|  Transformation | 2G | 300 | 50 | 0 | 100 | 75.11 | 3963.79 | 2282.64 | 7871 | 98.63 |  |
|  Transformation | 2G | 300 | 1024 | 0 | 100 | 74.73 | 3981.61 | 2293.79 | 7903 | 98.7 |  |
|  Transformation | 2G | 300 | 10240 | 0 | 100 | 74.51 | 3997.73 | 2300.09 | 7935 | 98.72 |  |
|  Transformation | 2G | 300 | 102400 | 0 | 100 | 71.44 | 4158.86 | 2387.49 | 8255 | 98.73 |  |
|  Transformation | 2G | 500 | 50 | 0 | 100 | 73.66 | 6701.88 | 3109.03 | 12031 | 98.63 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 100 | 73.81 | 6689.07 | 3106.25 | 12031 | 98.68 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 100 | 73.31 | 6738.77 | 3126.79 | 12095 | 98.67 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 100 | 70.77 | 6972.7 | 3208.07 | 12479 | 98.7 |  |
|  Transformation | 2G | 1000 | 50 | 0 | 100 | 72.44 | 13493.48 | 3133.07 | 18943 | 98.6 |  |
|  Transformation | 2G | 1000 | 1024 | 0 | 100 | 73.12 | 13372.41 | 3099.52 | 18815 | 98.6 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 100 | 73.66 | 13263.05 | 3073.5 | 18559 | 98.52 |  |
|  Transformation | 2G | 1000 | 102400 | 0 | 100 | 67.83 | 14375.86 | 3307.81 | 20095 | 98.58 |  |
