touchpad-off
setxkbmap us -variant colemak
xset r 66
xmodmap .Xmodmap
xsetroot -cursor_name left_ptr
set bell-style none
xset -b
xset r rate 200 30
xrdb config/.Xresources # Might not be needed
urxvtd -q -o -f
redshift -l 55.7:12.6 &
wmname LG3D
sxhkd &
xrdb ~/.Xresources
exec bspwm
