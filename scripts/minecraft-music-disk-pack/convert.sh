#!/bin/bash

music_dir=$1
pack=$2
records_dir="$pack/assets/minecraft/sounds/records"

declare -a music=("$music_dir"/*)
declare -a records=("$records_dir"/*)

if [ ! -d "$pack" ] || [ ! -d "$music_dir" ]; then 
	echo "Format: convert.sh music_dir resourcepack_dir [--myself] [--random]"
	exit 1
fi

case $3 in
	--myself)
		for i in "$music_dir"/*
		do
			base="$(basename "$i")"
			ffmpeg -i "$i" -ac 1 "$records_dir"/"${base%.*}".ogg
		done
	;;
	--random)
		for i in {0..12}
		do
			ffmpeg -y -i "${music[$i]}" -ac 1 "${records[$i]}" 
			find "$records_dir" -type f -empty -print -delete
		done
	;;
	*) echo "Give argument (--myself or --random)" && exit 1 ;;
esac

cp -r "$pack" ~/.minecraft/resourcepacks

