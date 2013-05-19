#!/bin/bash

#echo $(printf '\"%s\"' $@);
mplayer "\"$@\""
#mplayer $@ &> /dev/null
