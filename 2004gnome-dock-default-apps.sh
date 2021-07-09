#!/usr/bin/env bash

# Create desktop-shortcut for google chrome with password-store=basic
chrome_text="[Desktop Entry]\nType=Application\nExec=google-chrome-stable --password-store=basic --start-maximized\nHidden=false\nNoDisplay=false\nX-GNOME-Autostart-enabled=true\nIcon=google-chrome\nName[en_US]=Chrome\nName=Chrome\nComment[en_US]=run the Google-chrome webbrowser at startup\nComment=run the Google-chrome webbrowser at startup\nName[en]=Chrome\n"
chrome_desktop_file="/usr/share/applications/chrome.desktop"
printf  "$chrome_text" > "$chrome_desktop_file"

# Create logout desktop shortcut
logout_text="[Desktop Entry]\nName=Logout\nComment=Log out of your account.\nGenericName=Log Out\nExec=gnome-session-quit --logout\nTerminal=false\nType=Application\nCategories=Utility\nIcon=gnome-logout\n"
logout_desktop_file="/usr/share/applications/logout.desktop"
printf  "$logout_text" > "$logout_desktop_file"

# Set default applications in Gnome dock
cat > /etc/profile.d/bibsdb-default-apps-gnome-dock.sh << EOF
#!/usr/bin/env bash
# Set default applications in gnome dock
gsettings set org.gnome.shell favorite-apps "['chrome.desktop', 'firefox.desktop', 'org.gnome.Nautilus.desktop', 'libreoffice-writer.desktop', 'libreoffice-calc.desktop', 'libreoffice-impress.desktop', 'pinta.desktop', 'logout.desktop']"
EOF
