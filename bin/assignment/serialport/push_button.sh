#!/bin/bash
serialnumber=$(cat serialport/SerialNumber.txt)
while true; do
button_count=$(curl -s http://192.168.10.222/button/a/count)
echo $button_count
if [[ $button_count -eq 2 ]]; then
  bash publish_mqtt_message.sh "$serialnumber/pump" "p"
  button_count=0
fi
sleep 2
done
