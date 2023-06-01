#!/bin/bash

topic=$1
message=$2
qos=${3:-2}

mosquitto_pub -h localhost -p 1883 -u my_user -P my_password -t "$topic" -m "$message" -q $qos
