#!/bin/bash
# src: https://www.youtube.com/watch?v=vhTI0Sl7m8Y
# IMAGE is the archlock that you can set on your own!
IMAGE=~/.config/i3/i3lock_temp/arch_lock.png
IMAGE1=~/.config/i3/i3lock_temp/i3lock1.png
IMAGE2=~/.config/i3/i3lock_temp/i3lock2.png
IMAGE3=~/.config/i3/i3lock_temp/i3lock3.png

# Get the screenshot, add the blur and lock the screen with it
scrot $IMAGE1

# Set brightness and contrast
convert -brightness-contrast -30x-50 $IMAGE1 $IMAGE1

# Add Gaussian blur and re-scale image
convert -filter Gaussian -resize 25% -resize 400% $IMAGE1 $IMAGE1
# convert -filter Gaussian -resize 50% -resize 200% $IMAGE1 $IMAGE1

# crop image to two parts, monitor 1 & 2
# for first monitor of resolution 1920x1080 ~ Sahil
convert $IMAGE1 -crop 1920x1080+0+0 $IMAGE2
composite -gravity center $IMAGE $IMAGE2 $IMAGE2

# for second monitor of resolution 1360x768 ~ Sahil
convert $IMAGE1 -crop 1360x768+1920+0 $IMAGE3
composite -gravity center $IMAGE $IMAGE3 $IMAGE3

convert $IMAGE2 $IMAGE3 +append $IMAGE1

i3lock -i $IMAGE1

# Removing files is necessary else causes undesirable errors
rm $IMAGE1 $IMAGE2 $IMAGE3


##### others ####

# ~Sahil
# CONVERT any image to desired resolution by simple resizing!
# convert -filter Gaussian -resize 25% $IMAGE1 $IMAGE1
