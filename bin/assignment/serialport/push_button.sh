#!/bin/bash
while true; do
serialnumber=$(cat serialport/SerialNumber.txt)
button_count=$(curl -s http://192.168.10.222/button/a/count)
message="$button_count"

if [[ $button_count -eq 2 ]]; then
  sleep 2

  new_button_count=$(curl -s http://192.168.10.222/button/a/count)

  if [[ $new_button_count -eq 0 ]]; then
    bash set_led.sh greenon
    bash publish_mqtt_message.sh "$serialnumber/sensor/pushbutton" "$message"
  fi
fi

sleep 1
bash set_led.sh greenoff
sleep 1
done
