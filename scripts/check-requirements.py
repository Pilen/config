#!/usr/bin/env python3
"""Check what dependencies are out of date for a python project

"""
import argparse
import datetime
import re
import sys

import requests

regex = re.compile("^( *)([a-zA-Z0-9a_.-]+)( *)(==)( *)([0-9a-bA-B._-]+)( *)$")
class Error(Exception):
    pass

def human_time(old, new):
    old = datetime.datetime.strptime(old, "%Y-%m-%dT%H:%M:%S")
    new = datetime.datetime.strptime(new, "%Y-%m-%dT%H:%M:%S")
    delta = new - old
    days = delta.days
    plural = "s" if days != 1 else ""
    return "{} day{}".format(days, plural)

def fetch(project):
    r = requests.get("https://www.pypi.org/pypi/{}/json".format(project))
    if r.ok:
        return r.json()
    else:
        raise Error("Error! Could not find info about {}, reason:\n{}".format(project, r.reason))

def check_project(project, version):
    json = fetch(project)
    releases = json["releases"]
    filtered = ((k, v) for k, v in releases.items() if len(v) > 0)
    version_dates = {version: sorted(entry["upload_time"] for entry in entries)[0]
                     for version, entries in filtered}
    versions = sorted(version_dates.keys(), key=lambda version: version_dates[version])
    newest = versions[-1]
    if version not in versions:
        raise Error("Error! {} has no release of {}".format(project, version))
    difference = len(versions) - versions.index(version) - 1
    return (newest, difference, version_dates[version], version_dates[newest])

def check(requirements):
    for line in requirements:
        line = line.strip()
        if line.startswith("#"):
            continue
        match = regex.match(line)
        if not match:
            if "==" not in line:
                print("{} has no specified version".format(line))
            elif "*" in line:
                print("Dont yet know how to handle wildcards")
            elif len(line.strip()) > 0:
                print("Did not know how to handle {}".format(line))
            continue

        groups = list(match.groups())
        project = groups[1]
        version = groups[5]
        try:
            newest, difference, old_date, new_date = check_project(project, version)
            if difference == 0:
                # print("{} is up to date".format(project))
                continue
            else:
                plural = "s" if difference > 1 else ""
                print("{} is {} release{} ({}) behind: {} -> {}".format(project, difference, plural, human_time(old_date, new_date), version, newest))
        except Error as e:
            print(e)
def update(requirements, destination):
    result = []
    for line in requirements:
        line = line.strip("\n")
        match = regex.match(line)
        if not match:
            result.append(line)
            continue
        groups = list(match.groups())
        project = groups[1]
        version = groups[5]
        try:
            newest, difference, old_date, new_date = check_project(project, version)
            groups[5] = newest
            result.append("".join(groups))
        except Error as e:
            result.append(line)

    with open(destination, mode="w") as f:
        f.write("\n".join(result))
        f.write("\n")

def main():
    description, epilog = __doc__.split("\n", 1)
    parser = argparse.ArgumentParser(description=description, epilog=epilog)
    parser.add_argument("requirements", type=argparse.FileType("r"), help="The requirements file to check")
    parser.add_argument("-u", "--update", default=False, action="store_const", const=True, help="Update the requirements file inplace")
    args = parser.parse_args()
    if args.update:
        update(args.requirements, args.requirements.name)
    else:
        check(args.requirements)


if __name__ == "__main__":
    main()
