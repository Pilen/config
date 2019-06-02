#!/usr/bin/python3

import argparse
import getpass
import itertools
import os
import re
import subprocess
import sys
import time


# TODO: create /root/networks if it doesn't exist

ip_link = subprocess.check_output(["ip", "link", "show"], universal_newlines=True)
default_interface = [interface for interface in re.findall("[0-9]+: ([^:]*): <", ip_link) if interface.startswith("wlp")][0]

default_driver = "wext"
default_config_directory = "/root/networks/"
default_config_prefix = "wpa_supplicant.prefix"
default_wpa_config = "wpa_supplicant.conf"

parser = argparse.ArgumentParser()
parser.add_argument("-s", "--scan", "--scan-networks", help="Scan available networks in the area", action="store_true")
parser.add_argument("-l", "--list", "--list-profiles", help="List network profiles", action="store_true")
parser.add_argument("-j", "--join", help="Create and connect to network profile", default=None, const=" ", nargs="?")
parser.add_argument("--create", help="Create a network profile", default=None, const=" ", nargs="?")
parser.add_argument("--delete", help="Delete a network profile", default=None)
parser.add_argument("-d", "--disconnect", help="Disconnect from all networks", action="store_true")

parser.add_argument("--interface", help="Specify an interface", default=default_interface)
parser.add_argument("--driver", help="Specify a driver", default=default_driver)
parser.add_argument("--config_directory", help="Specify directory to store configuration", default=default_config_directory)
parser.add_argument("-p", "--prefix", help="Specify a prefix for the configuration", default=[], action="append")
parser.add_argument("--prefix_file", help="Specify a prefix file for the configuration", default=default_config_prefix)
parser.add_argument("--wpa_config", help="Specifythe configuration file name", default=default_wpa_config)

parser.add_argument("-i", "--ignore", help="Ignore profile", default=[], action="append")
parser.add_argument("networks", help="Specify network(s) to connect, leave empty for any", nargs="*")
args = parser.parse_args()

interface = args.interface
driver = args.driver
config_directory = args.config_directory
config_prefix_file = args.prefix_file
wpa_config = args.wpa_config
prefixes = args.prefix

def pairwise(iterable):
    "s -> (s0, s1), (s2, s3), (s4, s5), ..."
    a = iter(iterable)
    return zip(a, a)

class Network:
    def __init__(self, ssid):
        self.ssid = ssid

def get_available_networks():
    up = subprocess.check_output(["ip", "link", "set", interface, "up"], universal_newlines=True)
    iwlist = subprocess.check_output(["iwlist", interface, "scan"], universal_newlines=True)


    networks = re.findall('ESSID:"([^)]*)\"', iwlist)
    unique_set = set(networks)
    unique = [network for network in networks if network in unique_set]
    return unique


def get_profiles():
    profiles = [file[:-len(".profile")] for file in os.listdir(config_directory) if file.endswith(".profile")]
    profiles.sort()
    return profiles


def create_profile(ssid, must_be_in=None):
    try:
        if not ssid or ssid == " ":
            ssid = input("Network ssid/name: ")

        if ssid.strip() == "":
            print("ERROR: Invalid network name")
            sys.exit(-1)

        if must_be_in is not None and ssid not in must_be_in:
            print("ERROR: No such network available")
            sys.exit(-1)

        password = getpass.getpass()
        os.makedirs(config_directory, exist_ok=True)
        filename = config_directory + ssid + ".profile"
        wpa_passphrase = subprocess.check_output(["wpa_passphrase", ssid, password], universal_newlines=True)
        with open(filename, "w") as profile:
            profile.write("# This file has been created by net.py, modify at own risk\n\n")
            profile.write(wpa_passphrase)

        return ssid

    except subprocess.CalledProcessError:
        print("ERROR: Password must be between 8 and 63 characters")
        sys.exit(-1)
    except PermissionError:
        print("ERROR: Permission denied:", filename)
        sys.exit(-1)
    except FileNotFoundError:
        print("ERROR: Directory does not exist:", config_directory)
        sys.exit(-1)


def delete(ssid):
    os.remove(config_directory + ssid + ".profile")


def create_wpa_config(networks):
    if not networks:
        networks = get_profiles()

    if len(networks) == 0:
        print("No profiles specified")
        sys.exit(-1)

    with open(config_directory + wpa_config, "w") as config:
        config.write("# This file has been created by net.py, do not modify!\n\n")
        try:
            with open(config_directory + config_prefix_file) as prefix:
                config.write(prefix.read())
        except FileNotFoundError:
            pass

        for prefix in prefixes:
            config.write(prefix)

        found = 0
        for network in networks:
            try:
                with open(config_directory + network + ".profile") as profile:
                    config.write(profile.read())
                found += 1
            except FileNotFoundError:
                print("Network profile not found:", network)

        if found == 0:
            print("None of the network profiles were found")
            sys.exit(-1)


def disconnect():
    try:
        killall = subprocess.check_output(["killall", "-q", "wpa_supplicant", "dhclient"], universal_newlines=True)
    except subprocess.CalledProcessError as e:
        print("No network process running")


def connect():
    disconnect()
    try:
        command = ["wpa_supplicant", "-i", interface, "-D", driver, "-c", config_directory + wpa_config, "-B"]
        print(" ".join(command))
        wpa_supplicant = subprocess.Popen(command, universal_newlines=True)
        time.sleep(2)
        dhcp_client = subprocess.check_output(["dhclient", "-v", interface], universal_newlines=True)
        print(dhcp_client)
    except subprocess.CalledProcessError as e:
        print("ERROR", e)
        sys.exit(-1)

    try:
        s = subprocess.check_output(["ping", "-c", "1", "-W", "1", "8.8.8.8"])
        # if subprocess.check_output(["ping", "-c", "1", "-W", "1", "8.8.8.8"]):
        if s:
            print("Successfully connected to the internet")
        else:
            print("No internet connection")
    except subprocess.CalledProcessError:
        print("No internet connection")

def run_hooks():
    for file in sorted(os.listdir(config_directory)):
        if file.endswith(".hook"):
            hook_output = subprocess.check_output([config_directory + file], universal_newlines)
            print(hook_output)

def main():
    try:
        if args.scan:
            profiles = set(get_profiles())
            networks = get_available_networks()
            available = False
            print("Found networks:")
            for network in networks:
                if network in profiles:
                    print(network + "*")
                    available = True
                else:
                    print(network)
            if available:
                print("\n* Profile with matching name exists.")

        elif args.list:
            profiles = get_profiles()
            if len(profiles) == 0:
                print("No profiles")
            else:
                print("Profiles:")
                print("\n".join(profiles))

        elif args.create:
            create_profile(args.create)

        elif args.join:
            networks = get_available_networks()
            ssid = create_profile(args.join, networks)
            create_wpa_config(ssid)
            connect()

        elif args.delete:
            delete(args.delete)

        elif args.disconnect:
            disconnect()
        else:
            create_wpa_config(args.networks)
            connect()
    except KeyboardInterrupt:
        print("\nConnection interrupted")


if __name__ == "__main__":
    main()
