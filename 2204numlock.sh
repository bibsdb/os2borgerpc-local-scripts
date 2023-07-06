#!/bin/sh

# DESCRIPTION
# Made for OS2borgerpc kiosk running Chromium.
#
# This script will install numlockx and enable it when chromium starts.
# Any changes made requires a reboot to take effect.
#
# PARAMETERS
# 1. Checkbox. Enables or disables numlock

set -ex

NUMLOCK_ON=$1


if [ "$NUMLOCK_ON" = "True" ]; then
    if [ ! -f "/usr/bin/numlockx" ]; then
        apt-get update -qq > /dev/null
        apt-get -yqq install numlockx
    fi

    # Remove all lines that contains the string "numlockx"
    sed -i '/numlockx/d' /home/chrome/.xinitrc
    # Insert a line as second line in the file. Insert "/usr/bin/numlockx on"
    sed -i '2 i\/usr/bin/numlockx on' /home/chrome/.xinitrc

else 
    if [ -f "/usr/bin/numlockx" ]; then 
        apt-get remove -yqq numlockx
    fi
    # Remove all lines that contains the string "numlockx"
    sed -i '/numlockx/d' /home/chrome/.xinitrc
fi