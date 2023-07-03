# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export VISUAL="nvim"
export EDITOR="nvim"

export PATH="/home/mike/.jetbrains/pycharm-2022.2.3/bin:/home/mike/.jetbrains/clion-2022.3/bin:/home/mike/.jetbrains/intellij/bin:/home/mike/.jetbrains/rider/bin:/home/mike/.jdks/openjdk-18.0.2.1/bin:/home/mike/.local/bin:/opt/gradle/gradle-7.6/bin:/home/mike/.jetbrains/webstorm/bin:$PATH"

bindkey -v 
export KEYTIMEOUT=1

HISTSIZE=10000000
SAVEHIST=10000000

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="dracula"
ZSH_THEME="gnzh"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# My aliases
alias py="python3"
alias vim="nvim"
alias мшь="nvim"
alias sshvm="ssh mike@localhost -p12345"
alias tdb="mongo -u Cluster11890 -p YnZ5fGtpfXR1 mongodb+srv://cluster11890.kmmzu4j.mongodb.net"

# Config files
alias conkyrc="nvim -p ~/.config/conky/start.sh \
	~/.config/conky/system.conf \
	~/.config/conky/system-short.conf \
	~/.config/conky/todo.conf"
alias i3rc="nvim -p ~/.config/i3/config"
alias swayrc="nvim -p ~/.config/sway/config"
alias waybarc="nvim -p ~/.config/waybar/config ~/.config/waybar/style.css"
alias rofirc="cd ~/.config/rofi/ && ls"
alias rangerc="nvim -p ~/.config/ranger/rifle.conf \
					~/.config/ranger/rc.conf"
alias picomrc="nvim ~/.config/picom/picom.conf"
alias vimrc="nvim ~/.config/nvim/init.vim"
alias zathurarc="nvim ~/.config/zathura/zathurarc"
alias zshrc="nvim ~/.zshrc"
alias polyrc="nvim -p ~/.config/polybar/config.ini \
				     ~/.config/polybar/modules.ini \
		    	     ~/.config/polybar/user_modules.ini \
					 ~/.config/polybar/colors.ini"

alias mktar="tar -cvzf"
#	echo Format: mktar \[archive.tar.gz\] \[source directory\]"
alias untar="tar -xvf"
#	echo Format: untar \[archive.tar.gz\]"

alias mntwin="sudo mount /dev/nvme0n1p3 /win && echo mounted to /win"
alias umntwin="sudo umount /dev/nvme0n1p3"

alias todo="nvim ~/Документы/todo.txt"
alias doc2pdf="unoconv -f pdf"

# Default applications
alias pdf="zathura"
alias img="eog"

function doc {
	onlyoffice-desktopeditors "$(realpath $1)"
}

function fftrim {
	ffmpeg -i "$1" -ss "$2" -t "$3" -c copy $@ "edit_$1"
}

alias cdporta="~/porta/network/module1/8_NetworkSettings"

function scpvm {
	[ -z $1 ] && echo "No source specified"
	[ -z $2 ] && echo "No target specified"
	scp -r -P 12345 $1 mike@localhost:$2
}

source /home/mike/Git/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export PATH=$PATH:/home/mike/.spicetify
