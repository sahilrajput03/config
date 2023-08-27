#!/bin/bash
# paplay "$(dirname $0)/beep-sound-8333.wav"

# Using vlc's cli
cvlc --play-and-exit "$(dirname $0)/beep-sound-8333.wav"
# for paplays's running via cronjob without error i fixed via: https://askubuntu.com/a/172888/702911 , just by adding ```autospawn = yes```
