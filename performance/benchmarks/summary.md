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
|  StarwarsGraphqlApi | 2G | 50 | 1 | 0 | 0 | 2233.78 | 22.3 | 14.39 | 79 | 97.95 |  |
|  StarwarsGraphqlApi | 2G | 50 | 2 | 0 | 0 | 1266.95 | 39.36 | 26.83 | 134 | 98.13 |  |
|  StarwarsGraphqlApi | 2G | 50 | 3 | 0 | 0 | 822.55 | 60.65 | 32.1 | 166 | 98.12 |  |
|  StarwarsGraphqlApi | 2G | 100 | 1 | 0 | 0 | 2260.55 | 44.13 | 23.94 | 130 | 97.86 |  |
|  StarwarsGraphqlApi | 2G | 100 | 2 | 0 | 0 | 1262.97 | 79.05 | 46.13 | 230 | 97.99 |  |
|  StarwarsGraphqlApi | 2G | 100 | 3 | 0 | 0 | 853.2 | 117.03 | 50.62 | 269 | 97.93 |  |
|  StarwarsGraphqlApi | 2G | 200 | 1 | 0 | 0 | 2191.54 | 91.14 | 44.95 | 237 | 97.57 |  |
|  StarwarsGraphqlApi | 2G | 200 | 2 | 0 | 0 | 1241.77 | 160.95 | 78.85 | 403 | 97.69 |  |
|  StarwarsGraphqlApi | 2G | 200 | 3 | 0 | 0 | 805.76 | 248.14 | 97.21 | 527 | 97.68 |  |
|  StarwarsGraphqlApi | 2G | 500 | 1 | 0 | 0 | 2075.48 | 240.86 | 101.87 | 535 | 96.71 | 357 |
|  StarwarsGraphqlApi | 2G | 500 | 2 | 0 | 0 | 1252.5 | 399.15 | 160.3 | 847 | 96.8 |  |
|  StarwarsGraphqlApi | 2G | 500 | 3 | 0 | 0 | 837.78 | 596.62 | 181.35 | 1071 | 96.64 |  |
|  StarwarsGraphqlApi | 2G | 1000 | 1 | 0 | 0 | 1647.99 | 606.51 | 231.06 | 1423 | 91.89 | 463.6 |
|  StarwarsGraphqlApi | 2G | 1000 | 2 | 0 | 0 | 967.67 | 1032.27 | 384.98 | 2399 | 89.6 | 465.867 |
|  StarwarsGraphqlApi | 2G | 1000 | 3 | 0 | 0 | 581.09 | 1718.04 | 334.72 | 2591 | 87.51 |  |
