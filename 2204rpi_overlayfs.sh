#!/bin/sh

# DESCRIPTION
# Made for OS2borgerpc kiosk.
#
# This script will enables / disables the overlay filesystem thereby making the root-partition ro/rw.
# Any changes made requires a reboot to take effect.
#
# PARAMETERS
# 1. Checkbox. Enables or disables overlay filesystem

set -ex

ENABLE_OVERLAYROOT=$1
if [ "$ENABLE_OVERLAYROOT" = "True" ]; then
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
