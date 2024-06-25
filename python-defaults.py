import sys
import datetime
from datetime import datetime as dt
import re
import subprocess
import pathlib
from pathlib import Path
import random
import collections
import pprint
from pprint import pprint as pp
import itertools
import functools
import argparse

d = {"a":"A", "b":"B", "c":"C"}
l = [1, 2, 3]


def make_password(length: int = 16):
    import secrets
    import string
    return "".join(secrets.choice(string.ascii_letters + "0123456789") for _ in range(length))
