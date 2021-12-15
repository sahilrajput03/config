#!/bin/bash
# src: https://www.2daygeek.com/linux-low-full-charging-discharging-battery-notification/

while true
do
	battery_level=`acpi -b | grep -P -o '[0-9]+(?=%)'`
	discharging=`acpi | grep -o Discharging` # Text Discharging is returned if discharging.
	# if [ $c1 ]; then echo Yes charging; fi
	if [ $battery_level -ge 95 ]; then
		echo 'yoyoy'
		notify-send "Battery Full - ${battery_level}%" "Please unplug the charger.\n\nHave a nice day!"
      		paplay /usr/share/sounds/freedesktop/stereo/suspend-error.oga
		sleep 660 # i.e., sleep for 11 mins.
	elif [ $battery_level -le 40 ] && [ $discharging ]; then
      		notify-send --urgency=CRITICAL "Battery Low" "Level: ${battery_level}%"
      		paplay /usr/share/sounds/freedesktop/stereo/suspend-error.oga
	else
		echo "Battery is less than 20 percent but its plugged in...!"
	fi
	sleep 60
	done
