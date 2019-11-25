/*
 * Copyright (c) 2019, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 * WSO2 Inc. licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
package org.wso2.performance.apim.microgw.jwt;

import com.beust.jcommander.JCommander;
import com.beust.jcommander.Parameter;
import org.json.JSONArray;
import org.json.JSONObject;
import org.wso2.performance.apim.microgw.jwt.model.ApplicationDTO;
import org.wso2.performance.apim.microgw.jwt.model.SubscribedApiDTO;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintStream;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.security.Key;
import java.security.KeyStore;
import java.security.PrivateKey;
import java.security.Signature;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

/**
 * JWT Token Generator for Microgateway Performance Tests
 */
public class JWTGenerator {

    private static final String WSO2CARBON = "wso2carbon";
    private static final int VALIDITY_PERIOD = 3600 * 24 * 365;

    @Parameter(names = "--api-name", description = "API Name", required = true)
    private String apiName;

    @Parameter(names = "--context", description = "API Context", required = true)
    private String context;

    @Parameter(names = "--version", description = "API Version", required = true)
    private String version;

    @Parameter(names = "--app-name", description = "Application Name", required = true)
    private String appName;
    
    @Parameter(names = "--app-owner", description = "Application Owner", required = true)
    private String appOwner;

    @Parameter(names = "--app-tier", description = "Application Tier", required = true)
    private String appTier;

    @Parameter(names = "--subs-tier", description = "Subscription Tier", required = true)
    private String subsTier;

    @Parameter(names = "--app-id", description = "Application ID", required = false)
    private int appId;
    
    @Parameter(names = "--app-uuid", description = "Application UUID", required = false)
    private String appUUId;

    @Parameter(names = "--consumer-key", description = "Consumer key", required = true)
    private String consumerKey;
    
    @Parameter(names = {"--key-store-file"}, description = "Key Store File", required = true,
            validateValueWith = KeyStoreFileValidator.class)
    private File keyStoreFile;

    @Parameter(names = "--tokens-count", description = "Number of tokens to generate", required = true)
    private int tokensCount;

    @Parameter(names = {"--output-file"}, description = "Output File", required = true)
    private File outputFile;

    @Parameter(names = {"-h", "--help"}, description = "Display Help", help = true)
    private boolean help = false;

    private static PrintStream errorOutput = System.err;
    private static PrintStream standardOutput = System.out;

    public static void main(String[] args) throws Exception {
        JWTGenerator jwtGenerator = new JWTGenerator();
        final JCommander jcmdr = new JCommander(jwtGenerator);
        jcmdr.setProgramName(JWTGenerator.class.getSimpleName());

        try {
            jcmdr.parse(args);
        } catch (Exception e) {
            errorOutput.println(e.getMessage());
            return;
        }

        if (jwtGenerator.help) {
            jcmdr.usage();
            return;
        }

        jwtGenerator.generateTokens();
    }

    private void generateTokens() throws Exception {
        long startTime = System.nanoTime();
        standardOutput.format("Generating tokens for API: %s and Application: %s.%n", apiName, appName);
        ApplicationDTO application = new ApplicationDTO();
        application.setName(appName);
        application.setTier(appTier);
        application.setId(appId);
        application.setUuid(appUUId);
        application.setOwner(appOwner);

        List<SubscribedApiDTO> subscribedList = new ArrayList<SubscribedApiDTO>();
        
        String[] apiNameList = apiName.split(",");
        String[] contextList = context.split(",");
        String[] versionList = version.split(",");
        
        for (int i = 0; i < apiNameList.length; i++) {
            SubscribedApiDTO subscribedApiDTO = new SubscribedApiDTO();
            subscribedApiDTO.setContext("/" + contextList[i] + "/" + versionList[i]);
            subscribedApiDTO.setName(apiNameList[i]);
            subscribedApiDTO.setVersion(versionList[i]);
            subscribedApiDTO.setPublisher("admin");
            subscribedApiDTO.setSubscriptionTier(subsTier);
            subscribedApiDTO.setSubscriberTenantDomain("carbon.super");
            subscribedList.add(subscribedApiDTO);
        }

        JSONObject head = new JSONObject();
        head.put("typ", "JWT");
        head.put("alg", "RS256");
        head.put("x5t", "UB_BQy2HFV3EMTgq64Q-1VitYbE");

        JSONObject tierInfoElement = new JSONObject();
        tierInfoElement.put("stopOnQuotaReach", true);
        tierInfoElement.put("spikeArrestLimit", 0);
        tierInfoElement.put("spikeArrestUnit", "s");
        JSONObject tierInfo = new JSONObject();
        tierInfo.put(subsTier, tierInfoElement);
        
        String header = head.toString();

        String base64UrlEncodedHeader = Base64.getUrlEncoder()
                .encodeToString(header.getBytes(Charset.defaultCharset()));

        Signature signature = Signature.getInstance("SHA256withRSA");
        KeyStore keystore;
        try (FileInputStream is = new FileInputStream(keyStoreFile)) {
            keystore = KeyStore.getInstance(KeyStore.getDefaultType());
            keystore.load(is, WSO2CARBON.toCharArray());
        }
        Key key = keystore.getKey(WSO2CARBON, WSO2CARBON.toCharArray());
        signature.initSign((PrivateKey) key);

        standardOutput.print("Generating tokens...\r");

        try (BufferedWriter tokensWriter = new BufferedWriter(new FileWriter(outputFile))) {
            for (int i = 1; i <= tokensCount; i++) {
                JSONObject jwtTokenInfo = new JSONObject();
                jwtTokenInfo.put("aud", "http://org.wso2.apimgt/gateway");
                jwtTokenInfo.put("sub", "admin");
                jwtTokenInfo.put("application", new JSONObject(application));
                jwtTokenInfo.put("scope", "am_application_scope default");
                jwtTokenInfo.put("iss", "https://localhost:9443/oauth2/token");
                jwtTokenInfo.put("keytype", "PRODUCTION");
                jwtTokenInfo.put("subscribedAPIs", new JSONArray(subscribedList));
                jwtTokenInfo.put("exp", (int) TimeUnit.MILLISECONDS.toSeconds(System.currentTimeMillis())
                        + VALIDITY_PERIOD);
                jwtTokenInfo.put("iat", (int) TimeUnit.MILLISECONDS.toSeconds(System.currentTimeMillis()));
                jwtTokenInfo.put("jti", UUID.randomUUID());
                jwtTokenInfo.put("consumerKey", consumerKey);
                jwtTokenInfo.put("tierInfo", tierInfo);

                String payload = jwtTokenInfo.toString();
                String base64UrlEncodedBody = Base64.getUrlEncoder()
                        .encodeToString(payload.getBytes(Charset.defaultCharset()));
                String assertion = base64UrlEncodedHeader + "." + base64UrlEncodedBody;
                byte[] dataInBytes = assertion.getBytes(StandardCharsets.UTF_8);
                signature.update(dataInBytes);
                //sign the assertion and return the signature
                byte[] signedAssertion = signature.sign();
                String base64UrlEncodedAssertion = Base64.getUrlEncoder().encodeToString(signedAssertion);
                String token = base64UrlEncodedHeader + '.' + base64UrlEncodedBody + '.' + base64UrlEncodedAssertion;
                tokensWriter.write(token);
                tokensWriter.newLine();
                standardOutput.print("Generated " + i + " tokens.    \r");
            }
        } catch (IOException e) {
            errorOutput.println(e.getMessage());
        }
        long elapsed = System.nanoTime() - startTime;
        // Add whitespace to clear progress information
        standardOutput.format("Done in %d min, %d sec.                           %n",
                TimeUnit.NANOSECONDS.toMinutes(elapsed),
                TimeUnit.NANOSECONDS.toSeconds(elapsed) -
                        TimeUnit.MINUTES.toSeconds(TimeUnit.NANOSECONDS.toMinutes(elapsed)));
    }
}
