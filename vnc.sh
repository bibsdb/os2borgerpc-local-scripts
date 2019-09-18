#!/bin/bash

set -e

if [ $# -ne 1 ]
then
    echo "Dette script skal bruge en parameter: VNC Adgangskode"
    exit -1
fi

password=$1

# Make the Vino VNC autostart
autostart_dir=/home/.skjult/.config/autostart

if [ ! -d "$autostart_dir" ]
then
    mkdir -p $autostart_dir
fi

rm -f $autostart_dir/*vino-server*

cat <<VINO-DESKTOP > $autostart_dir/vino-server.desktop
[Desktop Entry]
Type=Application
Name=Vino VNC server
Exec=/usr/lib/vino/vino-server
NoDisplay=true
VINO-DESKTOP

# Creates a script and saves it in /etc/profile.d. Settings for the Vino VNC server
# This script will run at boot.

cat > /etc/profile.d/bibsdb-vino-settings.sh << EOF
gsettings set org.gnome.Vino enabled true
gsettings set org.gnome.Vino prompt-enabled false
gsettings set org.gnome.Vino authentication-methods "['vnc']"
gsettings set org.gnome.Vino require-encryption false
gsettings set org.gnome.Vino vnc-password $(echo -n "$password"|base64)
EOF





