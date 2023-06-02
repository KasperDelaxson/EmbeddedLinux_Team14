#!/bin/bash
while true; do

read input

IFS=" " read -ra topic_payload <<< "$input"

IFS="/" read -ra split_topic <<< "${topic_payload[0]}"

humidity=${topic_payload[1]}
id=${split_topic[0]}

re='^[0-9]+$'
if ! [[ $humidity =~ $re ]] ; then
   continue 1
fi

if [ "20" -lt "${humidity}" ]; then
	echo 0
	continue 1
fi

file=./humidity_control_pump/water_timestamps/last_water_${id}.txt

if [ -f "${file}" ]; then
    last_water=$(cat "${file}")
else
    last_water=0
fi

current_timestamp=$(date +%s)
time_difference=$((current_timestamp - last_water))

if [ "$time_difference" -gt 3600 ]; then
    echo "publish"
    bash publish_mqtt_message.sh "${id}/pump" p
    continue 1
fi

echo "pump started within the hour"
done
