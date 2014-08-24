#!/bin/bash

date=`date +%H:%M`
bat=`acpi | grep -o '[0-9]*%'`

if [[ $(acpi | grep "Charging") ]]
then
    bat="$bat+"
elif [[ $(acpi | grep "Discharging") ]]
then
    bat="$bat-"
fi

title="$date $bat"


menu=(\
        chromium  "chromium --purge-memory-button"
        emacs     "emacs"
        ranger    "urxvt -e ranger"
        zathura   "zathura"
        gimp      "gimp"
        inkscape  "inkscape"
        xlock     "xlock -mode matrix -font fixed -bg black -fg green -erasedelay 0"
        xpdf      "perl /home/pilen/code/scripts/xpdf.pl"
        firefox   "firefox"
        python3   "urxvtc -bg #111111 -fg #51a366 -e python3"
        python2   "urxvtc -bg #111111 -fg #6fbfe7 -e python2 -i /home/pilen/code/scripts/python2.py"
        alsamixer "urxvtc -bg black -e alsamixer"
        htop      "urxvtc -bg black -e htop"
        cal       "urxvtc -bg black -e perl /home/pilen/code/scripts/cal.pl"
        update    "urxvtc -bg black -e sudo pacman -Syu"
        urxvt-nf  "urxvtc -fade 0"
        shutdown  "urxvtc -bg black -fg red -e sudo shutdown -h now"
        youtube   "yplayer"
        politiken "chromium --purge-memory-button -new-window -incognito politiken.dk"
        pong      "urxvtc -bg black -e ping google.com"
        # 0%        "amixer set Master 0"
        # 10%       "amixer set Master 18"
        # 20%       "amixer set Master 29"
        # 30%       "amixer set Master 37"
        # 40%       "amixer set Master 43"
        # 50%       "amixer set Master 48"
        # 60%       "amixer set Master 52"
        # 70%       "amixer set Master 55"
        # 80%       "amixer set Master 58"
        # 90%       "amixer set Master 61"
        # 100%      "amixer set Master 64"
        # MAX       "amixer set Master 100%"
        0%        "amixer set Master 0"
        10%       "amixer set Master 26"
        20%       "amixer set Master 38"
        30%       "amixer set Master 46"
        40%       "amixer set Master 53"
        50%       "amixer set Master 58"
        60%       "amixer set Master 62"
        70%       "amixer set Master 65"
        80%       "amixer set Master 69"
        90%       "amixer set Master 72"
        100%      "amixer set Master 74"
        MAX       "amixer set Master 100%"
        # 0%        "amixer set Master  0%"
        # 10%       "amixer set Master 10%"
        # 20%       "amixer set Master 20%"
        # 30%       "amixer set Master 30%"
        # 40%       "amixer set Master 40%"
        # 50%       "amixer set Master 50%"
        # 60%       "amixer set Master 60%"
        # 70%       "amixer set Master 70%"
        # 80%       "amixer set Master 80%"
        # 90%       "amixer set Master 90%"
        # 100%      "amixer set Master 100%"
        # MAX       "amixer set Master 100%"
        maps      "chromium --purge-memory-button -new-window https://maps.google.com/"
        maple     "/home/pilen/code/scripts/maple"
        dmenu     "dmenu_run"
        omacs     "sh /home/pilen/code/scripts/omacs"

        links     "perl /home/pilen/code/scripts/linkmenu.pl"
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
