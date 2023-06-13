#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Power Menu
#
## Available Styles
#
## style-1   style-2   style-3   style-4   style-5

# Current Theme
dir="$HOME/.config/rofi/powermenu"
theme='powermenu'

# CMDs
uptime="`uptime -p | sed -e 's/up //g'`"
host=`hostname`

# Options
shutdown=''
reboot=''
lock=''
suspend=''
logout=''
yes=''
no=''

# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
		-p "Uptime: $uptime" \
		-mesg "Uptime: $uptime" \
		-theme ${dir}/${theme}.rasi
}

# Confirmation CMD
confirm_cmd() {
	rofi -dmenu \
		-p 'Confirmation' \
		-mesg 'Are you Sure?' \
		-theme ${dir}/shared/confirm.rasi
}

# Ask for confirmation
confirm_exit() {
	echo -e "$yes\n$no" | confirm_cmd
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

# Execute Command
run_cmd() {
#	selected="$(confirm_exit)"
#	if [[ "$selected" == "$yes" ]]; then
		if [[ $1 == '--shutdown' ]]; then
			systemctl poweroff
		elif [[ $1 == '--reboot' ]]; then
			systemctl reboot
		elif [[ $1 == '--suspend' ]]; then
			playerctl -a pause
			amixer set Master mute
			systemctl suspend
		elif [[ $1 == '--lock' ]]; then
			if [[ "$DESKTOP_SESSION" == 'sway' ]]; then
				swaylock
			elif [[ "$DESKTOP_SESSION" == 'i3' ]]; then
				~/.config/i3/scripts/lock.sh
			fi
		elif [[ $1 == '--logout' ]]; then
			if [[ "$DESKTOP_SESSION" == 'sway' ]]; then
				swaymsg exit
			elif [[ "$DESKTOP_SESSION" == 'i3' ]]; then
				i3-msg exit
			elif [[ "$DESKTOP_SESSION" == 'plasma' ]]; then
				qdbus org.kde.ksmserver /KSMServer logout 0 0 0
			fi
		fi
#	else
#		exit 0
#	fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $lock)		run_cmd --lock		;;
    $suspend)	run_cmd --suspend	;;
    $logout)	run_cmd --logout	;;
    $reboot)	run_cmd --reboot	;;
    $shutdown)	run_cmd --shutdown	;;
esac
