#!/bin/bash

bash sub_mqtt_topic.sh +/sensor/soilmoisture -v | ./humidity_control_pump/last_watering.sh
