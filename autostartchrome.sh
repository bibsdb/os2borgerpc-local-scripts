#!/usr/bin/env bash

# This script will symlink the chrome.desktop file to /home/.skjult/.autostart which will make chrome run at boot

autostart_dir=/home/.skjult/.config/autostart

if [ ! -d "$autostart_dir" ]
then
    mkdir -p $autostart_dir
fi

# Cleanup old runs
rm -f $autostart_dir/*chrome*

# Create symlink to google-chrome.desktop
ln -s /home/.skjult/.local/share/applications/google-chrome.desktop $autostart_dir/google-chrome.desktop