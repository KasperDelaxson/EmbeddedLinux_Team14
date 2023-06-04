#!/bin/bash
cd "$(dirname "$0")"
ethBytes=$(cat "/sys/class/net/eth0/statistics/rx_bytes")
bytesTransferred=$ethBytes
INTERFACE="eth0"

bash ../publish_mqtt_message.sh "logging/networkBytes" "$bytesTransferred"
