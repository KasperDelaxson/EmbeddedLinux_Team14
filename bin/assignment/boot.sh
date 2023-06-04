#!/bin/bash
cd "$(dirname "$0")"

stty -F /dev/ttyACM0 115200 -ixon -ixoff
bash ./serialport/serialport_publish_mqtt.sh &
bash ./humidity_listen_and_start_pump.sh &
bash ./start_pump.sh &
bash ./alarm/cancel_all.sh &
bash ./serialport/push_button.sh &
