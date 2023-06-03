# Print process_id of a process with name `battery-status.sh`
# pgrep -f battery-status.sh

echo @off

if [ -n "$(pgrep -f battery-status.sh)" ]; then
	#notify-send "battery-status servce already running..."
	echo "SERVICE IS ALREADY RUNNING."
else
	echo "STARTING SCRIPT - battery-status.sh"
	sh $(dirname $0)/battery-status.sh &
fi
