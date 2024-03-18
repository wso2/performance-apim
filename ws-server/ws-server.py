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

import tornado.httpserver
import tornado.websocket
import tornado.ioloop
import tornado.web
import socket
'''
This is a simple Websocket Echo server that uses the Tornado websocket handler.
Please run `pip install tornado` with python of version 2.7.9 or greater to install tornado.
This program will echo back the reverse of whatever it recieves.
Messages are output to the terminal for debuggin purposes. 
''' 
connections_count = 0
messages_received = 0
messages_sent = 0

class WSHandler(tornado.websocket.WebSocketHandler):

    def open(self):
        global connections_count
        global messages_received
        global messages_sent
        connections_count += 1
        print ('Event: open , Connections: ', connections_count, ' , MessagesReceived: ', messages_received, ' , MessagesSent: ', messages_sent)
      
    def on_message(self, message):
        global connections_count
        global messages_received
        global messages_sent
        messages_received += 1
        print ('Event: on_message , Connections: ', connections_count, ' , MessagesReceived: ', messages_received, ' , MessagesSent: ', messages_sent)
        # Reverse Message and send it back
        self.write_message(message[::-1])
        messages_sent += 1
        
    def on_close(self):
        global connections_count
        global messages_received
        global messages_sent
        connections_count -= 1
        print ('Event: close , Connections: ', connections_count, ' , MessagesReceived: ', messages_received, ' , MessagesSent: ', messages_sent)
 
    def check_origin(self, origin):
        return True
 
application = tornado.web.Application([
    (r'/ws', WSHandler),
])
 
 
if __name__ == "__main__":
    http_server = tornado.httpserver.HTTPServer(application)
    http_server.listen(8888)
    myIP = socket.gethostbyname(socket.gethostname())
    print ('*** Websocket Server Started at ***' ,myIP)
    tornado.ioloop.IOLoop.instance().start()
