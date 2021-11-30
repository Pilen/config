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

    try:
        command = "(when (window-in-direction '{}) (windmove-{}) t)".format(emacs_directions[direction], windmove_directions[direction])
        emacs = subprocess.run(["emacsclient", "-e", command], timeout=1, stdout=subprocess.PIPE, universal_newlines=True).stdout.strip()
        if emacs == "t":
            return True
        if emacs == "nil":
            return False
    except Exception:
        pass
    print("Bad output from Emacs")
    return None

def emacs_reset(direction):
    emacs_directions = {
        UP: "below",
        DOWN: "above",
        LEFT: "right",
        RIGHT: "left",
    }
    windmove_directions = {
        UP: "down",
        DOWN: "up",
        LEFT: "right",
        RIGHT: "left",
    }
    try:
        command = "(while (window-in-direction '{}) (windmove-{}))".format(emacs_directions[direction], windmove_directions[direction])
        print(command)
        emacs = subprocess.run(["emacsclient", "-e", command], timeout=1)
    except Exception:
        pass
    return None


def bspwm(direction):
    bspwm_directions = {
        UP: "north",
        DOWN: "south",
        LEFT: "west",
        RIGHT: "east",
    }
    try:
        status = subprocess.run(["bspc", "node", "-f", bspwm_directions[direction]]).returncode
        return status == 0 # True if moved
    except Exception:
        pass
    return None

def current_window():
    try:
        bspc = subprocess.run(["bspc", "query", "-T", "-n", "focused"], stdout=subprocess.PIPE, universal_newlines=True).stdout
        query = json.loads(bspc)
        return query["client"]["className"]
    except Exception:
        print(e)
        return None

def main():
    direction = directions_input[sys.argv[1].lower()]
    moved = False
    if current_window() == "Emacs":
        moved = emacs(direction)
    if not moved:
        moved = bspwm(direction)
        if moved:
            if current_window() == "Emacs":
                # If moved, and window is now Emacs, we should slide to the outer edge in the opposite (incomming) direction.
                emacs_reset(direction)



if __name__ == "__main__":
    main()
