#!/bin/bash
serialnumber=$(< serialport/SerialNumber.txt)
while true; do
    read line < /dev/ttyACM0
        echo $line
    IFS=',' read -ra values <<< "$line"
    if [ "${#values[@]}" -lt 4 ]; then
        continue
    fi

    plant_water_alarm="${values[0]}"
    pump_water_alarm="${values[1]}"
    soil_moisture="${values[2]}"
    ambient_light="${values[3]}"

    if [ -z "$plant_water_alarm" ] || [ -z "$pump_water_alarm" ]; then
        continue
    fi

    bash publish_mqtt_message.sh "$serialnumber/alarm/plantwater" "$plant_water_alarm"
    bash publish_mqtt_message.sh "$serialnumber/alarm/pumpwater" "$pump_water_alarm"
    bash publish_mqtt_message.sh "$serialnumber/sensor/soilmoisture" "$soil_moisture"
    bash publish_mqtt_message.sh "$serialnumber/sensor/ambientlight" "$ambient_light"

    if [ "$plant_water_alarm" -eq "1" ] || [ "$pump_water_alarm" -eq "1" ]; then
        bash ./set_led.sh red
        continue
    fi

    no_errors=0
    file=./alarm/status/${serialnumber}.txt
    echo "$no_errors" > "$file"

    if [ "$soil_moisture" -lt "20" ]; then
        bash ./set_led.sh yellow
        continue
    fi

    bash ./set_led.sh green
    sleep 1
done
