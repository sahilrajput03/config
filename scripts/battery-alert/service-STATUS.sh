#!/bin/bash
if [ -n "$(pgrep -f battery-status.sh)" ]; then
	# IN ABOVE INSTRUCTION: -n means non-zero length string
	pgrep -f battery-status.sh
	echo Process *ALREAY* running
else
	echo PROCESS NOT FOUND
fi

