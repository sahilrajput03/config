#!/bin/bash
# src: https://www.2daygeek.com/linux-low-full-charging-discharging-battery-notification/

MINIMUM_LEVEL=14
MAXIMUM_LEVEL=85

while true; do
	battery_level=$(acpi -b | grep -P -o '[0-9]+(?=%)')
	discharging=$(acpi | grep -o Discharging) # Text Discharging is returned if discharging.
	# echo $discharging # "Discharging"

	if [ $battery_level -ge $MAXIMUM_LEVEL ] && [ -z $discharging ]; then
		# Battery is greater than `MAXIMUM_LEVEL` and charging (-z $discharging)
		notify-send --urgency=CRITICAL "Battery Full - ${battery_level}%" "Please unplug the charger.\n\nHave a nice day!"
		cvlc --play-and-exit /home/array/scripts-media/Sounds/7_unplug-charger.wav
		# Sleep for some time:
		sleep 600
	elif [ $battery_level -le 20 ] && [ $discharging ]; then
		# Battery is discharging
		notify-send --urgency=CRITICAL "Battery Low" "Level: ${battery_level}%"
		for i in {1..3}; do $(dirname $0)/beepSound.sh; done
		# Hibernate when battery drops below `MINIMUM_LEVEL`.
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

# NOTES -

# Helful Logs to check charging and discharging
# if [ -z $discharging ]; then echo "Battery is charging"; fi
# if [ $discharging ]; then echo "Battery is discharging"; fi

# Sounds and `paplay` usage -
# for i in {1..2}; do $(dirname $0)/beepSound.sh; done
# for i in {1..2}; do paplay /usr/share/sounds/freedesktop/stereo/bell.oga; done
# paplay /home/array/scripts-media/Sounds/7_unplug-charger.wav

# List all sounds:
# ls /usr/share/sounds/freedesktop/stereo
# paplay /usr/share/sounds/freedesktop/stereo/bell.oga
# paplay /usr/share/sounds/freedesktop/stereo/suspend-error.oga
