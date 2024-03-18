/**
# Copyright 2024 WSO2 LLC. (http://wso2.org)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
**/
package custom.client;

import org.java_websocket.client.WebSocketClient;
import org.java_websocket.handshake.ServerHandshake;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.concurrent.BrokenBarrierException;
import java.util.concurrent.CyclicBarrier;
import java.util.concurrent.atomic.AtomicInteger;

public class Main {
    public static void main(String[] args) throws Exception {
        int noOfThreads = Integer.parseInt(args[0]);
        int eventsPerSecond = Integer.parseInt(args[1]);
        long runForMillis = Long.parseLong(args[2]);

        String url = args[3];
        String message = args[4];
        String token = args[5];

        System.out.println("No. of threads: " + noOfThreads);
        System.out.println("EventsPerSecond: " + eventsPerSecond);
        System.out.println("RunForMillis: " + runForMillis);
        System.out.println("Message: " + message);
        System.out.println("URL: " + url);
        System.out.println("=====================================");

        final CyclicBarrier simulationStartBarrier = new CyclicBarrier(noOfThreads + 1);
        final CyclicBarrier postProcessBarrier = new CyclicBarrier(noOfThreads + 1);

        List<Simulator> simulators = new ArrayList<Simulator>(noOfThreads);

        AtomicInteger connections = new AtomicInteger(0);

        for (int i = 0; i < noOfThreads; i++) {
            final Simulator simulator =  new Simulator(new URI(url),
                    Collections.singletonMap("Authorization", "Bearer " + token),
                    eventsPerSecond,
                    runForMillis,
                    message,
                    connections);
            simulators.add(simulator);

            Thread thread = new Thread() {
                @Override
                public void run() {
                    try {
                        simulator.connect();
                        Thread.sleep(5000L);
                        simulationStartBarrier.await(); // Wait until all simulator threads have finished connecting
                        try {
                            simulator.simulate();
                        } catch (Exception e) {
                            // Absorb
                        }
                        postProcessBarrier.await();
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    } catch (BrokenBarrierException e) {
                        e.printStackTrace();
                    }
                }
            };
            thread.start();
        }

        simulationStartBarrier.await();
        System.out.println("[TEST STARTED]");

        postProcessBarrier.await();
        int totalSent = 0;
        int totalReceived = 0;
        int totalReceivedErrors = 0;

        for (Simulator simulator : simulators) {
            totalSent += simulator.getSent().get();
            totalReceived += simulator.getReceived().get();
            totalReceivedErrors += simulator.getReceivedErrors().get();
        }

        System.out.println("[TEST ENDED] ===================");
        System.out.println("No. of threads: " + noOfThreads);
        System.out.println("EventsPerSecond: " + eventsPerSecond);
        System.out.println("RunForMillis: " + runForMillis);
        System.out.println("Total connections made: " + connections.get());
        System.out.println("Total sent: " + totalSent);
        System.out.println("Total received: " + totalReceived);
        System.out.println("Total received onErrors: " + totalReceivedErrors);

    }
}
