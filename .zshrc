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

export PATH="${PATH}:/opt/mosml/bin"
autoload -U colors && colors

#if [[$hostname = *joker*]]; then
PROMPT="";
if [[ "$HOST" == joker ]]; then
    PROMPT="%(!.#.$)";
    RPROMPT="%3~";
else
    PROMPT="%n@%m%(!.#.$)"
    RPROMPT="%3~";
fi

#PROMPT="$(tput sc; tput cup 0 $(($(tput cols)-5));date +%H:%M;tput rc)%(!.#.$)"
#RPROMPT="%T"
#else
#PROMT="[%n@%m:%C]$"
#fi

export SAGE_BROWSER="/usr/bin/feh -.qB checks"

source ~/.aliases

if [[ -z $DISPLAY && $(tty) = /dev/tty1 ]]; then
    exec startx
fi
