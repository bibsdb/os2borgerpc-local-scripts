#!/usr/bin/env bash

# Script to interrupt/resume the HDMI-signal to the screen at specified times every day.
# Different settings can be applied for weekdays and weekends.
# When the HDMI signal is interrupted, the screen will go to sleep.
# When the HDMI signal is resumed, the screen will wake up.
# 
# Script takes four arguments.
# Arguments need to be given in the right order.
# 
# Arguments:
# weekday-wakeup-time
# weekday-sleep-time
# weekend-wakeup-time
# weekend-sleep-time


# Any questions? Contact Agnete Moos, agms@sonderborg.dk

TCRON=/tmp/oldcron
crontab -l > $TCRON

if [ "$1" == "--off" ]
then

  if [ -f $TCRON ]
  then
      sed -i -e "/\/vcgencmd/d" $TCRON
      crontab $TCRON
  fi

else

  if [ $# == 4 ]
  then
    WEEKDAY_WAKEUP=$1
    WEEKDAY_SLEEP=$2
    WEEKEND_WAKEUP=$3
    WEEKEND_SLEEP=$4

    # We still remove shutdown lines, if any
    if [ -f $TCRON ]
    then
      sed -i -e "/\/vcgencmd/d" $TCRON
    fi

    # Weekday - Wake up
    echo "${WEEKDAY_WAKEUP:3:2} ${WEEKDAY_WAKEUP:0:2} * * 1-5 /usr/bin/vcgencmd display_power 1" >> $TCRON
    # Weekday - Put to sleep
    echo "${WEEKDAY_SLEEP:3:2} ${WEEKDAY_SLEEP:0:2} * * 1-5 /usr/bin/vcgencmd display_power 0" >> $TCRON
    # Weekend - Wake up
    echo "${WEEKEND_WAKEUP:3:2} ${WEEKEND_WAKEUP:0:2} * * 6,0 /usr/bin/vcgencmd display_power 1" >> $TCRON
    # Weekend - Put to sleep
    echo "${WEEKEND_SLEEP:3:2} ${WEEKEND_SLEEP:0:2} * * 6,0 /usr/bin/vcgencmd display_power 0" >> $TCRON
    crontab $TCRON

  else
      echo "Please read the instructions on how to use the script."
  fi

fi

if [ -f $TCRON ]
then
    rm $TCRON
fi