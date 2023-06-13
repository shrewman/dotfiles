#!/bin/sh

# Dracula theme
BACKGROUND='#22222c'
PRIMARY='#94acd0'
ALTERNATE='#f69b8e'
FOREGROUND='#ffffff'
URGENT='#f69b8e'
GREEN='#50fa7b'

sleep 0.16

i3lock \
--inside-color=$BACKGROUND        \
--ring-color=$ALTERNATE           \
--line-color=$BACKGROUND          \
--separator-color=$ALTERNATE      \
\
--insidever-color=$BACKGROUND     \
--ringver-color=$PRIMARY          \
\
--insidewrong-color=$BACKGROUND   \
--ringwrong-color=$URGENT         \
\
--verif-color=$FOREGROUND         \
--wrong-color=$FOREGROUND         \
--time-color=$FOREGROUND          \
--date-color=$FOREGROUND          \
--layout-color=$FOREGROUND        \
--keyhl-color=$GREEN              \
--bshl-color=$URGENT              \
\
--screen 1                        \
--blur 5                          \
--clock                           \
--indicator                       \
--time-str="%H:%M:%S"             \
--date-str="%A, %d.%m.%Y"         \
