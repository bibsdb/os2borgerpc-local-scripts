#!/usr/bin/env bash

# Set default applications in unity launcher

cat > /etc/profile.d/bibsdb-default-apps-unity-launcher.sh << EOF
#!/usr/bin/env bash
# Set default applications in unity launcher
gsettings set com.canonical.Unity.Launcher favorites "['application://google-chrome.desktop', 'application://firefox.desktop', 'application://org.gnome.Nautilus.desktop', 'application://libreoffice-writer.desktop', 'application://libreoffice-calc.desktop', 'application://libreoffice-impress.desktop', 'application://pinta.desktop', 'application://logout.desktop', 'unity://running-apps', 'unity://expo-icon', 'unity://devices']"
EOF

# Remove Amazon
if [ -f /usr/share/applications/ubuntu-amazon-default.desktop ]; then
  mv /usr/share/applications/ubuntu-amazon-default.desktop /usr/share/applications/ubuntu-amazon-default.desktop.bak
fi

# Remove Ubuntu Software Center
if [ -f /usr/share/ubuntu/applications/org.gnome.Software.desktop ]; then
  mv /usr/share/ubuntu/applications/org.gnome.Software.desktop /usr/share/ubuntu/applications/org.gnome.Software.desktop.bak
fi
