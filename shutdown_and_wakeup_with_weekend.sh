#!/usr/bin/env bash
#================================================================
# HEADER
#================================================================
#% SYNOPSIS
#+    shutdown_and_wakeup.sh --args <hours> <minutes> <hours>
#%
#% DESCRIPTION
#%    This is a script to make a OS2BorgerPC machine shutdown at a certain time.
#%    Synopsis:
#%
#%      shutdown_and_wakeup.sh <hours> <minutes> <hours>
#%
#%    to enable shutdown mechanism.
#%
#%      shutdown_and_wakeup.sh --off
#%
#%    to disable.
#%
#%    We'll suppose the user only wants to have regular shutdown once a day
#%    as specified by the <hours> and <minutes> parameters. Thus, any line in
#%    crontab already specifying a shutdown will be deleted before a new one is
#%    inserted.
#%    We'll also suppose the user wants the machine to wakeup after X numbers
#%     of hours after shutdown everyday.
#%
#================================================================
#- IMPLEMENTATION
#-    version         shutdown_and_wakeup.sh (magenta.dk) 0.0.1
#-    author          Danni Als
#-    copyright       Copyright 2018, Magenta Aps"
#-    license         GNU General Public License
#-    email           danni@magenta.dk
#-
#================================================================
#  HISTORY
#     2018/12/12 : danni : Script creation - based on shutdown_at_time.sh
#
#================================================================
# END_OF_HEADER
#================================================================

TCRON=/tmp/oldcron
USERCRON=/tmp/usercron
MESSAGE="Denne computer lukker ned om fem minutter"

crontab -l > $TCRON
sudo -u user crontab -l > $USERCRON


if [ "$1" == "--off" ]
then

    if [ -f $TCRON ]
    then
        sed -i -e "/\/rtcwake/d" $TCRON
        crontab $TCRON
    fi

    if [ -f $USERCRON ]
    then
        sed -i -e "/lukker/d" $USERCRON
        sudo -u user crontab $USERCRON
    fi

else

    if [ $# == 6 ]
    then
        HOURS_WEEKDAY=$1
        MINUTES_WEEKDAY=$2
        SECONDS_TO_WAKEUP_WEEKDAY=$(expr 3600 \* $3)

	HOURS_WEEKEND=$4
        MINUTES_WEEKEND=$5
        SECONDS_TO_WAKEUP_WEEKEND=$(expr 3600 \* $6)

        # We still remove shutdown lines, if any
        if [ -f $TCRON ]
        then
            sed -i -e "/\/rtcwake/d" $TCRON
        fi
        if [ -f $USERCRON ]
        then
            sed -i -e "/lukker/d" $USERCRON
        fi
        # Assume the parameters are already validated as integers.
        echo "$MINUTES_WEEKDAY $HOURS_WEEKDAY * * 1-5 /usr/sbin/rtcwake -m off -s $SECONDS_TO_WAKEUP_WEEKDAY" >> $TCRON
	echo "$MINUTES_WEEKEND $HOURS_WEEKEND * * 6,0 /usr/sbin/rtcwake -m off -s $SECONDS_TO_WAKEUP_WEEKEND" >> $TCRON
        crontab $TCRON
	
	#WEEKDAYS
        MINM5P60=$(expr $(expr $MINUTES_WEEKDAY - 5) + 60)
        # Rounding minutes
        MINS=$(expr $MINM5P60 % 60)
        HRCORR=$(expr 1 - $(expr $MINM5P60 / 60))
        HRS=$(expr $HOURS_WEEKDAY - $HRCORR)
        HRS=$(expr $(expr $HRS + 24) % 24)
        # Now output to user's crontab as well
        echo "$MINS $HRS * * 1-5 DISPLAY=:0.0 /usr/bin/notify-send \"$MESSAGE\"" >> $USERCRON

	#WEEKENDS
	MINM5P60=$(expr $(expr $MINUTES_WEEKEND - 5) + 60)
        # Rounding minutes
        MINS=$(expr $MINM5P60 % 60)
        HRCORR=$(expr 1 - $(expr $MINM5P60 / 60))
        HRS=$(expr $HOURS_WEEKEND - $HRCORR)
        HRS=$(expr $(expr $HRS + 24) % 24)
        # Now output to user's crontab as well
        echo "$MINS $HRS * * 6,0 DISPLAY=:0.0 /usr/bin/notify-send \"$MESSAGE\"" >> $USERCRON

        sudo -u user crontab $USERCRON

    else
        echo "Usage: shutdown_and_wakeup.sh [--off] [hours minutes] [hours]"
    fi

fi

if [ -f $TCRON ]
then
    rm $TCRON
fi
