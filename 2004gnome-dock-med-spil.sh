#!/usr/bin/env bash

# Set default applications in Gnome dock

cat > /etc/profile.d/bibsdb-default-apps-gnome-dock.sh << EOF
#!/usr/bin/env bash
# Set default applications in gnome dock
gsettings set org.gnome.shell favorite-apps "['google-chrome.desktop', 'firefox.desktop', 'org.gnome.Nautilus.desktop', 'minecraft-launcher.desktop', 'libreoffice-writer.desktop', 'libreoffice-calc.desktop', 'libreoffice-impress.desktop', 'pinta.desktop', 'logout.desktop']"
EOF
