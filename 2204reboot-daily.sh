#!/bin/bash

# Write out current crontab
crontab -l > mycron

# Check if the crontab already contains the reboot command
if grep -q "/sbin/shutdown -r now" mycron; then
    # If it does, delete the line
    sed -i '/\/sbin\/shutdown -r now/d' mycron
fi

# Echo new cron into cron file
echo "10 7 * * * /sbin/shutdown -r now" >> mycron
# Install new cron file
crontab mycron
rm mycron