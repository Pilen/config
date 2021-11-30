#!/bin/bash

date=`date +%H:%M`
bat=`acpi | grep "Battery 0" | grep -o '[0-9]*%'`

if [[ $(acpi | grep "Charging") ]]
then
    bat="$bat+"
elif [[ $(acpi | grep "Discharging") ]]
then
    bat="$bat-"
fi

title="$date $bat"

menu=(\
        firefox   "firefox"
        emacs     "emacs"
        ranger    "urxvt -e ranger"
        zathura   "zathura"
        gimp      "gimp"
        inkscape  "inkscape"
        krita     "krita"
        lock-screen "lock-screen"
        xlock     "xlock -mode matrix -font fixed -bg black -fg green -erasedelay 0"
        evince    "my-evince"
        xpdf      "perl $HOME/config/scripts/xpdf.pl"
        #chromium  "chromium --purge-memory-button"
        chromium  "firefox"
        thunderbird "thunderbird.sh"
        # python3   "urxvtc -bg #111111 -e bpython"
        python3   "urxvtc -bg #111111 -fg #51a366 -e ipython3 -i $HOME/config/python-defaults.py"
        python2   "urxvtc -bg #111111 -fg #6fbfe7 -e ipython2 -i $HOME/config/python-defaults.py"
        alsamixer "urxvtc -bg black -e alsamixer"
        htop      "urxvtc -bg black -e htop"
        cal       "urxvtc -bg black -e perl $HOME/config/scripts/cal.pl"
        update    "urxvtc -bg black -e sudo pacman -Syu"
        urxvt-nf  "urxvtc -fade 0"
        shutdown  "urxvtc -bg black -fg red -e sudo shutdown -h now"
        spotify   "spotify"
        pause     "spotify-control playpause"
        youtube   "yplayer"
        politiken "chromium --purge-memory-button -new-window -incognito politiken.dk"
        netflix   "netflix.sh"
        pong      "urxvtc -bg black -e ping google.com"
        color     "zenity --color-selection"
        suspend   "suspend-computer"
        starleaf  "starleaf-breeze"
        frokost   "frokost"
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
        # 0%        "amixer set Master 0"
        # 10%       "amixer set Master 26"
        # 20%       "amixer set Master 38"
        # 30%       "amixer set Master 46"
        # 40%       "amixer set Master 53"
        # 50%       "amixer set Master 58"
        # 60%       "amixer set Master 62"
        # 70%       "amixer set Master 65"
        # 80%       "amixer set Master 69"
        # 90%       "amixer set Master 72"
        # 100%      "amixer set Master 74"
        # MAX       "amixer set Master 100%"
        # mute      "amixer -q set Master toggle"
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
        0%        "amixer -q -M set Master  0%"
        10%       "amixer -q -M set Master 10%"
        20%       "amixer -q -M set Master 20%"
        30%       "amixer -q -M set Master 30%"
        40%       "amixer -q -M set Master 40%"
        50%       "amixer -q -M set Master 50%"
        60%       "amixer -q -M set Master 60%"
        70%       "amixer -q -M set Master 70%"
        80%       "amixer -q -M set Master 80%"
        90%       "amixer -q -M set Master 90%"
        100%      "amixer -q -M set Master 100%"
        MAX       "amixer -q -M set Master 100%"
        mute      "amixer -q set Master toggle"

        maps      "chromium --purge-memory-button -new-window https://maps.google.com/"
        maple     "$HOME/config/scripts/maple"
        dmenu     "dmenu_run"
        omacs     "sh $HOME/config/scripts/omacs"
        pmacs     "emacs -Q"

        links     "perl $HOME/config/scripts/linkmenu.pl"
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

select=`echo -e $menu_labels | dmenu -i -p "$title" -fn "Clean-10"`

if [ "$select" != "" ]; then

#   fetch and clean the index of the selected label
    index=`echo -e "${menu_labels[*]}" | grep -xnm1 $select | sed 's/:.*//'`

#   get the command which has the same index
    part=`echo -e ${menu_commands[*]} | head -$index`
    exe=`echo -e "$part" | tail -1`

    echo $exe
#   execute
    $exe &
fi
