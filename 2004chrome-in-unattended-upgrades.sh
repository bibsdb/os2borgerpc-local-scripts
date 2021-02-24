#!/usr/bin/env bash

# Delete old Google entries
sudo sed -i '/Google/d' /etc/apt/apt.conf.d/90os2borgerpc-automatic-upgrades

# Add Google Chrome to unattended upgrades
sudo sed -i '/Unattended-Upgrade::Allowed-Origins {/a\"Google LLC:stable\";' /etc/apt/apt.conf.d/90os2borgerpc-automatic-upgrades

