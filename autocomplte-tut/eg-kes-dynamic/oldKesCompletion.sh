#/usr/bin/env bash

# dynamic
_kes_dynamic()
{
	echo -e "\n 0 $0, 1 $1, 2 $2, 3 $3, 4 $4"
	# fyi: $0 IS ALWAYS `-bash` or `bash`
	# echo -e "\n ARGS(received): $@"

	if [[ $3 = "-c" ]]; then
		# GETTING CONTAINER NAME COMPLETION
		# echo entered here...
		podName=$(cat /tmp/cache-pod-name)
		# echo $podName
		# relatedContainers=$(kc get po $podName -o jsonpath="{.spec.containers[*].name}")
		set -x
		relatedContainers=$(kc get po $podName -o jsonpath="{.spec.containers[*].name}" | sed 's/ /\n/g' | grep ^$2)
		# with sed i am conveting text like "nats reloader metrics" to three lines having each work in its own line.
		# echo conts: $relatedContainers
		for n in $relatedContainers; do
			COMPREPLY+=("$n")
		done
	elif [[ $2 = "-c" ]]; then
		COMPREPLY=("-c")
		return
	else
		# GETTING POD NAME COMPLETION
		items=$(kc get po | tail -n+2 | awk '{print $1}' | grep ^$2)
		# `tail -n+2` means start from line 2 till end of file.
		# With grep ^$2 I am filtering results that matches with the arguments passed while autocompletion and grep ^$2 is ignored when there's no such argument, yikes!

		for n in $items; do
			COMPREPLY+=("$n")
		done

		# This will help us track the pod name we are dealing with when we wanna get container name of pod.
		echo $items > /tmp/cache-pod-name
	fi
}

complete -F _kes_dynamic kes
#### FYI: 
# 1. CODE FOR KES IS DEFINED IN ~/.BASH_ALIASES FILE AREADY.
# kes(){
# 	# kes is autocompleted with my custom made autocompletion script.
# 	echo +kc exec -it "$@" -- sh
# 	kc exec -it "$@" -- sh
# }

# 2. If you only want to test, you can test autocompletion via `./kes` script execution as well.


##### NOTES: Only $1, $2 and $3 are provided in the function no matter how many arguments you have during autocompletion), src: https://www.gnu.org/software/bash/manual/html_node/Programmable-Completion-Builtins.html#Programmable-Completion-Builtins
# dothis <TAB>
# OUTPUT: 1 dothis, 2 , 3 dothis
#
# dothis carbo <TAB>
# OUTPUT: 1 dothis, 2 carbo, 3 dothis
#
# dothis car bike
# OUTPUT: 1 dothis, 2 bike, 3 car
#
# dothis car bike scooter
# OUTPUT: 1 dothis, 2 scooter, 3 bike
#
# dothis car bike scooter activa
# OUTPUT: 1 dothis, 2 activa, 3 scooter
