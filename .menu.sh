#!/bin/bash

date=`date +%H:%M`
bat=`acpi | grep -o '[0-9]*%'`
title="$date $bat"

menu=(\
        chromium  "chromium --purge-memory-button"
        emacs     "emacs"
        ranger    "urxvt -e ranger"
        zathura   "zathura"
        gimp      "gimp"
        inkscape  "inkscape"
        xlock     "xlock -mode matrix -font fixed -bg black -fg green -erasedelay 0"
        xpdf      "perl xpdf.pl"
        firefox   "firefox"
        python3   "urxvtc -bg #111111 -fg #51a366 -e python3"
        python2   "urxvtc -bg #111111 -fg #6fbfe7 -e python2 -i .python2.py"
        alsamixer "urxvtc -bg black -e alsamixer"
        htop      "urxvtc -bg black -e htop"
        cal       "urxvtc -bg black -e perl .cal.pl"
        update    "urxvtc -bg black -e sudo pacman -Syu"
        urxvt-nf  "urxvtc -fade 0"
        shutdown  "urxvtc -bg black -fg red -e sudo shutdown -h now"
        0%        "amixer set Master 0"
        10%       "amixer set Master 18"
        20%       "amixer set Master 29"
        30%       "amixer set Master 37"
        40%       "amixer set Master 43"
        50%       "amixer set Master 48"
        60%       "amixer set Master 52"
        70%       "amixer set Master 55"
        80%       "amixer set Master 58"
        90%       "amixer set Master 61"
        100%      "amixer set Master 64"
        MAX       "amixer set Master 64"
        maple     "maple"
        dmenu     "dmenu_run"
        omacs     "sh .omacs"

        links     "perl linkmenu.pl"
     )

for (( count = 0 ; count < ${#menu[*]}; count++ )); do

#   build two arrays, one for labels, the other for commands
    temp=${menu[$count]}
    if (( $count < ${#menu[*]}-2 )); then
        temp+="\n"
    fi
    if (( "$count" % 2 == "0" )); then
        menu_labels+=$temp
    else
        menu_commands+=$temp
    fi

done

select=`echo -e $menu_labels | dmenu -i -p "$title"`

if [ "$select" != "" ]; then

#   fetch and clean the index of the selected label
    index=`echo -e "${menu_labels[*]}" | grep -xnm1 $select | sed 's/:.*//'`

#   get the command which has the same index
    part=`echo -e ${menu_commands[*]} | head -$index`
    exe=`echo -e "$part" | tail -1`

#   execute
    $exe &
fi
