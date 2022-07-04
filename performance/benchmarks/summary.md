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
|  StarwarsGraphqlApi | 2G | 50 | 1 | 0 | 0 | 1597.71 | 31.21 | 24.51 | 134 | 94.88 |  |
|  StarwarsGraphqlApi | 2G | 50 | 2 | 0 | 0 | 887.34 | 56.26 | 37.41 | 189 | 95.25 |  |
|  StarwarsGraphqlApi | 2G | 50 | 3 | 0 | 0 | 592.28 | 84.31 | 41.47 | 217 | 95.58 |  |
|  StarwarsGraphqlApi | 2G | 100 | 1 | 0 | 0 | 1615.38 | 61.82 | 38.63 | 206 | 95.07 |  |
|  StarwarsGraphqlApi | 2G | 100 | 2 | 0 | 0 | 869.74 | 114.89 | 63.78 | 319 | 95.14 |  |
|  StarwarsGraphqlApi | 2G | 100 | 3 | 0 | 0 | 583.45 | 171.3 | 67.46 | 359 | 95.71 |  |
|  StarwarsGraphqlApi | 2G | 200 | 1 | 0 | 0 | 1578.43 | 126.6 | 64.32 | 331 | 94.72 |  |
|  StarwarsGraphqlApi | 2G | 200 | 2 | 0 | 0 | 857.16 | 233.32 | 104.66 | 531 | 95.23 |  |
|  StarwarsGraphqlApi | 2G | 200 | 3 | 0 | 0 | 563.16 | 355.3 | 115.8 | 663 | 95.68 |  |
|  StarwarsGraphqlApi | 2G | 300 | 1 | 0 | 0 | 1534.41 | 195.47 | 86.67 | 447 | 94.84 |  |
|  StarwarsGraphqlApi | 2G | 300 | 2 | 0 | 0 | 815.44 | 367.97 | 142.77 | 767 | 95.07 |  |
|  StarwarsGraphqlApi | 2G | 300 | 3 | 0 | 0 | 570.32 | 525.83 | 150.48 | 907 | 95.61 |  |
|  StarwarsGraphqlApi | 2G | 500 | 1 | 0 | 0 | 1555.64 | 321.49 | 121.16 | 655 | 94.57 |  |
|  StarwarsGraphqlApi | 2G | 500 | 2 | 0 | 0 | 833.26 | 599.94 | 206.13 | 1159 | 95.18 |  |
|  StarwarsGraphqlApi | 2G | 500 | 3 | 0 | 0 | 565.5 | 883.82 | 201.28 | 1391 | 95.29 |  |
|  StarwarsGraphqlApi | 2G | 1000 | 1 | 0 | 0 | 1356.79 | 736.88 | 276.54 | 1727 | 89.58 | 562 |
|  StarwarsGraphqlApi | 2G | 1000 | 2 | 0 | 0 | 786.98 | 1268.76 | 385.86 | 2447 | 91.53 | 491.143 |
|  StarwarsGraphqlApi | 2G | 1000 | 3 | 0 | 0 | 514.36 | 1940.21 | 306.72 | 2719 | 93.71 |  |
