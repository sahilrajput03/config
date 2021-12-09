#!/bin/bash
# src: https://www.2daygeek.com/linux-low-full-charging-discharging-battery-notification/

while true
do
	battery_level=`acpi -b | grep -P -o '[0-9]+(?=%)'`
	if [ $battery_level -ge 95 ]; then
		notify-send "Battery Full - ${battery_level}%" "Please unplug the charger.\n\nHave a nice day!"
      		paplay /usr/share/sounds/freedesktop/stereo/suspend-error.oga
		sleep 240 # i.e., sleep for 4 mins.
	elif [ $battery_level -le 20 ]; then
      		notify-send --urgency=CRITICAL "Battery Low" "Level: ${battery_level}%"
      		paplay /usr/share/sounds/freedesktop/stereo/suspend-error.oga
	fi
	sleep 60
	done
