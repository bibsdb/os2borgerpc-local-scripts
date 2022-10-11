#!/usr/bin/env bash

# Script to control shutdown once every day.
# Different settings can be applied for weekdays and weekends.
# You can not make the computer "sleep all weekend".
# The computer has to wake up every day - at least for one hour.
# 
# Script takes six arguments.
# Arguments need to be given in the right order.
# 
# Arguments:
# weekday-shutdown-hours
# weekday-shutdown-minutes
# weekday-number-of-hours-to-sleep
# weekend-shutdown-hours
# weekend-shutdown-minutes
# weekend-number-of-hours-to-sleep

# Any questions? Contact Agnete Moos, agms@sonderborg.dk

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
      echo "Please read the instructions on how to use the script."
  fi

fi

if [ -f $TCRON ]
then
    rm $TCRON
fi