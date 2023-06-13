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

echo 'Created resource pack template for Minecraft 1.18'
echo "If you want to use this pack for different version you should manually edit file $pack/pack.mcmeta"
echo "Edit 'pack_format' property, you should replace digit that relates to suitable minecraft version."
echo
echo "Version of Minecraft : Code"
echo "1.6.1-1.8.9		1"
echo "1.9-1.10.2		2"
echo "1.11-1.12.2		3"
echo "1.13-1.14.4		4"
echo "1.15-1.16.1		5"
echo "1.16.2-1.16.5		6"
echo "1.17-1.17.1		7"
echo "1.18			8"
