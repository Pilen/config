touchpad-off
setxkbmap us -variant colemak
xset r 66
xmodmap .Xmodmap
xsetroot -cursor_name left_ptr
xset -b
xset r rate 200 30
urxvtd -q -o -f
redshift -l 55.7:12.6 &
wmname LG3D
sxhkd &
exec bspwm
