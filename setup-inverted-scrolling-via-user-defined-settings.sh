#!/bin/bash
# I am using this way coz the file @ /etc/X11/xorg.conf.d/00-keyboard.conf should not be updated by newer installation via ```sudo pacman -SyyU``` commands, so you won't need to refix the natural scrolling after os update, hopefully.
cp X11/40-libinput.conf /etc/X11/xorg.conf.d/
# Date: 1 feb, 2022.
