# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch
unsetopt beep notify
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/pilen/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall


#zstyle 'completion:*' menu select
setopt completealiases
autoload U promptinit
promptinit

autoload -U colors && colors


PROMPT="%(!.#.$)"
PROMPT="$(tput sc; tput cup 0 $(($(tput cols)-5));date +%H:%M;tput rc)%(!.#.$)"



alias clock="while sleep 1; do tput sc; tput cup 0 $(($(tput cols)-5));date +%H:%M;tput rc;done &;clear"
alias glock="while sleep 1; do tput sc; tput cup 0 $(($(tput cols)-5));date +%H:%M; print ${$(acpi -b)[4,4]}; tput rc;done &;clear"



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
alias net='sudo killall dhcpcd -w; sudo dhcpcd eth0;dropbox stop; dropbox start; dropbox status'
#alias net='sudo dhcpcd -k; sudo dhcpcd eth0'
alias gcc32='/usr/bin/x86_64-unknown-linux-gnu-gcc'
alias pip='curl http://ifconfig.me/'
alias push='~/pushconfig'


if [[ -z $DISPLAY && $(tty) = /dev/tty1 ]]; then
    exec startx
fi
