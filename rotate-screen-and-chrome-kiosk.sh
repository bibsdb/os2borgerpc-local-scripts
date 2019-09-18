#!/bin/bash

set -e


if [ $# -ne 1 ]
then
    echo "Dette script skal bruge en parameter: URL på OS2display"
    exit -1
fi

site=$1


# Create exec script for Chrome
cat > /home/.skjult/.chrome.sh << EOF
#!/usr/bin/env bash

# Rotate screen if vertical
if [[ \$HOSTNAME == *"rotateright"* ]]; then
  xrandr -o right
fi
if [[ \$HOSTNAME == *"rotateleft"* ]]; then
  xrandr -o left
fi

sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' /home/.skjult/.config/google-chrome/Default/Preferences
sed -i 's/"exit_type":"Crashed"/"exit_type":"None"/' /home/.skjult/.config/google-chrome/Default/Preferences
sed -i 's/"restore_on_startup":[0-9]/"restore_on_startup":0/' /home/.skjult/.config/google-chrome/Default/Preferences
google-chrome --kiosk $site --full-screen --password-store=basic
EOF

chmod +x /home/.skjult/.chrome.sh


# Make the Chrome-script autostart
autostart_dir=/home/.skjult/.config/autostart

if [ ! -d "$autostart_dir" ]
then
    mkdir -p $autostart_dir
fi

rm -f $autostart_dir/*chrome*

cat <<CHROME-DESKTOP > $autostart_dir/chrome.desktop
[Desktop Entry]
Type=Application
Exec=/home/.skjult/.chrome.sh
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name[en_US]=Chrome
Name=Chrome
Comment[en_US]=run the Google-chrome webbrowser at startup
Comment=run the Google-chrome webbrowser at startup
Name[en]=Chrome
CHROME-DESKTOP


exit 0
