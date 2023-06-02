#!/bin/bash
cd "$(dirname "$0")"
cpuLoadInPercentage=$(top -bn1 | awk '/%Cpu/ { printf("%.2f%%", 100 - $8) }')
bash ../publish_mqtt_message.sh "logging/cpuLoad" "$cpuLoadInPercentage"
