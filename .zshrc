# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory autocd extendedglob nomatch
setopt hist_ignore_space
setopt hist_expire_dups_first
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt transient_rprompt
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

export LESS="-R"

export PATH="${PATH}:/opt/mosml/bin"
export PATH=~/programs/osm/bin:$PATH
export PATH=~/config/scripts:$PATH
export PATH=~/.config/bspwm:$PATH
export PATH=~/tools/mongodb/bin:$PATH
autoload -U colors && colors


export CLASSPATH=".:${CLASSPATH}"
export _JAVA_AWT_WM_NONREPARENTING=1


#if [[$hostname = *penguin*]]; then
PROMPT="";
if [[ "$HOST" == joker ]]; then
    PROMPT="%B%{%F{green}%}%n@%m%{%f%} %{%F{blue}%}%~ %(!.#.$)%{%f%}%b"
    #RPROMPT="%3~";
else
    PROMPT="%B%{%F{magenta}%}%n@%m%{%f%} %{%F{blue}%}%~ %(!.#.$)%{%f%}%b"
    # PROMPT="%(!.#.$)";
    # RPROMPT="%3~";
fi

#PROMPT="$(tput sc; tput cup 0 $(($(tput cols)-5));date +%H:%M;tput rc)%(!.#.$)"
#RPROMPT="%T"
#else
#PROMT="[%n@%m:%C]$"
#fi

if [ -e "~/.git_prompt.zsh" ]; then
    source ~/.git_prompt.zsh
fi

if [ -e "/usr/share/z/z.sh" ]; then
    source /usr/share/z/z.sh
    alias z="_z"
fi

function mkcd {
    mkdir $1 && cd $1;
}

function cl {
    cd $1 && ls
}
function lss {
    if [[ -n $1 ]]; then
        if [[ -d $1 ]]; then
            ls  -CF --group-directories-first --color=auto "$@";
            else
            less "$@";
        fi
    else
        ls -CF --group-directories-first --color=auto "$@";
    fi
}

cman() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;36m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;40;92 m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        man "$@"
}

export SAGE_BROWSER="/usr/bin/feh -.qB checks"
export PATH=~/.cabal/bin:$PATH

autoload -U select-word-style
select-word-style bash

source ~/.aliases

export PERL_LOCAL_LIB_ROOT="/home/pilen/perl5";
export PERL_MB_OPT="--install_base /home/pilen/perl5";
export PERL_MM_OPT="INSTALL_BASE=/home/pilen/perl5";
export PERL5LIB="/home/pilen/perl5/lib/perl5/x86_64-linux-thread-multi:/home/pilen/perl5/lib/perl5";
export PATH="/home/pilen/perl5/bin:$PATH";

export PYTHONPATH="$PYTHONPATH"

export GIT_PAGER="less";


# export LESS=-R
# export LESS_TERMCAP_mb=$(printf "\e[1;31m")
## export LESS_TERMCAP_md=$(printf "\e[1;31m")
# export LESS_TERMCAP_md=$(printf "\e[1;32m")
# export LESS_TERMCAP_me=$(printf "\e[0m")
# export LESS_TERMCAP_se=$(printf "\e[0m")
# export LESS_TERMCAP_so=$(printf "\e[1;44;33m")
# export LESS_TERMCAP_ue=$(printf "\e[0m")
# export LESS_TERMCAP_us=$(printf "\e[1;32m")


alias clear="echo -ne '\033c'"



if [[ -z $DISPLAY && $(tty) = /dev/tty1 ]]; then
    exec startx
fi

[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ '
