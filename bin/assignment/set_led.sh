#!/bin/bash

command=$1

states=("green" "yellow" "red")

set_led() {
        led=$1
        on=$2
        base_url="http://192.168.10.222/led/"
        case $led in
          red)
                url="${base_url}red/$on"
                ;;
          yellow)
                url="${base_url}yellow/$on"
                ;;
          green)
                url="${base_url}green/$on"
                ;;
          *)
                echo "Invalid command."
                ;;
        esac

        curl "$url" 
}

for state in "${states[@]}"
do
	if [ "$command" = "$state" ]; then
		set_led "$state" "on"
		continue
	fi

	set_led "$state" "off"
done
