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
|  Passthrough | 2G | 50 | 50 | 0 | 100 | 4772.96 | 10.37 | 107.24 | 56 | 99.11 |  |
|  Passthrough | 2G | 50 | 1024 | 0 | 100 | 4722.33 | 10.48 | 9.83 | 55 | 99.07 |  |
|  Passthrough | 2G | 50 | 10240 | 0 | 100 | 4018.78 | 12.33 | 9.8 | 53 | 99.21 |  |
|  Passthrough | 2G | 50 | 102400 | 0 | 100 | 1632.28 | 30.54 | 7.78 | 56 | 99.49 |  |
|  Passthrough | 2G | 100 | 50 | 0 | 100 | 5005.24 | 19.84 | 14.54 | 81 | 99 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 100 | 4927.7 | 20.15 | 14.81 | 82 | 99.04 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 100 | 4115.29 | 24.17 | 15.1 | 80 | 99.15 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 100 | 1626.04 | 61.39 | 14.38 | 109 | 99.49 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 100 | 5274.7 | 37.74 | 22 | 118 | 98.76 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 100 | 5035.35 | 39.54 | 23.12 | 124 | 98.76 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 100 | 4069.73 | 48.99 | 23.44 | 126 | 99.12 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 100 | 1616.69 | 123.57 | 27.65 | 213 | 99.44 |  |
|  Passthrough | 2G | 300 | 50 | 0 | 100 | 4578.69 | 65.34 | 35.21 | 192 | 96.52 |  |
|  Passthrough | 2G | 300 | 1024 | 0 | 100 | 4781.62 | 62.55 | 32.74 | 178 | 97.21 |  |
|  Passthrough | 2G | 300 | 10240 | 0 | 100 | 4050.5 | 73.9 | 28.99 | 164 | 99.05 |  |
|  Passthrough | 2G | 300 | 102400 | 0 | 100 | 1595.37 | 187.93 | 40.78 | 319 | 99.42 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 100 | 5096.37 | 97.91 | 110.66 | 222 | 97.9 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 100 | 4962.95 | 100.56 | 38.92 | 220 | 98.41 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 100 | 4091.37 | 122.01 | 42.17 | 250 | 98.93 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 100 | 1579.98 | 316.01 | 83.24 | 607 | 99.33 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 100 | 4756.84 | 209.99 | 69.27 | 413 | 96.84 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 100 | 4804.18 | 207.95 | 63.13 | 395 | 97.36 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 100 | 4074.19 | 245.36 | 65.95 | 437 | 98.6 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 100 | 1537.03 | 650.14 | 118.32 | 1095 | 99.09 |  |
|  Transformation | 2G | 50 | 50 | 0 | 100 | 4781.93 | 10.35 | 10.16 | 58 | 99.06 |  |
|  Transformation | 2G | 50 | 1024 | 0 | 100 | 4837.58 | 10.23 | 9.59 | 54 | 99.07 |  |
|  Transformation | 2G | 50 | 10240 | 0 | 100 | 4041.89 | 12.26 | 9.8 | 53 | 99.2 |  |
|  Transformation | 2G | 50 | 102400 | 0 | 100 | 1660.74 | 30.01 | 7.77 | 55 | 99.49 |  |
|  Transformation | 2G | 100 | 50 | 0 | 100 | 4976.66 | 19.9 | 14.7 | 81 | 99.01 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 100 | 4935.93 | 20.11 | 14.73 | 81 | 99.01 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 100 | 4083.09 | 24.36 | 15.28 | 80 | 99.17 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 100 | 1614.24 | 61.84 | 14.55 | 109 | 99.46 |  |
|  Transformation | 2G | 200 | 50 | 0 | 100 | 4894.51 | 40.69 | 22.77 | 121 | 98.93 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 100 | 5007.32 | 39.76 | 22.59 | 121 | 98.61 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 100 | 4066.76 | 49.03 | 23.38 | 127 | 99.12 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 100 | 1571.07 | 127.16 | 27.68 | 218 | 99.45 |  |
|  Transformation | 2G | 300 | 50 | 0 | 100 | 4995.28 | 59.87 | 29.25 | 156 | 98.39 |  |
|  Transformation | 2G | 300 | 1024 | 0 | 100 | 4927.91 | 60.7 | 28.36 | 153 | 98.79 |  |
|  Transformation | 2G | 300 | 10240 | 0 | 100 | 4056 | 73.81 | 28.95 | 165 | 99.03 |  |
|  Transformation | 2G | 300 | 102400 | 0 | 100 | 1608.83 | 186.36 | 40.14 | 319 | 99.4 |  |
|  Transformation | 2G | 500 | 50 | 0 | 100 | 4839.78 | 103.12 | 42.01 | 236 | 97.4 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 100 | 4888.02 | 102.08 | 39.62 | 227 | 97.7 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 100 | 4000.22 | 124.8 | 41.55 | 250 | 98.91 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 100 | 1566.61 | 319.36 | 64.01 | 543 | 99.33 |  |
|  Transformation | 2G | 1000 | 50 | 0 | 100 | 4778.02 | 209.01 | 66.08 | 401 | 97.13 |  |
|  Transformation | 2G | 1000 | 1024 | 0 | 100 | 4843.21 | 206.25 | 59.53 | 381 | 98.19 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 100 | 4105.99 | 243.36 | 66.39 | 439 | 98.6 |  |
|  Transformation | 2G | 1000 | 102400 | 0 | 100 | 1595.78 | 626.34 | 154.87 | 1183 | 99.08 |  |
