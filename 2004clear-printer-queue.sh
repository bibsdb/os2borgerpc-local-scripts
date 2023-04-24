#!/usr/bin/env bash

# Clear the print queue for the printer bon
cat <<CLEAR-QUEUE > /home/superuser/bibbox-clear-bon-queue.sh
#!/usr/bin/env bash
cancel -a bon
CLEAR-QUEUE

chmod +x /home/superuser/bibbox-clear-bon-queue.sh

TCRON=/tmp/oldcron
crontab -l > $TCRON

ACTIVATE=$1
if [ "$ACTIVATE" = 'False' ]
then
  if [ -f $TCRON ]
  then
    sed -i -e "/clear-bon/d" $TCRON
    crontab $TCRON
  fi
else
  echo "30 7 * * * /home/superuser/bibbox-clear-bon-queue.sh" >> $TCRON
  crontab $TCRON
fi

if [ -f $TCRON ]
then
    rm $TCRON
fi
