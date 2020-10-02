#!/bin/bash

set -e

# Create netics-logout.desktop
autostart_dir=/home/.skjult/.config/autostart

if [ ! -d "$autostart_dir" ]
then
    mkdir -p $autostart_dir
fi

# Cleanup old runs
rm -f $autostart_dir/*netics*

cat <<NETICS-LOGOUT-DESKTOP > $autostart_dir/netics-logout.desktop
[Desktop Entry]
Type=Application
Exec=wget https://hotspot.sonderborg.dk/auth/action/logout -O /dev/null
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=Netics Logout
NETICS-LOGOUT-DESKTOP