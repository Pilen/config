#!/bin/sh

xset -dpms
xset s off
google-chrome-stable --kiosk --start-maximized
xset +dpms
xset s on
