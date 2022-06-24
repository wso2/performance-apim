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
|  StarwarsGraphqlApi | 2G | 50 | 1 | 0 | 0 | 95.13 | 525.53 | 198.4 | 1119 | 99.44 |  |
|  StarwarsGraphqlApi | 2G | 50 | 2 | 0 | 0 | 95.22 | 525.04 | 198.51 | 1119 | 99.36 |  |
|  StarwarsGraphqlApi | 2G | 50 | 3 | 0 | 0 | 95.17 | 525.34 | 197.6 | 1119 | 99.23 |  |
|  StarwarsGraphqlApi | 2G | 100 | 1 | 0 | 0 | 95 | 1051.16 | 301.5 | 2175 | 99.45 |  |
|  StarwarsGraphqlApi | 2G | 100 | 2 | 0 | 0 | 94.96 | 1051.6 | 303.16 | 2175 | 99.35 |  |
|  StarwarsGraphqlApi | 2G | 100 | 3 | 0 | 0 | 94.83 | 1053.06 | 302.26 | 2175 | 99.2 |  |
|  StarwarsGraphqlApi | 2G | 200 | 1 | 0 | 0 | 95.34 | 2091.03 | 438.88 | 4223 | 99.48 |  |
|  StarwarsGraphqlApi | 2G | 200 | 2 | 0 | 0 | 94.62 | 2106.82 | 439.59 | 4223 | 99.34 |  |
|  StarwarsGraphqlApi | 2G | 200 | 3 | 0 | 0 | 94.66 | 2105.78 | 445.86 | 4255 | 99.18 |  |
|  StarwarsGraphqlApi | 2G | 300 | 1 | 0 | 0 | 94.56 | 3156.13 | 549.31 | 6271 | 99.47 |  |
|  StarwarsGraphqlApi | 2G | 300 | 2 | 0 | 0 | 94.62 | 3154.59 | 547.44 | 6271 | 99.3 |  |
|  StarwarsGraphqlApi | 2G | 300 | 3 | 0 | 0 | 94.9 | 3145.11 | 547.36 | 6271 | 99.11 |  |
|  StarwarsGraphqlApi | 2G | 500 | 1 | 0 | 0 | 94.78 | 5228.87 | 715.8 | 10175 | 99.42 |  |
|  StarwarsGraphqlApi | 2G | 500 | 2 | 0 | 0 | 94.51 | 5244.47 | 719.41 | 10175 | 99.27 |  |
|  StarwarsGraphqlApi | 2G | 500 | 3 | 0 | 0 | 94.32 | 5255.33 | 713.89 | 10239 | 99.08 |  |
|  StarwarsGraphqlApi | 2G | 1000 | 1 | 0 | 0 | 94.09 | 10443.7 | 1022.42 | 11775 | 99.33 |  |
|  StarwarsGraphqlApi | 2G | 1000 | 2 | 0 | 0 | 93.05 | 10564.88 | 1033.25 | 11775 | 98.78 |  |
|  StarwarsGraphqlApi | 2G | 1000 | 3 | 0 | 0 | 93.52 | 10510.3 | 1031.22 | 11775 | 98.24 |  |
