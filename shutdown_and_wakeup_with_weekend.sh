#!/usr/bin/env bash

# Create cron logout script
cat <<CRON-LOGOUT > /home/superuser/bibsdb-cron-logout-if-no-chrome.sh
#!/usr/bin/env bash

# If chrome is not running
if ! pgrep -x "chrome" > /dev/null
then
    pkill -KILL -u user
fi

CRON-LOGOUT

chmod +x /home/superuser/bibsdb-cron-logout-if-no-chrome.sh

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
        sed -i -e "/cron-logout/d" $TCRON
        sed -i -e "/pkill/d" $TCRON
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
        # We wan't to do a conditional logout 15, 30, and 45 minutes after the computer wakes up to solve network issues
        # Logout only happens if chrome is not running
        # Lets calculate when to do the logout
        SECONDS_TO_WAKEUP_WEEKDAY_PLUS_15_MIN=$(($SECONDS_TO_WAKEUP_WEEKDAY + 60*15))
        SECONDS_TO_WAKEUP_WEEKDAY_PLUS_30_MIN=$(($SECONDS_TO_WAKEUP_WEEKDAY + 60*30))
        SECONDS_TO_WAKEUP_WEEKDAY_PLUS_45_MIN=$(($SECONDS_TO_WAKEUP_WEEKDAY + 60*45))
        LOGOUT_TIME_WEEKDAY_15=$(date -d "$HOURS_WEEKDAY$MINUTES_WEEKDAY +$SECONDS_TO_WAKEUP_WEEKDAY_PLUS_15_MIN seconds" +"%H%M"); 
        LOGOUT_TIME_WEEKDAY_30=$(date -d "$HOURS_WEEKDAY$MINUTES_WEEKDAY +$SECONDS_TO_WAKEUP_WEEKDAY_PLUS_30_MIN seconds" +"%H%M");
        LOGOUT_TIME_WEEKDAY_45=$(date -d "$HOURS_WEEKDAY$MINUTES_WEEKDAY +$SECONDS_TO_WAKEUP_WEEKDAY_PLUS_45_MIN seconds" +"%H%M");

	    HOURS_WEEKEND=$4
        MINUTES_WEEKEND=$5
        SECONDS_TO_WAKEUP_WEEKEND=$(expr 3600 \* $6)
        # We wan't to do a conditional logout 15, 30, and 45 minutes after the computer wakes up to solve network issues
        # Logout only happens if chrome is not running
        # We wan't to do a logout 15 minutes after the computer wakes up to solve network issues
        # Lets calculate when to do the logout
        SECONDS_TO_WAKEUP_WEEKEND_PLUS_15_MIN=$(($SECONDS_TO_WAKEUP_WEEKEND + 60*15))
        SECONDS_TO_WAKEUP_WEEKEND_PLUS_30_MIN=$(($SECONDS_TO_WAKEUP_WEEKEND + 60*30))
        SECONDS_TO_WAKEUP_WEEKEND_PLUS_45_MIN=$(($SECONDS_TO_WAKEUP_WEEKEND + 60*45))
        LOGOUT_TIME_WEEKEND_15=$(date -d "$HOURS_WEEKEND$MINUTES_WEEKEND +$SECONDS_TO_WAKEUP_WEEKEND_PLUS_15_MIN seconds" +"%H%M"); 
        LOGOUT_TIME_WEEKEND_30=$(date -d "$HOURS_WEEKEND$MINUTES_WEEKEND +$SECONDS_TO_WAKEUP_WEEKEND_PLUS_30_MIN seconds" +"%H%M"); 
        LOGOUT_TIME_WEEKEND_45=$(date -d "$HOURS_WEEKEND$MINUTES_WEEKEND +$SECONDS_TO_WAKEUP_WEEKEND_PLUS_45_MIN seconds" +"%H%M"); 

        # We still remove shutdown lines, if any
        if [ -f $TCRON ]
        then
            sed -i -e "/\/rtcwake/d" $TCRON
            sed -i -e "/cron-logout/d" $TCRON
            sed -i -e "/pkill/d" $TCRON
        fi
        if [ -f $USERCRON ]
        then
            sed -i -e "/lukker/d" $USERCRON
        fi
        # Assume the parameters are already validated as integers.
        echo "$MINUTES_WEEKDAY $HOURS_WEEKDAY * * 1-5 /usr/sbin/rtcwake -m off -s $SECONDS_TO_WAKEUP_WEEKDAY" >> $TCRON
	    echo "$MINUTES_WEEKEND $HOURS_WEEKEND * * 6,0 /usr/sbin/rtcwake -m off -s $SECONDS_TO_WAKEUP_WEEKEND" >> $TCRON
        # Add logout of user to crontab
        echo "${LOGOUT_TIME_WEEKDAY_15:2:4} ${LOGOUT_TIME_WEEKDAY_15:0:2}  * * 1-5 pkill -KILL -u user" >> $TCRON
        echo "${LOGOUT_TIME_WEEKDAY_30:2:4} ${LOGOUT_TIME_WEEKDAY_30:0:2}  * * 1-5 /home/superuser/bibsdb-cron-logout-if-no-chrome.sh" >> $TCRON
        echo "${LOGOUT_TIME_WEEKDAY_45:2:4} ${LOGOUT_TIME_WEEKDAY_45:0:2}  * * 1-5 /home/superuser/bibsdb-cron-logout-if-no-chrome.sh" >> $TCRON
        echo "${LOGOUT_TIME_WEEKEND_15:2:4} ${LOGOUT_TIME_WEEKEND_15:0:2}  * * 6,0 pkill -KILL -u user" >> $TCRON
        echo "${LOGOUT_TIME_WEEKEND_30:2:4} ${LOGOUT_TIME_WEEKEND_30:0:2}  * * 6,0 /home/superuser/bibsdb-cron-logout-if-no-chrome.sh" >> $TCRON
        echo "${LOGOUT_TIME_WEEKEND_45:2:4} ${LOGOUT_TIME_WEEKEND_45:0:2}  * * 6,0 /home/superuser/bibsdb-cron-logout-if-no-chrome.sh" >> $TCRON
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
