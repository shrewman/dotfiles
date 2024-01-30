# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export VISUAL="nvim"
export EDITOR="nvim"

export PATH=$PATH:/home/mike/.jetbrains/pycharm-2022.2.3/bin
export PATH=$PATH:/home/mike/.jetbrains/clion-2022.3/bin
export PATH=$PATH:/home/mike/.jetbrains/intellij/bin
export PATH=$PATH:/home/mike/.jetbrains/rider/bin
export PATH=$PATH:/home/mike/.jetbrains/webstorm/bin
export PATH=$PATH:/home/mike/.jdks/openjdk-18.0.2.1/bin
export PATH=$PATH:/home/mike/.local/bin
export PATH=$PATH:/opt/gradle/gradle-7.6/bin
export PATH=$PATH:/home/mike/.spicetify

bindkey -v 
export KEYTIMEOUT=1

HISTSIZE=10000000
SAVEHIST=10000000

# ~/.dotfiles/.oh-my-zsh/themes/
ZSH_THEME="gnzh"
# ZSH_THEME_RANDOM_CANDIDATES=( "gnzh" "strug" )
# ZSH_THEME="random"

# ~/.dotfiles/.oh-my-zsh/plugins
# Add wisely, as too many plugins slow down shell startup.
plugins=(git node)

source $ZSH/oh-my-zsh.sh
export LANG=en_US.UTF-8

setopt noautocd

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# My aliases
alias py="python3"
alias tn="ts-node"
alias vim="nvim"
alias мшь="nvim"
alias sshvm="ssh mike@localhost -p12345"
alias gittoken="sudo cat ~/.config/github.token | clipcopy"

alias mktar="tar -cvzf"
#	echo Format: mktar \[archive.tar.gz\] \[source directory\]"
alias untar="tar -xvf"
#	echo Format: untar \[archive.tar.gz\]"

alias mntwin="sudo mount /dev/nvme0n1p4 /win && echo mounted to /win"
alias umntwin="sudo umount /dev/nvme0n1p4"

alias xampp="sudo /opt/lampp/manager-linux-x64.run"
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

alias todo="nvim ~/Documents/todo.txt"
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

source /home/mike/Git/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
