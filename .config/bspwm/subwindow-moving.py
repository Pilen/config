#!/usr/bin/env python3

import json
import subprocess
import sys

UP = "UP"
DOWN = "DOWN"
LEFT = "LEFT"
RIGHT = "RIGHT"

directions_input = {
    "up": UP,
    "north": UP,
    "above": UP,

    "down": DOWN,
    "south": DOWN,
    "below": DOWN,

    "right": RIGHT,
    "east": RIGHT,

    "left": LEFT,
    "west": LEFT,
}

def emacs(direction):
    emacs_directions = {
        UP: "above",
        DOWN: "below",
        LEFT: "left",
        RIGHT: "right",
    }

    windmove_directions = {
        UP: "up",
        DOWN: "down",
        LEFT: "left",
        RIGHT: "right",
    }

    command = "(when (window-in-direction '{}) (windmove-{}) t)".format(emacs_directions[direction], windmove_directions[direction])
    emacs = subprocess.Popen(["emacsclient", "-e", command], stdout=subprocess.PIPE, universal_newlines=True).stdout.read().strip()
    if emacs == "t":
        return True
    if emacs == "nil":
        return False
    print("Bad output from Emacs")
    return None

def bspwm(direction):
    bspwm_directions = {
        UP: "north",
        DOWN: "south",
        LEFT: "west",
        RIGHT: "east",
    }
    subprocess.Popen(["bspc", "node", "-f", bspwm_directions[direction]])
    return True



def main():
    direction = directions_input[sys.argv[1].lower()]

    bspc = subprocess.Popen(["bspc", "query", "-T", "-n", "focused"], stdout=subprocess.PIPE, universal_newlines=True)
    query = json.loads(bspc.stdout.read())
    moved = False
    try:
        if query["client"]["className"] == "Emacs":
            moved = emacs(direction)
    except:
        pass
    try:
        if not moved:
            bspwm(direction)
    except:
        pass



if __name__ == "__main__":
    main()
