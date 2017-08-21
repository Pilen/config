#!/usr/bin/env python3

import argparse
import subprocess
import sys
import tempfile
import time
from selenium import webdriver


def modify():
    driver = webdriver.Chrome()

    login = "admin:1234spacey@"
    driver.get("http://"+login+"192.168.0.1/WirelessSettings.htm")

    ssid = driver.find_element_by_css_selector("input[name=ssid]")
    ssid.clear()
    ssid.send_keys("tigersnet2")

    passphrase = driver.find_element_by_css_selector("input[name=passphrase]")
    passphrase.clear()
    passphrase.send_keys("haffelaf")


    ssid_an = driver.find_element_by_css_selector("input[name=ssid_an]")
    ssid_an.clear()
    ssid_an.send_keys("tigersnet")

    passphrase_an = driver.find_element_by_css_selector("input[name=passphrase_an]")
    passphrase_an.clear()
    passphrase_an.send_keys("haffelaf")


    apply = driver.find_element_by_css_selector("button[name=Apply]")
    apply.click()

    driver.quit()


def wired():
    interface = "enp0s25"
    ip_link = subprocess.run(["sudo", "killall", "-q", "wpa_supplicant", "dhcpcd", "dhclient"])
    # sys.exit(-1)
    # ip_link = subprocess.check_output(["sudo", "ip", "link", "set", "wlp3s0", "down"], universal_newlines=True)
    ip_link = subprocess.check_output(["sudo", "ip", "link", "set", interface, "up"], universal_newlines=True)
    ip_link = subprocess.check_output(["sudo", "dhclient", "-v", interface], universal_newlines=True)

    modify()
    ip_link = subprocess.check_output(["sudo", "ip", "link", "set", interface, "down"], universal_newlines=True)

    # ip_link = subprocess.check_output(["sudo", "net.py"], universal_newlines=True)

def wireless():
    interface = "wlp3s0"
    driver = "wext"

    ssid="3d77mg74"
    password="ksq9vmga"
    wpa_passphrase = subprocess.check_output(["sudo", "wpa_passphrase", ssid, password], universal_newlines=True)
    with tempfile.TemporaryDirectory() as d:
        config = d + "/" + "tmp.conf"
        with open(config, "w") as fp:
            fp.write(wpa_passphrase)
        try:
            wpa_supplicant = subprocess.Popen(["sudo", "wpa_supplicant", "-i", interface, "-D", driver, "-c", config, "-B"], universal_newlines=True)
            time.sleep(2)
            dhcp_client = subprocess.check_output(["sudo", "dhclient", "-v", interface], universal_newlines=True)
            time.sleep(2)

            modify()

            killall = subprocess.check_output(["sudo", "killall", "-q", "wpa_supplicant", "dhclient"], universal_newlines=True)
        except subprocess.CalledProcessError as e:
            print("ERROR", e)
            sys.exit(-1)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--wired", default=None, action="store_true")
    parser.add_argument("--wireless", default=None, action="store_true")
    parser.add_argument("--on-current", default=None, action="store_true")
    args = parser.parse_args()

    if args.wired:
        wired()
    elif args.wireless:
        wireless()
    elif args.on_current:
        modify()
    else:
        wireless()
