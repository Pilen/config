# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
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
export PATH=~/programs/osm/bin:$PATH
export PATH=~/code/scripts:$PATH
autoload -U colors && colors

#if [[$hostname = *joker*]]; then
PROMPT="";
if [[ "$HOST" == joker ]]; then
    PROMPT="%(!.#.$)";
    RPROMPT="%3~";
else
    PROMPT="%B%{%F{green}%}%n@%m%{%f%} %{%F{blue}%}%~ %(!.#.$)%{%f%}%b"
    #RPROMPT="%3~";
fi

#PROMPT="$(tput sc; tput cup 0 $(($(tput cols)-5));date +%H:%M;tput rc)%(!.#.$)"
#RPROMPT="%T"
#else
#PROMT="[%n@%m:%C]$"
#fi

function mkcd {
    mkdir $1 && cd $1;
}

function cl {
    cd $1 && ls
}
function lss {
    if [[ -n $1 ]]; then
        if [[ -d $1 ]]; then
            ls $1;
            else
            less $1;
        fi
    else
        ls;
    fi
}

export SAGE_BROWSER="/usr/bin/feh -.qB checks"
export PATH=~/.cabal/bin:$PATH

autoload -U select-word-style
select-word-style bash

source ~/.aliases

if [[ -z $DISPLAY && $(tty) = /dev/tty1 ]]; then
    exec startx
fi

export PERL_LOCAL_LIB_ROOT="/home/pilen/perl5";
export PERL_MB_OPT="--install_base /home/pilen/perl5";
export PERL_MM_OPT="INSTALL_BASE=/home/pilen/perl5";
export PERL5LIB="/home/pilen/perl5/lib/perl5/x86_64-linux-thread-multi:/home/pilen/perl5/lib/perl5";
export PATH="/home/pilen/perl5/bin:$PATH";
