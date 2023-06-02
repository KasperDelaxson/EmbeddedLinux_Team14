#!/bin/bash
cd "$(dirname "$0")"
cpuTemperatureInDegreeCelcius=$(vcgencmd measure_temp | awk -F "=" '{print $2}' | awk -F "'" '{print $1}' | awk '{printf "%.1f°C", $0}')
bash ../publish_mqtt_message.sh "logging/cpuTemperature" "$cpuTemperatureInDegreeCelcius"
