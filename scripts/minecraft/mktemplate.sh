#!/bin/bash

if [ $# -ne 2 ]; then
	echo "Format: mktemplate.sh pack_name path_to_icon"
	exit 1
fi

pack=$1
icon=$2

if [ -d "$pack" ]; then
	echo "Resource pack with this name already exists."
	exit 1
fi

if [ ! -f "$icon" ]; then
	echo "Icon file does not exists."
	exit 1
fi

mkdir -p "$pack"/assets/minecraft/sounds/records
cp "$icon" "$pack"/pack.png

echo "{
	\"pack\": {
		\"pack_format\": 8,
		\"description\": \"$pack\"
	}
}
" > "$pack"/pack.mcmeta

touch "$pack"/assets/minecraft/sounds/records/{11,13,blocks,cat,chirp,far,mall,mellohi,pigstep,stal,strad,wait,ward}.ogg
