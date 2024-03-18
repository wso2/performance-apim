
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
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;


public class Simulator extends WebSocketClient {

    private int eventsPerSecond;
    private long runForMillis;
    private String stringMessage;

    private AtomicInteger sent = new AtomicInteger(0);
    private AtomicInteger received = new AtomicInteger(0);
    private AtomicInteger receivedErrors = new AtomicInteger(0);

    private AtomicInteger connections;

    public AtomicInteger getSent() {
        return sent;
    }

    public AtomicInteger getReceived() {
        return received;
    }

    public AtomicInteger getReceivedErrors() {
        return receivedErrors;
    }

    public Simulator(URI serverUri, Map<String, String> httpHeaders, int eventsPerSecond, long runForMillis, String msg,
                     AtomicInteger connections) {
        super(serverUri, httpHeaders);
        this.eventsPerSecond = eventsPerSecond;
        this.runForMillis = runForMillis;
        this.stringMessage = msg;
        this.connections = connections;
    }

    public void onOpen(ServerHandshake serverHandshake) {
        connections.incrementAndGet();
    }

    public void simulate() {
        long elapsed  = 0L;
        while (elapsed < runForMillis) {
            processOneSecondBatch();
            elapsed += 1000L;
            if (elapsed % 10000 == 0) {
                System.out.println("[" + Thread.currentThread().getName() + "] " +
                        "Total messages sent: " + sent.get() +
                        ", received: " + received.get() +
                        ", Elapsed: " + elapsed + "(ms) out of " + runForMillis);
            }
        }
    }

    private void processOneSecondBatch() {
        long start = System.currentTimeMillis();
        for (int i = 0; i < eventsPerSecond; i++) {
            send(stringMessage);
            sent.incrementAndGet();
        }
        long end = System.currentTimeMillis();

        long duration = end - start;
        if (duration < 1000) {
            // Took less than 1 second. Sleep.
            long sleepDuration = 1000 - duration;
            try {
                Thread.sleep(sleepDuration);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        // else - Already late. Don't wait.
    }

    public void onMessage(String s) {
        received.incrementAndGet();
    }

    public void onClose(int i, String s, boolean b) {
        connections.decrementAndGet();
    }

    public void onError(Exception e) {
        receivedErrors.incrementAndGet();
    }
}
