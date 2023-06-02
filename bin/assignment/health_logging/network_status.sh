#!/bin/bash
cd "$(dirname "$0")"
wirelessStatus=$(iwconfig eth0 | awk '/ESSID/ { print $1, $4 }')
pingResult=$(ping -c 1 google.com | awk -F'/' 'END { print $5 " ms" }')

bash ../publish_mqtt_message.sh "logging/networkStatus" "Wireless Status: $wirelessStatus, Ping: $pingResult"
