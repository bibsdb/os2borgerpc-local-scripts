#!/usr/bin/env bash
# Restart computer at 07:10 to clear memory

TCRON=/tmp/oldcron

crontab -l > $TCRON

if [ -f $TCRON ]
then

    # Delete old entries
    sed -i -e "/\shutdown/d" $TCRON
    crontab $TCRON

    # Add daily reboot
    echo "10 7  * * * /sbin/shutdown -r" >> $TCRON
    crontab $TCRON

    rm $TCRON
fi