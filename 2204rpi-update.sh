#!/usr/bin/env sh

# Enable software updates of RPI with OverlayFS enabled
# Works by turning off OverlayFS for two 72 hour periods each month.
#
# In these periods Ubuntus unattended upgrades will be applied and persisted in the underlying filesystem.
# The 72 hour period is choosen because it allows for two reboots to take place within the period,
# so that any post-install hooks are executed correctly.
#
# This still means that the SD-card is spared from writes for 24 days each month ( 80% of the time).


set -x

cat << EOF > /usr/local/bin/enable-overlayfs.sh
#!/usr/bin/env sh

set -ex

ENABLE_OVERLAYROOT=\$1
if [ "\$ENABLE_OVERLAYROOT" = "True" ]; then
  echo 'overlayroot="tmpfs"' > /etc/overlayroot.local.conf
  echo "Reboot now - Overlay root filesystem will be enabled."
  reboot now
else
  if ! overlayroot-chroot /bin/bash -c "echo 'overlayroot=disabled' > /etc/overlayroot.local.conf"; then
    echo "ERR: could not run command in overlayrootfs, is it already disabled?"
  else
    echo "Reboot now  - Overlay root filesystem will be disabled."
    reboot now
  fi
fi
EOF

chmod +x /usr/local/bin/enable-overlayfs.sh

# Write out current crontab
crontab -l > mycron

# Check if the crontab already contains the reboot command
if grep -q "enable-overlayfs" mycron; then
    # If it does, delete the line
    sed -i '/enable-overlayfs/d' mycron
fi

# Disable OverlayFS
echo "30 7 1,15 * * /usr/local/bin/enable-overlayfs.sh False" >> mycron
# Enable OverlayFS
echo "30 7 4,18 * * /usr/local/bin/enable-overlayfs.sh True" >> mycron
# Install new cron file
crontab mycron
rm mycron

