#!/usr/bin/env bash

SCRIPT_PATH=$(dirname $(realpath $0))
CONFIG_DIR="$HOME/.config"

HELP=$( cat <<-END_HELP 
Usage: $(basename "$0") -t FILE -c FILE [-R] 
	
	-c, --config 	provide a file with config locations of your programs
	-t, --theme 	provide a file with your colors
	-R, --restart 	restart window manager after all operations
	-m, --mktemp	create template files in current directory
END_HELP
)


create_templates() {
	TCOLORS="theme.ini"
	TCONFIG="config-location"
	if [ ! -f "$TCOLORS" ]
	then
		echo "background = #1b1c25" >> "$TCOLORS"
		echo "background-alt = #44475a" >> "$TCOLORS"
		echo "primary = #bd93f9" >> "$TCOLORS"
		echo "primary-alt = #50fa7b" >> "$TCOLORS"
		echo "foreground = #f8f8f2" >> "$TCOLORS"
		echo >> "$TCOLORS"
		echo "black = #000000" >> "$TCOLORS"
		echo "red = #ff5555" >> "$TCOLORS"
		echo "green = #50fa7b" >> "$TCOLORS"
		echo "yellow = #f1fa8c" >> "$TCOLORS"
		echo "blue = #bd93f9" >> "$TCOLORS"
		echo "pink = #ff79c6" >> "$TCOLORS"
		echo "cyan = #8be9fd" >> "$TCOLORS"
		echo "white = #f8f8f2" >> "$TCOLORS"
		echo >> "$TCOLORS"
	else
		echo "File '$TCOLORS' already exists in current directory"
	fi

	if [ ! -f "$TCONFIG" ]
	then
		echo "alacritty = \"$HOME/.config/alacritty/alacritty.yml\"" >> "$TCONFIG"
		echo "conky = \"$HOME/.config/conky\"" >> "$TCONFIG"
		echo "foot = \"$HOME/.config/foot/foot.ini\"" >> "$TCONFIG"
		echo "polybar = \"$HOME/.config/polybar/colors.ini\"" >> "$TCONFIG"
		echo "i3 = \"$HOME/.config/i3/config\"" >> "$TCONFIG"
		echo "sway = \"$HOME/.config/sway/config\"" >> "$TCONFIG"
		echo "rofi = \"$HOME/.config/rofi\"" >> "$TCONFIG"
	else
		echo "File '$TCONFIG' already exists in current directory"
	fi
}

extract_configs() {
	ALACRITTY_CONFIG=$(grep "^alacritty[[:blank:]]*=" "$CONFIGS" | grep -oP '"\K[^"\047]+(?=["\047])')
	CONKY_DIR=$(grep "^conky[[:blank:]]*=" "$CONFIGS" | grep -oP '"\K[^"\047]+(?=["\047])')
	FOOT_CONFIG=$(grep "^foot[[:blank:]]*=" "$CONFIGS" | grep -oP '"\K[^"\047]+(?=["\047])')
	I3_CONFIG=$(grep "^i3[[:blank:]]*=" "$CONFIGS" | grep -oP '"\K[^"\047]+(?=["\047])')
	SWAY_CONFIG=$(grep "^sway[[:blank:]]*=" "$CONFIGS" | grep -oP '"\K[^"\047]+(?=["\047])')
	POLYBAR_CONFIG=$(grep "^polybar[[:blank:]]*=" "$CONFIGS" | grep -oP '"\K[^"\047]+(?=["\047])')
	ROFI_DIR=$(grep "^rofi[[:blank:]]*=" "$CONFIGS" | grep -oP '"\K[^"\047]+(?=["\047])')
	WAYBAR_CONFIG=$(grep "^waybar[[:blank:]]*=" "$CONFIGS" | grep -oP '"\K[^"\047]+(?=["\047])')

	[ ! -f "$ALACRITTY_CONFIG" ] && ALACRITTY_CONFIG="not extracted"
	[ ! -f "$FOOT_CONFIG" ] && FOOT_CONFIG="not extracted"
	[ ! -f "$I3_CONFIG" ] && I3_CONFIG="not extracted"
	[ ! -f "$SWAY_CONFIG" ] && I3_CONFIG="not extracted"
	[ ! -f "$POLYBAR_CONFIG" ] && POLYBAR_CONFIG="not extracted"
	[ ! -f "$CONKY_CONFIG" ] && WAYBAR_CONFIG="not extracted"
	[ ! -d "$WAYBAR_CONFIG" ] && WAYBAR_CONFIG="not extracted"

	[ ! -d "$ROFI_DIR" ] && ROFI_DIR="not extracted"

	echo "EXTRACTED CONFIGS:"
	echo "alacritty - $ALACRITTY_CONFIG"
	echo "conky - $CONKY_DIR"
	echo "foot - $FOOT_CONFIG"
	echo "i3 - $I3_CONFIG"
	echo "sway - $SWAY_CONFIG"
	echo "polybar - $POLYBAR_CONFIG"
	echo "rofi - $ROFI_DIR"
	echo "waybar - $WAYBAR_CONFIG"
}

# $1 theme file 
extract_theme() {
	THEME="$1"

	# light colors
	COLOR_01=$(grep "COLOR_01[[:blank:]]*=" "$THEME" | grep -Eo '#[a-f A-F 0-9]{6}') # black
	COLOR_02=$(grep "COLOR_02[[:blank:]]*=" "$THEME" | grep -Eo '#[a-f A-F 0-9]{6}') # red
	COLOR_03=$(grep "COLOR_03[[:blank:]]*=" "$THEME" | grep -Eo '#[a-f A-F 0-9]{6}') # green
	COLOR_04=$(grep "COLOR_04[[:blank:]]*=" "$THEME" | grep -Eo '#[a-f A-F 0-9]{6}') # yellow
	COLOR_05=$(grep "COLOR_05[[:blank:]]*=" "$THEME" | grep -Eo '#[a-f A-F 0-9]{6}') # blue
	COLOR_06=$(grep "COLOR_06[[:blank:]]*=" "$THEME" | grep -Eo '#[a-f A-F 0-9]{6}') # magenta
	COLOR_07=$(grep "COLOR_07[[:blank:]]*=" "$THEME" | grep -Eo '#[a-f A-F 0-9]{6}') # cyan
	COLOR_08=$(grep "COLOR_08[[:blank:]]*=" "$THEME" | grep -Eo '#[a-f A-F 0-9]{6}') # white

	# dark colors
	COLOR_09=$(grep "COLOR_09[[:blank:]]*=" "$THEME" | grep -Eo '#[a-f A-F 0-9]{6}') # black
	COLOR_10=$(grep "COLOR_10[[:blank:]]*=" "$THEME" | grep -Eo '#[a-f A-F 0-9]{6}') # red
	COLOR_11=$(grep "COLOR_11[[:blank:]]*=" "$THEME" | grep -Eo '#[a-f A-F 0-9]{6}') # green
	COLOR_12=$(grep "COLOR_12[[:blank:]]*=" "$THEME" | grep -Eo '#[a-f A-F 0-9]{6}') # yellow
	COLOR_13=$(grep "COLOR_13[[:blank:]]*=" "$THEME" | grep -Eo '#[a-f A-F 0-9]{6}') # blue
	COLOR_14=$(grep "COLOR_14[[:blank:]]*=" "$THEME" | grep -Eo '#[a-f A-F 0-9]{6}') # magenta
	COLOR_15=$(grep "COLOR_15[[:blank:]]*=" "$THEME" | grep -Eo '#[a-f A-F 0-9]{6}') # cyan
	COLOR_16=$(grep "COLOR_16[[:blank:]]*=" "$THEME" | grep -Eo '#[a-f A-F 0-9]{6}') # white

	BLACK=$(grep "black[[:blank:]]*=" "$THEME" | grep -Eo '#[a-f A-F 0-9]{6}')
	RED=$(grep "red[[:blank:]]*=" "$THEME" | grep -Eo '#[a-f A-F 0-9]{6}')
	GREEN=$(grep "green[[:blank:]]*=" "$THEME" | grep -Eo '#[a-f A-F 0-9]{6}')
	YELLOW=$(grep "yellow[[:blank:]]*=" "$THEME" | grep -Eo '#[a-f A-F 0-9]{6}')
	BLUE=$(grep "blue[[:blank:]]*=" "$THEME" | grep -Eo '#[a-f A-F 0-9]{6}')
	PINK=$(grep "pink[[:blank:]]*=" "$THEME" | grep -Eo '#[a-f A-F 0-9]{6}')
	CYAN=$(grep "cyan[[:blank:]]*=" "$THEME" | grep -Eo '#[a-f A-F 0-9]{6}')
	WHITE=$(grep "white[[:blank:]]*=" "$THEME" | grep -Eo '#[a-f A-F 0-9]{6}')

	BG=$(grep "background[[:blank:]]*=" "$THEME" | grep -Eo '#[a-f A-F 0-9]{6}')
	BGA=$(grep "background-alt[[:blank:]]*=" "$THEME" | grep -Eo '#[a-f A-F 0-9]{6}')
	FG=$(grep "foreground[[:blank:]]*=" "$THEME" | grep -Eo '#[a-f A-F 0-9]{6}')
	PR=$(grep "primary[[:blank:]]*=" "$THEME" | grep -Eo '#[a-f A-F 0-9]{6}')
	PRA=$(grep "primary-alt[[:blank:]]*=" "$THEME" | grep -Eo '#[a-f A-F 0-9]{6}')

	echo "EXTRACTED THEME:"
	echo "BG - $BG"
	echo "BGA - $BGA"
	echo "PR - $PR"
	echo "PRA - $PRA"
	echo "FG - $FG"
	echo
	echo "BLACK - $BLACK"
	echo "RED - $RED"
	echo "GREEN - $GREEN"
	echo "YELLOW - $YELLOW"
	echo "PINK - $PINK"
	echo "CYAN - $CYAN"
	echo "WHITE - $WHITE"
	echo 
}

apply_changes() {
	[ -f "$ALACRITTY_CONFIG" ] && change_alacritty
	[ -f "$CONKY_DIR" ] && change_conky
	[ -f "$FOOT_CONFIG" ] && change_foot
	[ -f "$I3_CONFIG" ] && change_i3
	[ -f "$SWAY_CONFIG" ] && change_sway
	[ -f "$POLYBAR_CONFIG" ] && change_polybar
	[ -f "$ROFI_DIR" ] && change_rofi
	[ -f "$WAYBAR_CONFIG" ] && change_waybar
}

# Changes each part of hexademical color by some value in order to
# brighten or darken original color
# Examples:	'brighten "#333333" +99' will return '#cccccc'
#			'brighten "#bb23a7" -77' will return '#660052'
brighten() {
	R=$(echo $1 | cut -c 2-3)
	G=$(echo $1 | cut -c 4-5)
	B=$(echo $1 | cut -c 6-7)

	R=${R^^}
	G=${G^^}
	B=${B^^}

	newR=$(echo "obase=ibase=16;$R$2" | bc)
	newG=$(echo "obase=ibase=16;$G$2" | bc)
	newB=$(echo "obase=ibase=16;$B$2" | bc)

	if [[ $newR == *"-"* ]]; then
		newR='00'
	fi
	if [[ $newG == *"-"* ]]; then
		newG='00'
	fi
	if [[ $newB == *"-"* ]]; then
		newB='00'
	fi

	[ ${#newR} -ge 3 ] && newR='ff'
	[ ${#newG} -ge 3 ] && newG='ff'
	[ ${#newB} -ge 3 ] && newB='ff'

	result=$(echo "#$newR$newG$newB")
	echo ${result,,}
}

change_waybar() {

}

change_polybar() {
	sed -i.old -e "s/background[ \t]*=.*/background = $BG/" "$POLYBAR_CONFIG"
	sed -i.old -e "s/background-alt[ \t]*=.*/background-alt = $BGA/" "$POLYBAR_CONFIG"
	sed -i.old -e "s/primary[ \t]*=.*/primary = $PR/" "$POLYBAR_CONFIG"
	sed -i.old -e "s/primary-alt[ \t]*=.*/primary-alt = $PRA/" "$POLYBAR_CONFIG"
	sed -i.old -e "s/foreground[ \t]*=.*/foreground = $FG/" "$POLYBAR_CONFIG"

	sed -i.old -e "s/black[ \t]*=.*/black = $BLACK/" "$POLYBAR_CONFIG"
	sed -i.old -e "s/red[ \t]*=.*/red = $RED/" "$POLYBAR_CONFIG"
	sed -i.old -e "s/green[ \t]*=.*/green = $GREEN/" "$POLYBAR_CONFIG"
	sed -i.old -e "s/yellow[ \t]*=.*/yellow = $YELLOW/" "$POLYBAR_CONFIG"
	sed -i.old -e "s/blue[ \t]*=.*/blue = $BLUE/" "$POLYBAR_CONFIG"
	sed -i.old -e "s/pink[ \t]*=.*/pink = $PINK/" "$POLYBAR_CONFIG"
	sed -i.old -e "s/cyan[ \t]*=.*/cyan = $CYAN/" "$POLYBAR_CONFIG"
	sed -i.old -e "s/white[ \t]*=.*/white = $WHITE/" "$POLYBAR_CONFIG"
}

change_alacritty() {
	yq -i -y ".colors.primary.background = \"$BG\"" "$ALACRITTY_CONFIG"
	yq -i -y ".colors.search.bar.background = \"$BG\"" "$ALACRITTY_CONFIG"
	yq -i -y ".colors.hints.start.foreground = \"$BG\"" "$ALACRITTY_CONFIG"
	yq -i -y ".colors.hints.end.background = \"$BG\"" "$ALACRITTY_CONFIG"

	yq -i -y ".colors.search.matches.foreground = \"$BGA\"" "$ALACRITTY_CONFIG"
	yq -i -y ".colors.search.focused_match.foreground = \"$BGA\"" "$ALACRITTY_CONFIG"
	yq -i -y ".colors.selection.background = \"$BGA\"" "$ALACRITTY_CONFIG"
	
	yq -i -y ".colors.primary.foreground = \"$FG\"" "$ALACRITTY_CONFIG"
	yq -i -y ".colors.search.bar.foreground = \"$FG\"" "$ALACRITTY_CONFIG"

	yq -i -y ".colors.search.matches.background = \"$GREEN\"" "$ALACRITTY_CONFIG"

	yq -i -y ".colors.search.focused_match.background = \"$YELLOW\"" "$ALACRITTY_CONFIG"

	yq -i -y ".colors.hints.start.background = \"$YELLOW\"" "$ALACRITTY_CONFIG"
	yq -i -y ".colors.hints.end.foreground = \"$YELLOW\"" "$ALACRITTY_CONFIG"

	
	yq -i -y ".colors.normal.red = \"$BLACK\"" "$ALACRITTY_CONFIG"
	yq -i -y ".colors.normal.red = \"$RED\"" "$ALACRITTY_CONFIG"
	yq -i -y ".colors.normal.green = \"$GREEN\"" "$ALACRITTY_CONFIG"
	yq -i -y ".colors.normal.yellow = \"$YELLOW\"" "$ALACRITTY_CONFIG"
	yq -i -y ".colors.normal.blue = \"$BLUE\"" "$ALACRITTY_CONFIG"
	yq -i -y ".colors.normal.magenta = \"$PINK\"" "$ALACRITTY_CONFIG"
	yq -i -y ".colors.normal.cyan = \"$CYAN\"" "$ALACRITTY_CONFIG"
	yq -i -y ".colors.normal.white = \"$WHITE\"" "$ALACRITTY_CONFIG"
	
	BRED=$(brighten "$RED" +1A)
	BGREEN=$(brighten "$GREEN" +1A)
	BYELLOW=$(brighten "$YELLOW" +1A)
	BBLUE=$(brighten "$BLUE" +1A)
	BPINK=$(brighten "$PINK" +1A)
	BCYAN=$(brighten "$CYAN" +1A)
	BWHITE=$(brighten "$WHITE" +1A)

	yq -i -y ".colors.bright.red = \"$BRED\"" "$ALACRITTY_CONFIG"
	yq -i -y ".colors.bright.green = \"$BGREEN\"" "$ALACRITTY_CONFIG"
	yq -i -y ".colors.bright.yellow = \"$BYELLOW\"" "$ALACRITTY_CONFIG"
	yq -i -y ".colors.bright.blue = \"$BBLUE\"" "$ALACRITTY_CONFIG"
	yq -i -y ".colors.bright.magenta = \"$BPINK\"" "$ALACRITTY_CONFIG"
	yq -i -y ".colors.bright.cyan = \"$BCYAN\"" "$ALACRITTY_CONFIG"
	yq -i -y ".colors.bright.white = \"$BWHITE\"" "$ALACRITTY_CONFIG"
}

change_i3() {
	sed -i.old -e "s/set \$background .*/set \$background $BG/" "$I3_CONFIG"
	sed -i.old -e "s/set \$background-alt.*/set \$background-alt $BGA/" "$I3_CONFIG"
	sed -i.old -e "s/set \$primary .*/set \$primary $PR/" "$I3_CONFIG"
	sed -i.old -e "s/set \$primary-alt.*/set \$primary-alt $PRA/" "$I3_CONFIG"
	sed -i.old -e "s/set \$foreground.*/set \$foreground $FG/" "$I3_CONFIG"
	sed -i.old -e "s/set \$urgent.*/set \$urgent $RED/" "$I3_CONFIG"
}

change_sway() {
	sed -i.old -e "s/set \$background .*/set \$background $BG/" "$SWAY_CONFIG"
	sed -i.old -e "s/set \$background-alt.*/set \$background-alt $BGA/" "$SWAY_CONFIG"
	sed -i.old -e "s/set \$primary .*/set \$primary $PR/" "$SWAY_CONFIG"
	sed -i.old -e "s/set \$primary-alt.*/set \$primary-alt $PRA/" "$SWAY_CONFIG"
	sed -i.old -e "s/set \$foreground.*/set \$foreground $FG/" "$SWAY_CONFIG"
	sed -i.old -e "s/set \$urgent.*/set \$urgent $RED/" "$SWAY_CONFIG"
}

change_foot() {
	sed -i.old -e "s/regular0=.*/regular0=${BG:1}/" "$FOOT_CONFIG"
	sed -i.old -e "s/regular1=.*/regular1=${RED:1}/" "$FOOT_CONFIG"
	sed -i.old -e "s/regular2=.*/regular2=${GREEN:1}/" "$FOOT_CONFIG"
	sed -i.old -e "s/regular3=.*/regular3=${YELLOW:1}/" "$FOOT_CONFIG"
	sed -i.old -e "s/regular4=.*/regular4=${BLUE:1}/" "$FOOT_CONFIG"
	sed -i.old -e "s/regular5=.*/regular5=${PINK:1}/" "$FOOT_CONFIG"
	sed -i.old -e "s/regular6=.*/regular6=${CYAN:1}/" "$FOOT_CONFIG"
	sed -i.old -e "s/regular7=.*/regular7=${WHITE:1}/" "$FOOT_CONFIG"

	BRED=$(brighten "$RED" +1A)
	BGREEN=$(brighten "$GREEN" +1A)
	BYELLOW=$(brighten "$YELLOW" +1A)
	BBLUE=$(brighten "$BLUE" +1A)
	BPINK=$(brighten "$PINK" +1A)
	BCYAN=$(brighten "$CYAN" +1A)
	BWHITE=$(brighten "$WHITE" +1A)

	sed -i.old -e "s/bright0=.*/bright0=${BGA:1}/" "$FOOT_CONFIG"
	sed -i.old -e "s/bright1=.*/bright1=${BRED:1}/" "$FOOT_CONFIG"
	sed -i.old -e "s/bright2=.*/bright2=${BGREEN:1}/" "$FOOT_CONFIG"
	sed -i.old -e "s/bright3=.*/bright3=${BYELLOW:1}/" "$FOOT_CONFIG"
	sed -i.old -e "s/bright4=.*/bright4=${BBLUE:1}/" "$FOOT_CONFIG"
	sed -i.old -e "s/bright5=.*/bright5=${BPINK:1}/" "$FOOT_CONFIG"
	sed -i.old -e "s/bright6=.*/bright6=${BCYAN:1}/" "$FOOT_CONFIG"
	sed -i.old -e "s/bright7=.*/bright7=${BWHITE:1}/" "$FOOT_CONFIG"
}

change_conky() {
	[ ! "$CONFIG_DIR/conky.old" ] && cp -r "$CONKY_DIR" "$CONFIG/conky.old"
	CFILE1="$CONKY_DIR/system-short.conf"
	CFILE2="$CONKY_DIR/system.conf"
	CFILE3="$CONKY_DIR/todo.conf"

	brPR=$(brighten $PR +1A)

	sed -i -e "s/default_color[ \t]=[ \t]'.*'/default_color = '$WHITE'/" "$CFILE1"
	sed -i -e "s/color1[ \t]=[ \t]'.*'/color1 = '$PR'/" "$CFILE1"
	sed -i -e "s/color2[ \t]=[ \t]'.*'/color2 = '$PR'/" "$CFILE1"
	sed -i -e "s/color3[ \t]=[ \t]'.*'/color3 = '$brPR'/" "$CFILE1"
	
	sed -i -e "s/default_color[ \t]=[ \t]'.*'/default_color = '$WHITE'/" "$CFILE2"
	sed -i -e "s/color1[ \t]=[ \t]'.*'/color1 = '$PR'/" "$CFILE2"
	sed -i -e "s/color2[ \t]=[ \t]'.*'/color2 = '$PR'/" "$CFILE2"
	sed -i -e "s/color3[ \t]=[ \t]'.*'/color3 = '$brPR'/" "$CFILE2"

	sed -i -e "s/default_color[ \t]=[ \t]'.*'/default_color = '$WHITE'/" "$CFILE3"
	sed -i -e "s/color1[ \t]=[ \t]'.*'/color1 = '$PRA'/" "$CFILE3"
}

change_rofi() {
	RFILE="$ROFI_DIR/colors/custom.rasi"
	echo "$RFILE"

	sed -i -e "s/background:[ \t]*.*;/background: $BG;/" "$RFILE"
	sed -i -e "s/background-alt:[ \t]*.*;/background-alt: $BGA;/" "$RFILE"
	sed -i -e "s/foreground:[ \t]*.*;/foreground: $FG;/" "$RFILE"
	sed -i -e "s/selected:[ \t]*.*;/selected: $PR;/" "$RFILE"
	sed -i -e "s/active:[ \t]*.*;/active: $PRA;/" "$RFILE"
	sed -i -e "s/urgent:[ \t]*.*;/urgent: $RED;/" "$RFILE"

	ln -sf "$ROFI_DIR/colors/custom.rasi" "$RDIR/current-colors.rasi"
}

# Main
# if [[ ! -f "$1" ]]; then
# 	echo "No color file specified. Should we create color template? [y/N]: "
# 	read response
# 	case "$response" in
# 		[YyДд])	create_template ;;
# 	esac
# 	exit 1
# fi

# Main
if [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
	echo "$HELP"
	exit 0
fi

while [ $# -gt 0 ]; do
	case "$1" in
	-c|--configs)
		CONFIGS="$2"
		if [ ! -f "$CONFIGS" ]; then
			echo "File '$CONFIGS' doesn't exists"
			exit 1
		fi
		extract_configs
		apply_changes
		shift 1
	;;
	-t|--theme)
		[ -z "$2" ] && echo "Specify theme file location" && exit 1
		[ ! -f "$2" ] && echo "Theme file '$2' doesn't exists" && exit 1
		ln -sf "$2" "$SCRIPT_PATH/current-theme.ini"
		extract_theme current-theme.ini
		shift 1
	;;
	-R|--restart)
		[ $DESKTOP_SESSION == "i3" ] && i3-msg restart
		[ $DESKTOP_SESSION == "sway" ] && swaymsg reload
		shift 
	;;
	-m|--mktemp)
		create_templates
		shift
	;;
	*)
		echo "$HELP" 
		exit 1 
	;;
	esac
	shift
done


