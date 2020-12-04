# Artifacts for WSO2 API Manager WebSocket API Performance Tests

---
|  Branch | Build Status |
| :------ |:------------ |
| master  | [![Build Status](https://wso2.org/jenkins/buildStatus/icon?job=platform-builds/performance-apim)](https://wso2.org/jenkins/job/platform-builds/job/performance-apim/) |
---

This repository has artifacts to be used for WSO2 API Manager WebSocket API Performance Tests.

The [distribution](distribution) directory has the jmeter scripts used to evaluate the performance of WebSocket APIs.

## Approach

* First, the number of connections that a single WebSocket API can handle was evaluated using Jmeter while increasing the ramp up period. And the Enterprise Integrator also evaluated for the number of connections that a WebSocket endpoint can handle when connecting through WSO2 EI.
* Then, perfomance with message rates was evaluated while establishing a single connection. For this, Thor was used as the WebSocket client and Tornardo was used as the backend.
  
  **Note:** When sending messages using Thor WebSocket client, Thor send a message and wait for the response from backend to send the next message.
* Finally, another evaluation was done to measure the perfomance of APIM with different number of connections and message rates.

## Evaluation results

Following graph shows how the error rate varies with the ramp up period for 250,300,500,750 and 1000 connections for APIM.

**Note:** A single JWT Token is used per test execution for APIM.

![API Manager All-in-one Deployment](performance/benchmarks/Graphs/Error_rate_vs_Ramp_up_period_for_APIM.png)

Following graph shows how the error rate varies with the ramp up period for 250,300,500,750 and 1000 connections for EI.

![API Manager All-in-one Deployment](performance/benchmarks/Graphs/Error_rate_vs_Ramp_up_period_for_EI.png)

Following graph compares how total time taken for sending requests varies with the number of messages for APIM, EI, APIM+EI and direct tornado backend.

![API Manager All-in-one Deployment](performance/benchmarks/Graphs/Time_taken_vs_No_of_messages.png)

Following graph compares how transmission rate varies with the number of messages for APIM, EI, APIM+EI and direct tornado backend.

![API Manager All-in-one Deployment](performance/benchmarks/Graphs/Transmission_rate_vs_No_of_messages.png)

Following set of graphs show how the performance of APIM varies with the number of connections and number of messages.

* Time taken vs. message size for different number of messages.

![API Manager All-in-one Deployment](performance/benchmarks/Graphs/Graphs_for_APIM_Performance_results/Time_taken_vs_message_size_for_5000_messages.png)

![API Manager All-in-one Deployment](performance/benchmarks/Graphs/Graphs_for_APIM_Performance_results/Time_taken_vs_message_size_for_7000_messages.png)

![API Manager All-in-one Deployment](performance/benchmarks/Graphs/Graphs_for_APIM_Performance_results/Time_taken_vs_message_size_for_10,000_messages(100_connections).png)

* Transmission rate vs. message size for different number of messages.

![API Manager All-in-one Deployment](performance/benchmarks/Graphs/Graphs_for_APIM_Performance_results/Transmission_rate_vs_meassage_size_for_5000_messages.png)

![API Manager All-in-one Deployment](performance/benchmarks/Graphs/Graphs_for_APIM_Performance_results/Transmission_rate_vs_Message_size_for_7000_messages.png)

![API Manager All-in-one Deployment](performance/benchmarks/Graphs/Graphs_for_APIM_Performance_results/Transmission_rate_vs_Message_size_for_10,000_messages(100_connections).png)

## License

Copyright 2017 WSO2 Inc. (http://wso2.com)

Licensed under the Apache License, Version 2.0
