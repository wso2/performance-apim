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
import org.json.JSONObject;

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
import java.util.Base64;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

/**
 * JWT Token Generator for Microgateway Performance Tests
 */
public class JWTGenerator {

    private static final String WSO2CARBON = "wso2carbon";
    private static final int VALIDITY_PERIOD = 3600 * 24 * 365;

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

        JSONObject head = new JSONObject();
        head.put("x5t", "NWQwOTRkMjA5OWFjNmU2NzBlNTM3ZDUwODUzYjYwZmJlZTNkZDA4ODU4ZTUwZGIwNmUyMmZmZTNhZDkyNjQ2ZA");
        head.put("kid", "NWQwOTRkMjA5OWFjNmU2NzBlNTM3ZDUwODUzYjYwZmJlZTNkZDA4ODU4ZTUwZGIwNmUyMmZmZTNhZDkyNjQ2ZA_RS256");
        head.put("alg", "RS256");
        head.put("typ", "at+jwt");
        
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
                jwtTokenInfo.put("aud", consumerKey);
                jwtTokenInfo.put("sub", "admin@carbon.super");
                jwtTokenInfo.put("scope", "am_application_scope default");
                jwtTokenInfo.put("iss", "https://localhost:9443/oauth2/token");
                jwtTokenInfo.put("keytype", "PRODUCTION");
                jwtTokenInfo.put("exp", (int) TimeUnit.MILLISECONDS.toSeconds(System.currentTimeMillis())
                        + VALIDITY_PERIOD);
                jwtTokenInfo.put("nbf", (int) TimeUnit.MILLISECONDS.toSeconds(System.currentTimeMillis()));        
                jwtTokenInfo.put("iat", (int) TimeUnit.MILLISECONDS.toSeconds(System.currentTimeMillis()));
                jwtTokenInfo.put("jti", UUID.randomUUID());
                jwtTokenInfo.put("azp", consumerKey);
                jwtTokenInfo.put("client_id", consumerKey);

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
