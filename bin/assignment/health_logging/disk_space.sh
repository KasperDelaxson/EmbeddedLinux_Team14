#!/bin/bash
cd "$(dirname "$0")"
diskSpaceInPercentage=$(df -h / | awk 'NR==2{print $5}')
bash ../publish_mqtt_message.sh "logging/diskSpace" "$diskSpaceInPercentage"
