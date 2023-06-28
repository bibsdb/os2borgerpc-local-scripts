#!/usr/bin/env bash

# Remove old elo touch driver
systemctl stop elo.service
systemctl disable elo.service
rm -rf /etc/systemd/system/elo.service
rm -rf /etc/opt/elo-mt-usb
rm -rf /etc/udev/rules.d/99-elotouch.rules
reboot now