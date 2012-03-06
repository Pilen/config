#I have changed to zsh, this config file is not updated anymore.


# Check for an interactive session
[ -z "$PS1" ] && return

#alias emacs='emacs -nw -bg brightblack -fg color-230'

source ~/.aliases

#PS1='[\u@\h \W]\$ '
#if ["`id -u`" = 0]; then
#    PS1="#\[\033[s\]\[\033[1;\$((COLUMNS-4))f\]\$(date +%H:%M)\[\033[u\]"
#else
    #PS1="$\[\033[s\]\[\033[1;\$((COLUMNS-4))f\]\$(date +%H:%M)\[\033[u\]"
    PS1="\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\]"
#    PS1="$"
#fi

if [[ -z $DISPLAY && $(tty) = /dev/tty1 ]]; then
    exec startx
fi
