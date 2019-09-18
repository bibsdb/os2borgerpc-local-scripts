#!/usr/bin/env bash

# Creates a script and saves it in /etc/profile.d. The script removes shutdown from the from the user switcher menu

cat > /etc/profile.d/bibsdb-remove-shutdown.sh << EOF
#!/usr/bin/env bash
# This script will run at boot. It removes shutdown from the from the user switcher menu
gsettings set com.canonical.indicator.session suppress-shutdown-menuitem true
gsettings set com.canonical.indicator.session suppress-logout-restart-shutdown true
EOF





	


