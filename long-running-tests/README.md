# Artifacts for WSO2 API Manager Long Running Tests

This directory has artifacts to be used for WSO2 API Manager Long Running Tests.

The [setup](setup) directory has the scripts to setup the API Manager to run the long running tests.

1. TestData_Add_Super_Tenant_Users.jmx - Jmeter script to create users in the super tenant domain
2. create-apps.sh - script to create applications and generate keys in the Developer Portal
3. create-api.sh - script to create, deploy and publish APIs in the Publisher Portal and subscribe the created APIs to applications

The [tests](tests) directory has the jmeter test scripts of the long running tests.

1. OAuth_Password_Grant.jmx
2. OAuth_Password_Grant_With_Invocation.jmx
3. OAuth_ClientCredentials_Grant.jmx
4. OAuth_ClientCredentials_Grant_With_Invocation.jmx
5. API_Invocation.jmx

The [netty-service](netty-service) directory has the netty service artifacts which can be used as the backend.

## Executing Long Running Tests

### Setting Up

1. Run the `TestData_Add_Super_Tenant_Users.jmx` script to create users in the super tenant domain. The script has been configured to create 50 users. 

2. Run the `create-apps.sh` to create applications and generate keys in the Developer Portal. The consumer key, consumer secret of each application will be written to `target/client_credentials.csv` file. The application names will have "app" as the prefix followed by a number such as app1, app2, app3.

Usage:
./create-apps.sh -a <apim_host> -n <no_of_apps> -k <token_type> [-h]

-a: Hostname of WSO2 API Manager.
-n: Number of applications.
-k: Token type.
-h: Display this help and exit.

Example Usage:
    ./create-apps.sh -a 54.218.43.40 -n 5 -k JWT

3. Run the `create-api.sh` to create, deploy and publish APIs in the Publisher Portal and subscribe the created APIs to applications.

Usage:
./create-apps.sh -a <apim_host> -i <no_of_apis> -n <api_name_prefix> -d <api_description_prefix> -b <backend_endpoint_url> [-t <backend_endpoint_type>] [-h]

-a: Hostname of WSO2 API Manager.
-i: Number of APIs.
-n: API Name Prefix.
-d: API Description Prefix.
-b: Backend endpoint URL.
-t: Backend endpoint type. Default: http
-h: Display this help and exit.

Example Usage:
    ./create-api.sh -a 54.218.43.40 -i 3 -n api -d desc -b http://54.218.43.40:8688/

4. Start the netty backend service

./netty-start.sh

The netty service can be configured to respond after a delay. The delay is specified in milli-seconds.

./netty-start.sh -- --delay 5000

### Running the Test Scripts

Usage:
./jmeter.sh -n -t <test_script> -l <jtl_output>

Example Usage:
./jmeter.sh -n -t API_Invocation.jmx -l invocation-results.jtl
