#!/bin/bash
# src: https://www.2daygeek.com/linux-low-full-charging-discharging-battery-notification/
while true
do
	battery_level=`acpi -b | grep -P -o '[0-9]+(?=%)'`
	discharging=`acpi | grep -o Discharging` # Text Discharging is returned if discharging.
	# if [ $c1 ]; then echo Yes charging; fi

	if [ $battery_level -ge 95 ]; then
		notify-send "Battery Full - ${battery_level}%" "Please unplug the charger.\n\nHave a nice day!"
		# for i in {1..2}; do $(dirname $0)/beepSound.sh; done
		for i in {1..2}; do paplay /usr/share/sounds/freedesktop/stereo/bell.oga; done
			# List all sounds:
			# ls /usr/share/sounds/freedesktop/stereo
			# paplay /usr/share/sounds/freedesktop/stereo/bell.oga
      		# paplay /usr/share/sounds/freedesktop/stereo/suspend-error.oga
		sleep 660 # i.e., sleep for 11 mins.
	elif [ $battery_level -le 20 ] && [ $discharging ]; then
		# echo batttery less than 20... testing only...
		# LOG:01: This code only executed if battery is discharging ( not plugged in).
      		notify-send --urgency=CRITICAL "Battery Low" "Level: ${battery_level}%"
			for i in {1..3}; do $(dirname $0)/beepSound.sh; done
      		# paplay /usr/share/sounds/freedesktop/stereo/suspend-error.oga
			# LOG:01: This code only executed if battery is discharging ( not plugged in).
			# Hibernate if battery drops 14%.
			if [ $battery_level -le 14 ] ; then
				systemctl hibernate
			fi
	else
		echo "::Nothing to do because either battery percentage is
1. less than 20 percent but its plugged in...!
2. between 20 and 95 percent."
	fi
	echo ::Sleeping for 1 minute.
	sleep 60
	done
