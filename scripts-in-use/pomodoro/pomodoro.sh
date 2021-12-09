#!/bin/bash
script_path=$(dirname $0) # This gives me the path of the this script's folder. Yo!
_t=25		#DEFAULT=25 (i.e., 25 minutes duration of a  pomodoro)
min=60		#DEFAULT 60 (i.e., 1m=60secs)

_short=5	#DEFAULT=5 (i.e., 5 mins of break time in between pomodoros )
_br=30		#DEFAULT=30 (i.e., 30 mins of large break after 4 rounds of pomodoros)
rounds=5	#DEFAULT is 5 (i.e., 4 rounds)

p=1
clear

while (( p < rounds )) 
do 
	t=_t #Simply copying coz later we need to again on each loop.
	while (( t > 0 ))
	do
		
		#echo DEBUG: value of p is $p
		t=$((t-1))
		echo
		echo ":: Started Pomodoro Session (${rounds}x${_t} minutes)::"
		echo
		echo Active Pomodoro:  $p/4 pomodoros
		echo
		echo $t minutes left
		sleep $min
		clear
	done

	short=$_short
	p=$((p+1)) 

	if (( p < 5 )) #We skip running the break in the end of round 4.
	then
		vlc $script_path/5_minutes_break_music.mp4 > /dev/null 2>&1 &
		#google-chrome-stable https://www.youtube.com/watch?v=aynkFJdXF_M > /dev/null 2>&1

		# Adding 5 min break here
		while (( short > 0 ))
		do
			echo
			echo "Enjoy your day by simply enjoying your break, $short minutes left."
			short=$((short-1))
			sleep $min
			clear

		done
	fi

done


br=_br
vlc $script_path/30_minutes_break_music.mp4 > /dev/null 2>&1 &
while (( br > 0 ))
do
	clear
	echo
	echo Thanks for this session. Congratulations Sahil Rajput.
	echo 
	echo NOW is the time for a MASSIVE BREAK of $_br minutes.
	echo
	echo I hope it was awesome for you to work like that.
	echo Scientific research says its best way be
	echo effective while studying! 
	echo
	echo Hurray !!
	echo
	echo $br minutes left
	br=$(( br -1 ))
	sleep $min
done

# NOTES:
### THE PROCES IS LIKE THIS: ###

#((25 mins timer, after that
#, play 5 mins music for 5 mins))


#((25 mins timer, after that
#, play 5 mins music for 5 mins))


#((25 mins timer, after that
#, play 5 mins music for 5 mins))

#((25 mins timer, after that
#, play 25 mins music for 25 mins and congratulates.))
