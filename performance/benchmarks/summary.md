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
|  StarwarsGraphqlApi | 2G | 50 | 1 | 0 | 0 | 2121.9 | 23.48 | 14.74 | 80 | 98.2 |  |
|  StarwarsGraphqlApi | 2G | 50 | 2 | 0 | 0 | 1253.3 | 39.79 | 27.11 | 135 | 98.18 |  |
|  StarwarsGraphqlApi | 2G | 50 | 3 | 0 | 0 | 865.01 | 57.67 | 28.77 | 151 | 98.24 |  |
|  StarwarsGraphqlApi | 2G | 100 | 1 | 0 | 0 | 2174.29 | 45.89 | 24.39 | 132 | 97.97 |  |
|  StarwarsGraphqlApi | 2G | 100 | 2 | 0 | 0 | 1223.8 | 81.59 | 45.99 | 231 | 98.07 |  |
|  StarwarsGraphqlApi | 2G | 100 | 3 | 0 | 0 | 850.92 | 117.35 | 50.38 | 267 | 97.97 |  |
|  StarwarsGraphqlApi | 2G | 200 | 1 | 0 | 0 | 2176.71 | 91.76 | 44.24 | 235 | 97.66 |  |
|  StarwarsGraphqlApi | 2G | 200 | 2 | 0 | 0 | 1191.37 | 167.78 | 81.08 | 413 | 97.82 |  |
|  StarwarsGraphqlApi | 2G | 200 | 3 | 0 | 0 | 846.69 | 236.14 | 88.95 | 481 | 97.8 |  |
|  StarwarsGraphqlApi | 2G | 500 | 1 | 0 | 0 | 2071.41 | 241.35 | 100.89 | 527 | 96.66 | 373 |
|  StarwarsGraphqlApi | 2G | 500 | 2 | 0 | 0 | 1174.54 | 425.74 | 166.35 | 891 | 96.58 |  |
|  StarwarsGraphqlApi | 2G | 500 | 3 | 0 | 0 | 818.76 | 610.55 | 178.17 | 1087 | 97 |  |
|  StarwarsGraphqlApi | 2G | 1000 | 1 | 0 | 0 | 1663.14 | 601.06 | 229.81 | 1439 | 91.73 | 467.571 |
|  StarwarsGraphqlApi | 2G | 1000 | 2 | 0 | 0 | 991.41 | 1008.09 | 359.72 | 2175 | 90.89 | 460 |
|  StarwarsGraphqlApi | 2G | 1000 | 3 | 0 | 0 | 695.83 | 1435.19 | 273.13 | 2159 | 93.74 | 454 |
