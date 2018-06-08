#!/usr/bin/env sh

setxkbmap us -variant colemak
xset r 66
xmodmap .Xmodmap
xsetroot -cursor_name left_ptr
xset -b
xset r rate 200 30
