# WSO2 API Manager Performance Test Results

During each release, we execute various automated performance test scenarios and publish the results.

| Test Scenarios | Description |
| --- | --- |
| StarwarsGraphqlApi | A secured GraphQL API, which directly invokes the backend service. |

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
| Concurrent Users | The number of users accessing the application at the same time. | 50, 100, 200, 500, 1000 |
| GraphQL Query | The GraphQL query number. | 1, 2, 3 |
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

|  Scenario Name | Heap Size | Concurrent Users | GraphQL Query Number | Back-end Service Delay (ms) | Error % | Throughput (Requests/sec) | Average Response Time (ms) | Standard Deviation of Response Time (ms) | 99th Percentile of Response Time (ms) | WSO2 API Manager GC Throughput (%) | Average WSO2 API Manager Memory Footprint After Full GC (M) |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
|  StarwarsGraphqlApi | 2G | 50 | 1 | 0 | 0 | 2101.01 | 23.72 | 14.52 | 81 | 98.16 |  |
|  StarwarsGraphqlApi | 2G | 50 | 2 | 0 | 0 | 1272.53 | 39.19 | 25 | 127 | 98.17 |  |
|  StarwarsGraphqlApi | 2G | 50 | 3 | 0 | 0 | 841.19 | 59.31 | 28.74 | 151 | 98.1 |  |
|  StarwarsGraphqlApi | 2G | 100 | 1 | 0 | 0 | 2135.3 | 46.74 | 24.57 | 133 | 98.01 |  |
|  StarwarsGraphqlApi | 2G | 100 | 2 | 0 | 0 | 1251.5 | 79.79 | 44.24 | 225 | 98.02 |  |
|  StarwarsGraphqlApi | 2G | 100 | 3 | 0 | 0 | 828.53 | 120.52 | 50.52 | 271 | 98.13 |  |
|  StarwarsGraphqlApi | 2G | 200 | 1 | 0 | 0 | 2088.53 | 95.63 | 45.44 | 241 | 97.75 |  |
|  StarwarsGraphqlApi | 2G | 200 | 2 | 0 | 0 | 1215.74 | 164.42 | 77.85 | 399 | 97.79 |  |
|  StarwarsGraphqlApi | 2G | 200 | 3 | 0 | 0 | 835.17 | 239.44 | 89.24 | 485 | 97.65 |  |
|  StarwarsGraphqlApi | 2G | 500 | 1 | 0 | 0 | 1947.96 | 256.68 | 103.9 | 555 | 96.93 |  |
|  StarwarsGraphqlApi | 2G | 500 | 2 | 0 | 0 | 1123.5 | 445.15 | 169.29 | 911 | 97.11 |  |
|  StarwarsGraphqlApi | 2G | 500 | 3 | 0 | 0 | 814.76 | 613.53 | 174.49 | 1079 | 96.54 |  |
|  StarwarsGraphqlApi | 2G | 1000 | 1 | 0 | 0 | 1632.45 | 612.37 | 231 | 1407 | 93.06 | 461.571 |
|  StarwarsGraphqlApi | 2G | 1000 | 2 | 0 | 0 | 958.63 | 1042.08 | 352.94 | 2175 | 92.78 | 459.125 |
|  StarwarsGraphqlApi | 2G | 1000 | 3 | 0 | 0 | 582.62 | 1713.65 | 342.51 | 2655 | 86.96 |  |
