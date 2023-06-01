#!/bin/bash
system_timezone=$(cat /etc/timezone)
export TZ="$system_timezone"
