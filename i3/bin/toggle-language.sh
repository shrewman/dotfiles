#!/bin/sh

setxkbmap -query | grep "us,ru"
if [ $? -eq 0 ]; then
	setxkbmap -layout us,ua -option grp:alt_shift_toggle,caps:escape
else 
	setxkbmap -layout us,ru -option grp:alt_shift_toggle,caps:escape
fi
