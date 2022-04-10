#/usr/bin/env bash
complete -W "$(kc get po | tail -n+2 | awk '{print $1}')" kes
# we used the -W (wordlist) option to provide a list of words for completion.
