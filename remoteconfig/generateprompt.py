#!/usr/bin/env python3

import sys
import os
import socket
import getpass
import subprocess

# bash debian default: PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$
def prompt():
    hostname = socket.gethostname()
    user = getpass.getuser()
    country = hostname[0:2]
    city = hostname[2:5]
    company = hostname[5:6]
    service = hostname[6:]
    tmux = os.environ.get("TMUX_SESSION", None)
    if user == "vagrant":
        yield r"\[\e[01;33m\]\u"
        yield r"\[\e[00;33m\]@\h"
        if tmux:
            yield r"\[\e[01;30m\] "
            yield tmux
        yield r"\[\e[00m\]:"
        yield r"\[\e[01;34m\]\w "
        yield r"\[\e[00;34m\]\$"
    elif country == "dk" and city == "cph" and company == "i":
        yield r"\[\e[01;32m\]\u"
        yield r"\[\e[00;32m\]@"
        yield r"\[\e[00;36m\]"
        yield country
        yield city
        yield company
        yield r"\[\e[01;36m\]"
        yield service
        if tmux:
            yield r"\[\e[01;30m\] "
            yield tmux
        yield r"\[\e[00m\]:"
        yield r"\[\e[01;34m\]\w "
        yield r"\[\e[00;34m\]\$"
    elif country == "in" and city == "ggn" and (company == "i" or company == "j"):
        yield r"\[\e[01;32m\]\u"
        yield r"\[\e[00;32m\]@"
        yield r"\[\e[00;31m\]"
        yield country
        yield city
        yield company
        yield r"\[\e[01;31m\]"
        yield service
        if tmux:
            yield r"\[\e[01;30m\] "
            yield tmux
        yield r"\[\e[00m\]:"
        yield r"\[\e[01;34m\]\w "
        yield r"\[\e[00;34m\]\$"
    else:
        yield r"\[\e[01;32m\]\u"
        yield r"\[\e[00;32m\]@"
        yield r"\[\e[01;36m\]\h"
        if tmux:
            yield r"\[\e[01;30m\] "
            yield tmux
        yield r"\[\e[00m\]:"
        yield r"\[\e[01;34m\]\w "
        yield r"\[\e[00;34m\]\$"
    yield " "

def main():
    print("".join(prompt()) + r"\[\e[00m\]")

if __name__ == "__main__":
    main()
