#!/bin/bash

serialnumber=$(cat serialport/SerialNumber.txt)
MQTT_TOPIC="$serialnumber/logs"

while true; do
    timestamp=$(date +%s%N)
    wireless_status=$(ifconfig wlan0)
    date_value=$(date "+%Y-%m-%d %H:%M:%S")
    network_info=$(iwconfig)
    network_devices=$(nmap -sn 192.168.10.1/24)
    ping_result=$(ping -c 4 google.com)
    memory_info=$(cat /proc/meminfo)
    disk_space=$(df -h /)
    usb_devices=$(lsusb)
    free_memory=$(free -h)
    cpu_temp=$(vcgencmd measure_temp)

    json_data="{\"$serialnumber\": { \
        \"\n topic\": \"$MQTT_TOPIC\", \
        \"data\": { \
            \"Wireless_Connection_Status\": \"$wireless_status\", \
            \"Date\": \"$date_value\", \
            \"Network_Information\": \"$network_info\", \
            \"Network_Devices\": \"$network_devices\", \
            \"Ping_Result\": \"$ping_result\", \
            \"Memory_Information\": \"$memory_info\", \
            \"Disk_Space\": \"$disk_space\", \
            \"USB_Devices\": \"$usb_devices\", \
            \"Free_Memory\": \"$free_memory\", \
            \"CPU_Temperature\": \"$cpu_temp\" \
        }, \
        \"timestamp\": \"$timestamp\" \
    }}"

    bash publish_mqtt_message.sh "$MQTT_TOPIC" "$json_data"

    sleep 60
done
