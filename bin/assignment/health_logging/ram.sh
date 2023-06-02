#!/bin/bash
cd "$(dirname "$0")"
ramUsageInPercentage=$(free | awk '/^Mem/ { printf("%.2f%%", ($3 / $2) * 100) }')
bash ../publish_mqtt_message.sh "logging/ramUsage" "$ramUsageInPercentage"
