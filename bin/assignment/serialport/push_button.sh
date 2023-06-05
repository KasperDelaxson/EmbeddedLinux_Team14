#!/bin/bash
serialnumber=$(cat serialport/SerialNumber.txt)
while true; do
  initial_count=$(curl -s http://192.168.10.222/button/a/count)

  if [[ $initial_count -eq 1 ]]; then
    sleep 2
    updated_count=$(curl -s http://192.168.10.222/button/a/count)
    if [[ $updated_count -eq 0 ]]; then
      bash publish_mqtt_message.sh "$serialnumber/pump" "p"
    fi
  fi
done


