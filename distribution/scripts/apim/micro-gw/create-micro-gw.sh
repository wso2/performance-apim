#!/usr/bin/expect
spawn micro-gw setup echo-mgw -a echo -v 1.0.0 -f
expect -exact "Enter Username:"
send -- "admin\r"
expect -exact "Enter Password for admin:"
send -- "admin\r"
expect -exact "Enter APIM base URL: \[https://localhost:9443/\]"
send -- "\r"
expect -exact "Enter Trust store location:"
send -- "\r"
expect -exact "Enter Trust store password:"
send -- "\r"
expect eof
