#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
#sahil: ^ first check if file exist and only source if it does.
# below throw unnecessary logs to screen: FIX THAT FIRST USING WORKRAVE AS STARTUP SERVICE.
#/home/array/scripts-in-use/workrave.service &
# echo 
# echo Welcome to the abode of Sahil Rajput. Have a growing attitude today!
# echo from ~/.bash_profile
# echo
. "$HOME/.cargo/env"
