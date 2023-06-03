#!/bin/bash
# src: https://www.2daygeek.com/linux-low-full-charging-discharging-battery-notification/

while true; do
	battery_level=$(acpi -b | grep -P -o '[0-9]+(?=%)')
	discharging=$(acpi | grep -o Discharging) # Text Discharging is returned if discharging.
	# echo $discharging
	MINIMUM_LEVEL=14
	MAXIMUM_LEVEL=85

	# if [ -z $discharging ]; then echo "Battery is charging"; fi
	# if [ $discharging ]; then echo "Battery is discharging"; fi

	# If batter is greater than `MAXIMUM_LEVEL` and battery is charging (-z $discharging) then alert the user
	if [ $battery_level -ge $MAXIMUM_LEVEL ] && [ -z $discharging ]; then
		notify-send --urgency=CRITICAL "Battery Full - ${battery_level}%" "Please unplug the charger.\n\nHave a nice day!"
		# for i in {1..2}; do $(dirname $0)/beepSound.sh; done
		# better vv
		# for i in {1..2}; do paplay /usr/share/sounds/freedesktop/stereo/bell.oga; done
		# Below one is even better:
		# paplay /home/array/scripts-media/Sounds/7_unplug-charger.wav
		# Using `cvlc`
		cvlc --play-and-exit /home/array/scripts-media/Sounds/7_unplug-charger.wav
		# List all sounds:
		# ls /usr/share/sounds/freedesktop/stereo
		# paplay /usr/share/sounds/freedesktop/stereo/bell.oga
		# paplay /usr/share/sounds/freedesktop/stereo/suspend-error.oga
		# Sleep for some time:
		sleep 600
	elif [ $battery_level -le 20 ] && [ $discharging ]; then
		# echo batttery less than 20... testing only...
		# LOG:01: This code only executed if battery is discharging ( not plugged in).
		notify-send --urgency=CRITICAL "Battery Low" "Level: ${battery_level}%"
		for i in {1..3}; do $(dirname $0)/beepSound.sh; done
		# paplay /usr/share/sounds/freedesktop/stereo/suspend-error.oga
		# LOG:01: This code only executed if battery is discharging ( not plugged in).
		# Hibernate if battery drops below `MINIMUM_LEVEL`.
		if [ $battery_level -le $MINIMUM_LEVEL ]; then systemctl hibernate; fi
	else
		echo "
LOG - HAPPY TIME
1. Less than $MINIMUM_LEVEL percent and charging.
2. Between $MINIMUM_LEVEL and $MAXIMUM_LEVEL percent.
3. More than $MAXIMUM_LEVEL and discharging.
"
	fi
	echo "LOG - Sleeping for 1 minute."
	sleep 60
done
