#!/usr/bin/env bash
# This script will enable or disable the inbuild cleanup-service

if [ $# -ne 1 ]
then
  echo "Dette script tager en parameter: aktiver/deaktiver"
  exit -1
fi
if [ "$1" == "aktiver" ]
then
  # Remove old entries
  sed -i '/user-cleanup.bash/d' /etc/lightdm/lightdm.conf
  # Add line
  echo "session-cleanup-script=/usr/share/os2borgerpc/bin/user-cleanup.bash" >> /etc/lightdm/lightdm.conf
  systemctl daemon-reload
  systemctl enable os2borgerpc-cleanup.service
  systemctl start os2borgerpc-cleanup.service
  echo "Automated cleanup has been enabled."
  exit 0
elif [ "$1" == "deaktiver" ]
then
  # Remove line
  sed -i '/user-cleanup.bash/d' /etc/lightdm/lightdm.conf
  systemctl daemon-reload
  systemctl disable os2borgerpc-cleanup.service
  systemctl stop os2borgerpc-cleanup.service
	echo "Automated cleanup has been disabled."
	exit 0
else
  echo "Unsupported parameter"
  exit -1
fi