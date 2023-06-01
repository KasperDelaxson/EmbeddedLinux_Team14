#!/bin/bash
#stty -F /dev/ttyACM0 115200 -ixon -ixoff

bash ./sub_mqtt_topic.sh +/pump -v | while read -r message; do
	IFS=" " read -ra topic_payload <<< "$message"

	IFS="/" read -ra split_topic <<< "${topic_payload[0]}"

	humidity=${topic_payload[1]}
	id=${split_topic[0]}
	file=./alarm/status/$id.txt
	status=$(cat "${file}")

	if [ "$status" = "0" ]; then
    		echo p > /dev/ttyACM0
		current_timestamp=$(date +%s)
		file=./humidity_control_pump/water_timestamps/last_water_${id}.txt
		bash publish_mqtt_message.sh "$id/pump/activation" "$current_timestamp"
		echo "$current_timestamp" > "${file}"
	fi
done
