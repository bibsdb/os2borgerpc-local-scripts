#!/usr/bin/env bash

# Adds Google Chrome to unattended upgrades
CONF="/etc/apt/apt.conf.d/90os2borgerpc-automatic-upgrades"

sed -i '/Unattended-Upgrade::Allowed-Origins {/a\"Google\\, Inc.:stable\";' "CONF"

