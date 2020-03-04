#!/usr/bin/env bash
# Logout user at 06:15

TCRON=/tmp/oldcron

crontab -l > $TCRON

if [ -f $TCRON ]
then

    # Delete old entries
    sed -i -e "/\pkill/d" $TCRON
    crontab $TCRON

    # Add logout of user to crontab
    echo "15 6  * * * pkill -KILL -u user" >> $TCRON
    crontab $TCRON

    rm $TCRON
fi
