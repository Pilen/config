
# Check for an interactive session
[ -z "$PS1" ] && return

#alias emacs='emacs -nw -bg brightblack -fg color-230'

alias xlock='xlock -mode matrix -font fixed'
alias xlcok='xlock -mode matrix -font fixed'
alias ls='ls --color=auto'
alias ls='ls -CF --group-directories-first --color=never'
alias c='clear'
alias feh='feh -.qB default'
alias fehb='feh -.qB black'
alias fehw='feh -.qB white'
alias cal='cal -m -3'
alias ,='./a.out'
alias diablo='wine /home/pilen/.wine/drive_c/Program\ Files\ \(x86\)/Diablo\ II/Diablo\ II.exe'
alias teeworlds='./games/teeworlds-0.5.2-linux_x86_64/teeworlds'
alias pong='ping google.dk'
alias nano='nano -Simz'
alias eduroam='sudo wpa_supplicant -B -D wired -i eth0 -c /root/bla.txt'
alias eixt='exit'
#alias net='sudo killall dhcpcd -w; sudo dhcpcd eth0'
alias net='sudo dhcpcd -k; sudo dhcpcd eth0'

#PS1='[\u@\h \W]\$ '
#if ["`id -u`" = 0]; then
#    PS1="#\[\033[s\]\[\033[1;\$((COLUMNS-4))f\]\$(date +%H:%M)\[\033[u\]"
#else
     PS1="$\[\033[s\]\[\033[1;\$((COLUMNS-4))f\]\$(date +%H:%M)\[\033[u\]"
#     PS1="$"
#fi

if [[ -z $DISPLAY && $(tty) = /dev/tty1 ]]; then
    exec startx
fi
