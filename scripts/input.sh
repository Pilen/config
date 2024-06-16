#!/usr/bin/env sh

# setxkbmap us -variant colemak
xkbcomp -w 0 -I$HOME/config/xkb ~/config/xkb/map $DISPLAY
xset r 66
# xmodmap .Xmodmap
xsetroot -cursor_name left_ptr
xset -b
xset r rate 200 30
