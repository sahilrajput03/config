#!/bin/bash
if [ -n "$(pgrep -f battery-status)" ]; then
	# IN ABOVE INSTRUCTION: -n means non-zero length string
	echo Process *ALREAY* running
else
	echo PROCESS NOT FOUND
fi

