#!/usr/bin/env bash

# Clear the print queue for the printer bon if there are errors 
# in the CUPS error log. Then clear the error log.
# Runs once pr. minute.
cat <<CLEAR-QUEUE > /home/superuser/bibbox-clear-bon-queue.sh
#!/usr/bin/env bash
# Empty print queue if there are arrors in the CUPS error log
# The clear the CUPS error log

if grep "E \[" /var/log/cups/error_log; then
  echo "The are errors in /var/log/cups/error_log"
  cancel -a bon
  echo "Print queue has been emptied"
  > /var/log/cups/error_log
  echo "The cups error log has been emptied"
fi
CLEAR-QUEUE

chmod +x /home/superuser/bibbox-clear-bon-queue.sh

TCRON=/tmp/oldcron
crontab -l > $TCRON

ACTIVATE=$1
if [ "$ACTIVATE" = 'False' ]
then
  if [ -f $TCRON ]
  then
    sed -i -e "/bibbox-clear-bon-queue/d" $TCRON
    crontab $TCRON
  fi
else
  sed -i -e "/bibbox-clear-bon-queue/d" $TCRON
  echo "* * * * * /home/superuser/bibbox-clear-bon-queue.sh" >> $TCRON
  crontab $TCRON
fi

if [ -f $TCRON ]
then
    rm $TCRON
fi
