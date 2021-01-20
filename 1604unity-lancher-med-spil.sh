#!/bin/bash
cat > /etc/profile.d/bibsdb-default-apps-unity-launcher.sh << EOF
#!/usr/bin/env bash
# Set default applications in unity launcher
gsettings set com.canonical.Unity.Launcher favorites "['application://google-chrome.desktop', 'application://firefox.desktop', 'application://org.gnome.Nautilus.desktop', 'application://minecraft-launcher.desktop', 'application://libreoffice-writer.desktop', 'application://libreoffice-calc.desktop', 'application://libreoffice-impress.desktop', 'application://pinta.desktop', 'application://logout.desktop', 'unity://running-apps', 'unity://expo-icon', 'unity://devices']"
EOF
