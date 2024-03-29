#!/bin/bash

HELP=$( cat<<-END_HELP
spotifyc: Control spotify with ease

    -m|--mute-ads <opt: alt_music_dir> [RUN ONLY ONCE]
    -o|--output : give details on current song
                  [for status bars like polybar, i3status, etc]
    -R|--remastered: same as -o|--output but trim out fields with words: remastered, live, version
            	  [may not display song names properly, but it works for me perfectly fine]
    -f|--format: [ '{{ artist }}, {{ title }}, {{ album }}, .. see man playerctl for all' ]
                  for icons, use {{ icon }}
    -i|--icons "<icon to show when playing>" "<icon to show when song paused>": both args compulsory(can be "")
    -c|--play-pause: toggles play/pause
    -p|--prev: prev song on spotify
    -n|--next: next song on spotify
    -r|--play: play song
    -s|--pause: pause song
    -v|--volume: [ m: mute, u:unmute, t: toggle mute, x: sets volume, +-x: adjusts volume ]
    -h|--help: show help
END_HELP
)

OUTPUT_FORMAT="{{ artist }}: {{ title }}"
ICON_PAUSE=
ICON_PLAY=

function get-spotify-sink() {
    pactl list sink-inputs | grep -P '(^Sink Input)|(media.name = "Spotify"$)' |
        awk -F'#' '/Spotify/ { print sink } { sink = $2 }' | tail -1
}

while (( $# > 0 )); do
    case "$1" in
        -m|--mute-ads )
            [ -d "$2" ] && MUSIC_DIR="$2" || MUSIC_DIR=

            spotifyc_mute_ads "$MUSIC_DIR"

            shift
            [ -z "$MUSIC_DIR" ] || shift ;;

        -c|--play-pause )
            playerctl -p spotify play-pause
            shift ;;

        -o|--output )
            spotify_play_status="$( playerctl -p spotify status )"

            [[ "$spotify_play_status" == "Playing" ]] && icon="$ICON_PLAY" || icon="$ICON_PAUSE"
            OUTPUT_FORMAT=${OUTPUT_FORMAT//\{\{ icon \}\}/"$icon"}

            playerctl -p spotify metadata --format "$OUTPUT_FORMAT"
            shift ;;

        -R|--remastered )
            spotify_play_status="$( playerctl -p spotify status )"

            [[ "$spotify_play_status" == "Playing" ]] && icon="$ICON_PLAY" || icon="$ICON_PAUSE"
            OUTPUT_FORMAT=${OUTPUT_FORMAT//\{\{ icon \}\}/"$icon"}

            output=$(playerctl -p spotify metadata --format "$OUTPUT_FORMAT")

            if [[ $output == *"Remaster"* || $output == *"Version"* || $output == *"Live"* ]]; then
				echo $output | awk -F - 'BEGIN {OFS=FS} {$(NF--)=""; print}' | sed 's/..$//'
            else 
                echo $output
            fi

            shift ;;

        -i|--icons )
            ICON_PLAY="$2"
            ICON_PAUSE="$3"

            shift 3;;

        -f|--format )
            OUTPUT_FORMAT="$2"
            shift 2;;

        -p|--prev )
            playerctl -p spotify previous
            shift ;;

        -n|--next )
            playerctl -p spotify next
            shift ;;

        -r|--play )
            playerctl -p spotify play
            shift ;;

        -s|--pause )
            playerctl -p spotify pause
            shift ;;

        -v|--volume )
            sink=$( get-spotify-sink )
            vol="$2"

            if [[ "$vol" == "m" ]]; then
                pactl set-sink-input-mute "$sink" 1
            elif [[ "$vol" == "u" ]]; then
                pactl set-sink-input-mute "$sink" 0
            elif [[ "$vol" == "t" ]]; then
                pactl set-sink-input-mute "$sink" toggle
            else
                vol="$( grep -Po '(\+|-)?\d+' <<< "$vol" )"

                if [[ "${vol:0:1}" == '+' ]]; then
                    rel='+'
                    vol="${vol:1}"
                elif [[ "${vol:0:1}" == '-' ]]; then
                    rel='-'
                    vol="${vol:1}"
                fi

                # spotify uses 0-65535 for managing it's volume
                vol="$(( (vol*65535)/100 ))"

				echo $(pactl get-source-volume "$sink")
                pactl set-sink-input-volume "$sink" "${rel}${vol}"
            fi

            shift 2;;

        -h|--help )
            echo "$HELP"
            shift ;;

        * )
            (>&2 echo Unkown option "$1")
            shift ;;
    esac
done
