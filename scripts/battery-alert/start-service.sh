# Print process_id of a process with name `battery-status.sh`
# pgrep -f battery-status.sh

echo @off

if [ -n "$(pgrep -f battery-status.sh)" ]; then
      	#notify-send "battery-status servce already running..."
	echo Yes running already, so no need to run again.;
else
	echo Not running so running battery-status script now..;
	sh $(dirname $0)/battery-status.sh &
fi

