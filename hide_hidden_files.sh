#!/usr/bin/env bash

# Creates a script and saves it in /etc/profile.d. The script hides hidden files by default.

cat > /etc/profile.d/bibsdb-hide-hidden-files.sh << EOF
#!/usr/bin/env bash
# This script will run at boot. The script hides hidden files by default.
gsettings set org.gtk.Settings.FileChooser show-hidden false
EOF


