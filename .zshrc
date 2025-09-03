# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export VISUAL="nvim"
export EDITOR="nvim"

export PATH=$PATH:/home/mike/.jetbrains/pycharm-2022.2.3/bin
export PATH=$PATH:/home/mike/.jetbrains/clion-2022.3/bin
export PATH=$PATH:/home/mike/.jetbrains/intellij/bin
export PATH=$PATH:/home/mike/.jetbrains/rider/bin
export PATH=$PATH:/home/mike/.jetbrains/WebStorm-243.21565.180/bin
export PATH=$PATH:/home/mike/.jdks/openjdk-18.0.2.1/bin
export PATH=$PATH:/home/mike/.local/bin
export PATH=$PATH:/opt/gradle/gradle-7.6/bin
export PATH=$PATH:/home/mike/.spicetify
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/home/mike/go/bin/

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
plugins=(git node golang)

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
alias v="nvim ."
alias t="tmux"
alias sshvm="ssh mike@localhost -p12345"

alias mktar="tar -cvzf"
#	echo Format: mktar \[archive.tar.gz\] \[source directory\]"
alias untar="tar -xvf"
#	echo Format: untar \[archive.tar.gz\]"

alias mntwin="sudo mount /dev/nvme0n1p4 /win && echo mounted to /win"
alias umntwin="sudo umount /dev/nvme0n1p4"

alias xampp="sudo /opt/lampp/manager-linux-x64.run"
# Config files
alias conkyrc="cd ~/.config/conky/ && nvim ."
alias i3rc="cd ~/.config/i3/ && nvim ./config"
alias swayrc="cd ~/.config/sway/ && nvim ./config"
alias waybarc="cd ~/.config/waybar/ && nvim ."
alias rofirc="cd ~/.config/rofi/ && nvim ."
alias rangerc="cd ~/.config/ranger/ && nvim ."
alias picomrc="cd ~/.config/picom/ && nvim ./picom.conf"
alias vimrc="cd ~/.config/nvim && nvim ."
alias мшькс="cd ~/.config/nvim && nvim ."
alias tmuxrc="vim ~/.tmux.conf"
alias zathurarc="cd ~/.config/zathura/ && nvim ./zathurarc"
alias zshrc="cd ~ && nvim .zshrc"
alias polyrc="cd ~/.config/polybar/ && nvim ."

alias todo="cd ~ && nvim ~/Documents/todo.txt"
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

source /home/mike/Git/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
