#/bin/sh

kdeconnect-cli --refresh

case "$1" in 
	-f|--file)
		files=$(zenity --file-selection --multiple)
		for file in ${files//|/ }; do
			kdeconnect-cli -d $(kdeconnect-cli -a --id-only) --share $file
		done
		;;
	-s|--screenshot) 
		rm /tmp/tmp.png
		flameshot gui -p /tmp/tmp.png
		kdeconnect-cli -d $(kdeconnect-cli -a --id-only) --share /tmp/tmp.png
		;;
	-c|--clipboard) 
		kdeconnect-cli -d $(kdeconnect-cli -a --id-only) --share-text "$(xclip -o)"
		;;
    *) echo " Wrong argument.
    -f|--file: send file
    -s|--screenshot: send screenshot
    -c|--clipboard: send clipboard"
	;;
esac

