#!/usr/bin/env bash

case "$1" in
    logout)
        i3-msg exit
        ;;
    suspend)
        systemctl suspend
        ;;
    reboot)
        systemctl reboot
        ;;
    shutdown)
        systemctl poweroff
        ;;
	lock)
		~/.config/i3/bin/lock.sh
		;;
    *)
        echo "Usage: $0 [lock|logout|suspend|reboot|shutdown]"
        exit 2
esac

exit 0
