#!/bin/bash

bash ./sub_mqtt_topic.sh +/alarm/+ -v | while read -r message; do
	IFS=" " read -ra topic_payload <<< "$message"

	IFS="/" read -ra split_topic <<< "${topic_payload[0]}"
	alarm=${topic_payload[1]}
	id=${split_topic[0]}

       if [ "$alarm" = "1" ]; then
		file=./alarm/status/${id}.txt
		echo "$alarm" > "$file"
	fi 
done
