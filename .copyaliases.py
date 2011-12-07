#! /usr/bin/python

with open('/home/pilen/.aliases','r') as inp:
    with open('/home/pilen/.emacs.d/eshell/alias','w') as out:
        for line in inp:
            if line.startswith('alias'):
                out.write(line.partition('=')[0] + " " + line.partition('=')[2][:-2]+' $*\'\n')
        out.write("alias f 'find-file $1'\n")
