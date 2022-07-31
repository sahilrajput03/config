#!/bin/bash
if [ -n "$(pgrep -f battery-status)" ]; then
	# IN ABOVE INSTRUCTION: -n means non-zero length string
	pkill -ef battery-status
	# -e means echo what processes are killed
else
	echo PROCESS NOT FOUND
fi

