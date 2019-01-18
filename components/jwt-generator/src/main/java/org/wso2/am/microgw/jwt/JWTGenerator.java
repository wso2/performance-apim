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
package org.wso2.am.microgw.jwt;

import com.beust.jcommander.JCommander;
import com.beust.jcommander.Parameter;
import org.json.JSONArray;
import org.json.JSONObject;
import org.wso2.am.microgw.jwt.model.API;
import org.wso2.am.microgw.jwt.model.ApplicationDTO;
import org.wso2.am.microgw.jwt.model.SubscribedApiDTO;

import java.io.File;
import java.io.FileInputStream;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.security.Key;
import java.security.KeyStore;
import java.security.PrivateKey;
import java.security.Signature;
import java.util.Arrays;
import java.util.Base64;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

/**
 * JWT Token Generator for Microgateway Performance Tests
 */
public class JWTGenerator {

    public static final String KEY_TYPE_PRODUCTION = "PRODUCTION";
    public static final String WSO2CARBON = "wso2carbon";
    public static final int VALIDITY_PERIOD = 3600 * 24 * 365;

    @Parameter(names = "--api-name", description = "API Name")
    private static String apiName;

    @Parameter(names = "--context", description = "API Context")
    private static String context;

    @Parameter(names = "--version", description = "API Version")
    private static String version;

    @Parameter(names = "--app-name", description = "Application Name")
    private static String appName;

    @Parameter(names = "--app-tier", description = "Application Tier")
    private static String appTier;

    @Parameter(names = "--subs-tier", description = "Subscription Tier")
    private static String subsTier;

    @Parameter(names = "--app-id", description = "Application ID")
    private static int appId;

    public static void main(String[] args) throws Exception {
        JWTGenerator jwtGenerator = new JWTGenerator();
        final JCommander jcmdr = new JCommander(jwtGenerator);
        jcmdr.setProgramName(JWTGenerator.class.getSimpleName());
        jcmdr.parse(args);

        ApplicationDTO application = new ApplicationDTO();
        application.setName(appName);
        application.setTier(appTier);
        application.setId(appId);

        API api = new API();
        api.setName(apiName);
        api.setContext(context);
        api.setVersion(version);
        String jwtTokenProd = jwtGenerator.getJWT(api, application, subsTier, KEY_TYPE_PRODUCTION, VALIDITY_PERIOD);
        System.out.println(jwtTokenProd);
    }

    protected String getJWT(API api, ApplicationDTO applicationDTO, String tier, String keyType, int validityPeriod)
            throws Exception {
        SubscribedApiDTO subscribedApiDTO = new SubscribedApiDTO();
        subscribedApiDTO.setContext("/" + api.getContext() + "/" + api.getVersion());
        subscribedApiDTO.setName(api.getName());
        subscribedApiDTO.setVersion(api.getVersion());
        subscribedApiDTO.setPublisher("admin");
        subscribedApiDTO.setSubscriptionTier(tier);
        subscribedApiDTO.setSubscriberTenantDomain("carbon.super");

        JSONObject jwtTokenInfo = new JSONObject();
        jwtTokenInfo.put("aud", "http://org.wso2.apimgt/gateway");
        jwtTokenInfo.put("sub", "admin");
        jwtTokenInfo.put("application", new JSONObject(applicationDTO));
        jwtTokenInfo.put("scope", "am_application_scope default");
        jwtTokenInfo.put("iss", "https://localhost:9443/oauth2/token");
        jwtTokenInfo.put("keytype", keyType);
        jwtTokenInfo.put("subscribedAPIs", new JSONArray(Arrays.asList(subscribedApiDTO)));
        jwtTokenInfo.put("exp", (int) TimeUnit.MILLISECONDS.toSeconds(System.currentTimeMillis()) + validityPeriod);
        jwtTokenInfo.put("iat", (int) TimeUnit.MILLISECONDS.toSeconds(System.currentTimeMillis()));
        jwtTokenInfo.put("jti", UUID.randomUUID());

        String payload = jwtTokenInfo.toString();

        JSONObject head = new JSONObject();
        head.put("typ", "JWT");
        head.put("alg", "RS256");
        head.put("x5t", "UB_BQy2HFV3EMTgq64Q-1VitYbE");
        String header = head.toString();

        String base64UrlEncodedHeader = Base64.getUrlEncoder()
                .encodeToString(header.getBytes(Charset.defaultCharset()));
        String base64UrlEncodedBody = Base64.getUrlEncoder().encodeToString(payload.getBytes(Charset.defaultCharset()));

        Signature signature = Signature.getInstance("SHA256withRSA");
        FileInputStream is = null;
        KeyStore keystore = null;
        try {
            is = new FileInputStream(new File("wso2carbon.jks"));
            keystore = KeyStore.getInstance(KeyStore.getDefaultType());
            keystore.load(is, WSO2CARBON.toCharArray());
        } finally {
            if (is != null) {
                is.close();
            }
        }
        String alias = WSO2CARBON;
        Key key = keystore.getKey(alias, WSO2CARBON.toCharArray());
        Key privateKey = null;
        if (key instanceof PrivateKey) {
            privateKey = key;
        }
        signature.initSign((PrivateKey) privateKey);
        String assertion = base64UrlEncodedHeader + "." + base64UrlEncodedBody;
        byte[] dataInBytes = assertion.getBytes(StandardCharsets.UTF_8);
        signature.update(dataInBytes);
        //sign the assertion and return the signature
        byte[] signedAssertion = signature.sign();
        String base64UrlEncodedAssertion = Base64.getUrlEncoder().encodeToString(signedAssertion);
        is.close();
        return base64UrlEncodedHeader + '.' + base64UrlEncodedBody + '.' + base64UrlEncodedAssertion;
    }
}
