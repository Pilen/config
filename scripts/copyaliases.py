#! /usr/bin/python3

from pathlib import Path

with (Path.home()/'.aliases').open('r') as inp:
    with (Path.home()/'.emacs.d'/'eshell'/'alias').open('w') as out:
        for line in inp:
            if line.startswith('alias '):
                out.write(line.partition('=')[0] + " " + line.partition('=')[2][1:-2]+' $*\n')
        #out.write("alias e 'find-file $1'\n")
