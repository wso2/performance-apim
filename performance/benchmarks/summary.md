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
|  Passthrough | 2G | 100 | 50 | 0 | 0 | 3823.35 | 26.03 | 14.58 | 81 | 98.46 |  |
|  Passthrough | 2G | 100 | 1024 | 0 | 0 | 3800.42 | 26.19 | 13.67 | 76 | 98.44 |  |
|  Passthrough | 2G | 100 | 10240 | 0 | 0 | 2833.55 | 35.09 | 17.62 | 96 | 98.7 |  |
|  Passthrough | 2G | 100 | 102400 | 0 | 0 | 846.87 | 117.85 | 29.53 | 195 | 99.27 |  |
|  Passthrough | 2G | 200 | 50 | 0 | 0 | 3872.09 | 51.52 | 24.85 | 136 | 98.33 |  |
|  Passthrough | 2G | 200 | 1024 | 0 | 0 | 3769.63 | 52.92 | 25.34 | 137 | 98.36 |  |
|  Passthrough | 2G | 200 | 10240 | 0 | 0 | 2921.67 | 68.26 | 30.05 | 166 | 98.64 |  |
|  Passthrough | 2G | 200 | 102400 | 0 | 0 | 831.81 | 240.32 | 47.79 | 367 | 99.25 |  |
|  Passthrough | 2G | 500 | 50 | 0 | 0 | 3975.22 | 125.61 | 52.91 | 289 | 97.97 |  |
|  Passthrough | 2G | 500 | 1024 | 0 | 0 | 3914.91 | 127.55 | 53.54 | 291 | 98 |  |
|  Passthrough | 2G | 500 | 10240 | 0 | 0 | 2895.67 | 172.45 | 58.25 | 341 | 98.38 |  |
|  Passthrough | 2G | 500 | 102400 | 0 | 0 | 746.65 | 669.42 | 93.85 | 943 | 99.17 |  |
|  Passthrough | 2G | 1000 | 50 | 0 | 0 | 3649.72 | 273.99 | 100.46 | 559 | 97.36 |  |
|  Passthrough | 2G | 1000 | 1024 | 0 | 0 | 3619.48 | 276.19 | 98.19 | 551 | 97.38 |  |
|  Passthrough | 2G | 1000 | 10240 | 0 | 0 | 2730.23 | 366.21 | 100.15 | 647 | 97.94 |  |
|  Passthrough | 2G | 1000 | 102400 | 0 | 0 | 711.87 | 1402.85 | 160.38 | 1927 | 98.98 |  |
|  Transformation | 2G | 100 | 50 | 0 | 0 | 3027.41 | 32.91 | 19.33 | 104 | 97.91 |  |
|  Transformation | 2G | 100 | 1024 | 0 | 0 | 2488.99 | 40.03 | 22.3 | 119 | 97.85 |  |
|  Transformation | 2G | 100 | 10240 | 0 | 0 | 851.94 | 117.11 | 58.45 | 295 | 97.8 |  |
|  Transformation | 2G | 100 | 102400 | 0 | 0 | 100.83 | 991.14 | 234.64 | 1583 | 94.59 | 307 |
|  Transformation | 2G | 200 | 50 | 0 | 0 | 3120.64 | 63.95 | 32.44 | 174 | 97.66 |  |
|  Transformation | 2G | 200 | 1024 | 0 | 0 | 2493.42 | 80.06 | 38.93 | 208 | 97.61 |  |
|  Transformation | 2G | 200 | 10240 | 0 | 0 | 824.13 | 242.62 | 103.95 | 539 | 97.7 |  |
|  Transformation | 2G | 200 | 102400 | 0 | 0 | 81.53 | 2448.39 | 542.29 | 4319 | 87.89 | 337.95 |
|  Transformation | 2G | 500 | 50 | 0 | 0 | 2904.99 | 171.98 | 72.23 | 391 | 97.12 |  |
|  Transformation | 2G | 500 | 1024 | 0 | 0 | 2428.95 | 205.75 | 82.6 | 451 | 97.1 |  |
|  Transformation | 2G | 500 | 10240 | 0 | 0 | 825.06 | 605.86 | 199.99 | 1151 | 97.08 |  |
|  Transformation | 2G | 500 | 102400 | 0 | 0 | 79.03 | 6294.96 | 1078.95 | 8895 | 85.33 | 464.056 |
|  Transformation | 2G | 1000 | 50 | 0 | 0 | 2905.56 | 344.17 | 120.23 | 683 | 96.13 |  |
|  Transformation | 2G | 1000 | 1024 | 0 | 0 | 2343.48 | 426.57 | 142.6 | 823 | 96.13 |  |
|  Transformation | 2G | 1000 | 10240 | 0 | 0 | 814.73 | 1226.47 | 317.27 | 2079 | 95.73 |  |
|  Transformation | 2G | 1000 | 102400 | 0 | 0.02 | 54.56 | 14899.24 | 3929.64 | 37119 | 82.71 | 550.218 |
