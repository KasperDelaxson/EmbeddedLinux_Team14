#!/bin/bash

topic=$1
with_topic=${2:-""}
mosquitto_sub -h localhost -p 1883 -u my_user -P my_password -t "$topic" $with_topic
