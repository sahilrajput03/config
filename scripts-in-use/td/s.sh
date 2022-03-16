#!/bin/bash

source /home/array/.bash_aliases
source /home/array/.bash_functions
shopt -s expand_aliases

ln=$(grep -n '\-\-\-' $(dirname $0)/must-can | sed -E 's/:.+//')		# Line number at which ---	
lines=$(wc -l $(dirname $0)/must-can |  awk '{print $1}')				# Total lines
# FYI: For randomization, shuf is built in purmutation utility tool in linux.
# Source: https://stackoverflow.com/a/15065490/10012446

# Deleting first line with sed, ```sed '1d'```
# Source: https://unix.stackexchange.com/a/55757/504112

# Delete any line that starts with //
# cat file.txt | sed '/^\/\/.*/d'

# DEBUG
# echo $out
# echo out: $out
# echo --- $ln
# echo total_lines: $lines

# must_do=$(head -n $((ln-1)) must-can)
# can_do=$(tail -n $((lines-ln)) must-can)

# FOR TOGGLING RANDOM (COMMENT UNCOMMENT BELOW)
MAX_MUST=2
MIN_MUST=2
#
MAX_CAN=1
MIN_CAN=1
#
must_count=$(shuf -i $MIN_MUST-$MAX_MUST -n 1)
can_count=$(shuf -i $MIN_CAN-$MAX_CAN -n 1)
#
common() {

	# Remove first line and // comments
	sed '1d' | sed '/^\/\/.*/d' | sed '/- !/d'
	# remove first line, remove // lines, remove line with `- !`
}
must_do=$(head -n $((ln-1)) "$(dirname $0)/must-can" | common | shuf -n $must_count )
can_do=$(tail -n $((lines-ln)) "$(dirname $0)/must-can" | common | shuf -n $can_count)

cecho "Must do" 2
cecho "$must_do" 2
echo
cecho "Can do" 3
cecho "$can_do" 3

