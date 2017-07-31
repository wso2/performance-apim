#!/bin/bash
jvm_dir=""
for dir in /usr/lib/jvm/jdk1.8*; do
    [ -d "${dir}" ] && jvm_dir="${dir}" && break
done
export JAVA_HOME="${jvm_dir}"

if pgrep -f "carbon" > /dev/null; then
    echo "Shutting down APIM"
    $HOME/wso2am-2.1.0/bin/wso2server.sh stop
    sleep 30
fi

log_files=($HOME/wso2am-2.1.0/repository/logs/*)
if [ ${#log_files[@]} -gt 1 ]; then
    echo "Log files exists. Moving to /tmp"
    mv $HOME/wso2am-2.1.0/repository/logs/* /tmp/;
fi

echo "Setting Heap to 4GB"
export JVM_MEM_OPTS="-Xms4g -Xmx4g"

echo "Enabling GC Logs"
export JAVA_OPTS="-XX:+PrintGC -XX:+PrintGCDetails -XX:+PrintGCDateStamps -Xloggc:$CARBON_HOME/repository/logs/gc.log"

echo "Starting APIM"
$HOME/wso2am-2.1.0/bin/wso2server.sh start

sleep 120
