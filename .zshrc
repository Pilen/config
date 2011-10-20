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


