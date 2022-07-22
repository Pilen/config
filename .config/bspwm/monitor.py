#!/usr/bin/python3

import subprocess

handlers = dict()
def handler(function):
    handlers[function.__name__] = function
    return function

def main():
    bspc = subprocess.Popen(["bspc", "subscribe", "monitor_add", "monitor_remove"], stdout=subprocess.PIPE, universal_newlines=True)

    for line in bspc.stdout:
        line = line.strip()
        print(line)
        words = line.split()
        command = words[0]
        rest = words[1:]
        if command in handlers:
            handlers[command](*rest)
        else:
            print("ERROR: Unknown command")

@handler
def monitor_add(id, name, geometry):
    if name == "LVDS1":
        return
    subprocess.run(["bspc", "desktop", "Ex1", "-m", name])
    subprocess.run(["bspc", "desktop", "Ex1", "-f"])
    subprocess.run(["bspc", "desktop", "Desktop", "-r"])

@handler
def monitor_remove(id):
    subprocess.run(["bspc", "desktop", "Ex1", "-m", "LVDS1"])


if __name__ == "__main__":
    main()
