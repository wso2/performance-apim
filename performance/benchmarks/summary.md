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
| Concurrent Users | The number of users accessing the application at the same time. | 50, 100, 200, 300, 500, 1000 |
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
|  StarwarsGraphqlApi | 2G | 50 | 1 | 0 | 0 | 1651.25 | 30.21 | 24.5 | 137 | 94.54 |  |
|  StarwarsGraphqlApi | 2G | 50 | 2 | 0 | 0 | 975.2 | 51.19 | 35.89 | 183 | 94.83 |  |
|  StarwarsGraphqlApi | 2G | 50 | 3 | 0 | 0 | 656.55 | 76.04 | 36.57 | 197 | 95.22 |  |
|  StarwarsGraphqlApi | 2G | 100 | 1 | 0 | 0 | 1649.32 | 60.54 | 39.2 | 208 | 94.73 |  |
|  StarwarsGraphqlApi | 2G | 100 | 2 | 0 | 0 | 990.47 | 100.86 | 57.88 | 291 | 94.8 |  |
|  StarwarsGraphqlApi | 2G | 100 | 3 | 0 | 0 | 637.06 | 156.88 | 64.05 | 339 | 95.22 |  |
|  StarwarsGraphqlApi | 2G | 200 | 1 | 0 | 0 | 1619.98 | 123.37 | 65.41 | 339 | 94.52 |  |
|  StarwarsGraphqlApi | 2G | 200 | 2 | 0 | 0 | 928.72 | 215.29 | 101.54 | 515 | 94.63 |  |
|  StarwarsGraphqlApi | 2G | 200 | 3 | 0 | 0 | 640.8 | 312.18 | 106.99 | 595 | 95.16 |  |
|  StarwarsGraphqlApi | 2G | 300 | 1 | 0 | 0 | 1607.17 | 186.59 | 87.52 | 449 | 94.41 |  |
|  StarwarsGraphqlApi | 2G | 300 | 2 | 0 | 0 | 933.99 | 321.31 | 135.45 | 707 | 94.42 |  |
|  StarwarsGraphqlApi | 2G | 300 | 3 | 0 | 0 | 611 | 490.95 | 148.56 | 875 | 95.29 |  |
|  StarwarsGraphqlApi | 2G | 500 | 1 | 0 | 0 | 1628.22 | 307.15 | 119.89 | 639 | 94.47 |  |
|  StarwarsGraphqlApi | 2G | 500 | 2 | 0 | 0 | 915.2 | 546.22 | 196.12 | 1079 | 94.73 |  |
|  StarwarsGraphqlApi | 2G | 500 | 3 | 0 | 0 | 616.19 | 811.17 | 200.72 | 1319 | 94.93 |  |
|  StarwarsGraphqlApi | 2G | 1000 | 1 | 0 | 0 | 1382.94 | 722.55 | 312.73 | 1831 | 86.43 | 559.311 |
|  StarwarsGraphqlApi | 2G | 1000 | 2 | 0 | 0 | 816.77 | 1222.16 | 401.48 | 2463 | 90.78 | 497 |
|  StarwarsGraphqlApi | 2G | 1000 | 3 | 0 | 0 | 532.66 | 1874.1 | 296.05 | 2671 | 92.52 |  |
