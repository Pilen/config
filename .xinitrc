synclient TouchpadOff=1
setxkbmap us -variant colemak; xset r 66
xmodmap .Xmodmap
xsetroot -cursor_name left_ptr
urxvtd -q -f -o
redshift -l 55.7:12.6 &
exec xmonad
