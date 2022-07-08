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
|  StarwarsGraphqlApi | 2G | 50 | 1 | 0 | 0 | 1792.82 | 27.8 | 23.25 | 130 | 94.35 |  |
|  StarwarsGraphqlApi | 2G | 50 | 2 | 0 | 0 | 1102.37 | 45.27 | 32.78 | 169 | 94.91 |  |
|  StarwarsGraphqlApi | 2G | 50 | 3 | 0 | 0 | 746.83 | 66.83 | 32.93 | 181 | 95.42 |  |
|  StarwarsGraphqlApi | 2G | 100 | 1 | 0 | 0 | 1786.85 | 55.87 | 38.2 | 201 | 94.18 |  |
|  StarwarsGraphqlApi | 2G | 100 | 2 | 0 | 0 | 1083.98 | 92.16 | 54.25 | 279 | 94.49 |  |
|  StarwarsGraphqlApi | 2G | 100 | 3 | 0 | 0 | 753.98 | 132.5 | 54.84 | 297 | 95.5 |  |
|  StarwarsGraphqlApi | 2G | 200 | 1 | 0 | 0 | 1763.9 | 113.3 | 61.23 | 317 | 94.15 |  |
|  StarwarsGraphqlApi | 2G | 200 | 2 | 0 | 0 | 1067.03 | 187.4 | 89.2 | 455 | 94.62 |  |
|  StarwarsGraphqlApi | 2G | 200 | 3 | 0 | 0 | 729.03 | 274.42 | 96.78 | 535 | 95.34 |  |
|  StarwarsGraphqlApi | 2G | 300 | 1 | 0 | 0 | 1717.89 | 174.58 | 80.34 | 413 | 94.55 |  |
|  StarwarsGraphqlApi | 2G | 300 | 2 | 0 | 0 | 1073.92 | 279.43 | 118.14 | 619 | 94.76 |  |
|  StarwarsGraphqlApi | 2G | 300 | 3 | 0 | 0 | 724.08 | 414.49 | 125.77 | 739 | 95.34 |  |
|  StarwarsGraphqlApi | 2G | 500 | 1 | 0 | 0 | 1727.63 | 289.45 | 115.58 | 619 | 93.8 |  |
|  StarwarsGraphqlApi | 2G | 500 | 2 | 0 | 0 | 1072.83 | 466.02 | 169.32 | 919 | 94.65 |  |
|  StarwarsGraphqlApi | 2G | 500 | 3 | 0 | 0 | 695.09 | 719.09 | 179.33 | 1175 | 95.08 |  |
|  StarwarsGraphqlApi | 2G | 1000 | 1 | 0 | 0 | 1410.67 | 708.35 | 286.42 | 1751 | 87.07 | 586.463 |
|  StarwarsGraphqlApi | 2G | 1000 | 2 | 0 | 0 | 953.6 | 1047.41 | 343.94 | 2175 | 89.78 | 520.947 |
|  StarwarsGraphqlApi | 2G | 1000 | 3 | 0 | 0 | 635.95 | 1570.1 | 290.61 | 2319 | 92.94 |  |
