#!/bin/bash

# Installing fonts
mkdir -p ~/.local/share/fonts
cp ~/.dotfiles/fonts/* ~/.local/share/fonts


ln -s ~/.dotfiles/.themes ~/.themes
ln -s ~/.dotfiles/.vimrc ~/.vimrc
ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.oh-my-zsh ~
ln -s ~/.dotfiles/.ideavimrc ~/.ideavimrc

ln -s ~/.dotfiles/alacritty ~/.config
ln -s ~/.dotfiles/conky ~/.config
ln -s ~/.dotfiles/dunst ~/.config
ln -s ~/.dotfiles/flameshot ~/.config
ln -s ~/.dotfiles/JetBrains ~/.config
ln -s ~/.dotfiles/mpv ~/.config
ln -s ~/.dotfiles/nvim ~/.config
ln -s ~/.dotfiles/picom ~/.config
ln -s ~/.dotfiles/polybar ~/.config
ln -s ~/.dotfiles/ranger ~/.config
ln -s ~/.dotfiles/rofi ~/.config
ln -s ~/.dotfiles/sway ~/.config
ln -s ~/.dotfiles/waybar ~/.config
ln -s ~/.dotfiles/zathura ~/.config

ln -s ~/.dotfiles/scripts ~
