#!/bin/bash

serialnumber=$(cat serialport/SerialNumber.txt)

cat /dev/ttyACM0 | while read -r line; do
    IFS=',' read -ra values <<< "$line"
    plant_water_alarm="${values[0]}"
    pump_water_alarm="${values[1]}"
    soil_moisture="${values[2]}"
    ambient_light="${values[3]}"
	
echo $line
   if [ -z "$plant_water_alarm" ] || [ -z "plant_water_alarm" ] || [ -z "$pump_water_alarm" ]; then
	continue 1
   fi

    bash publish_mqtt_message.sh "$serialnumber/alarm/plantwater" "$plant_water_alarm"
    bash publish_mqtt_message.sh "$serialnumber/alarm/pumpwater" "$pump_water_alarm"
    bash publish_mqtt_message.sh "$serialnumber/sensor/soilmoisture" "$soil_moisture"
    bash publish_mqtt_message.sh "$serialnumber/sensor/ambientlight" "$ambient_light"

    if [ "$plant_water_alarm" -eq "1" ] || [ "$pump_water_alarm" -eq "1" ]; then
		bash ./set_led.sh red
		continue 1
    fi
	
    no_errors=0
    file=./alarm/status/${serialnumber}.txt
    echo "$no_errors" > "$file"

    if [ "$soil_moisture" -lt "20" ]; then
	bash ./set_led.sh yellow
	continue 1
    fi

    bash ./set_led.sh green
    sleep 4
done
#< < (cat /dev/ttyACM0)
