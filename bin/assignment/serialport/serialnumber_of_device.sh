#!/bin/bash
serial_numbers=""

usb_serials=$(sudo dmesg | grep "SerialNumber")

while IFS= read -r line; do
    if [[ $line =~ "usb 1-1.2" ]]; then
        usb1_2_serial=$(echo "$line" | awk -F'SerialNumber: ' '{print $2}')
    elif [[ $line =~ "usb 1-1.4" ]]; then
        usb1_4_serial=$(echo "$line" | awk -F'SerialNumber: ' '{print $2}')
    fi
done <<< "$usb_serials"

serial_numbers="${usb1_4_serial}${usb1_2_serial}"

echo "$serial_numbers" > ./serialport/SerialNumber.txt
