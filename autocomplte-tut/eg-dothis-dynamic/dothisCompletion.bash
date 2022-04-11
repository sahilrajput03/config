#/usr/bin/env bash
# complete -W "now tomorrow never" dothis
# we used the -W (wordlist) option to provide a list of words for completion.

# dynamic
_dothis_completions()
{
	# echo -e "\n 0 $0, 1 $1, 2 $2, 3 $3, 4 $4"
	# fyi: $0 IS ALWAYS `-bash` or `bash`
	# echo -e "\n ARGS(received): $@"
  COMPREPLY+=("more")
  COMPREPLY+=("now")
  COMPREPLY+=("tomorrow")
  COMPREPLY+=("never")
}

complete -F _dothis_completions dothis

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
