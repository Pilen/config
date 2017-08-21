#!/usr/bin/env python
import json
import sys

try:
    raw = sys.stdin.read()
    json = json.loads(raw)
    with open("/tmp/output", "w") as f:
        if json["client"]:
            # This is a leaf
            print(sys.argv[1])
            f.write("A\n")
        else:
            # This is a branch
            print(sys.argv[2])
            f.write("B\n")
except Exception as e:
    print("ERROR", e)
    with open("/tmp/output", "w") as f:
        f.write("ERROR!")
