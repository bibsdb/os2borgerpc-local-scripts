#!/usr/bin/env bash

# Sometimes you need evidence to prove 
# that at computer turns on and shuts down as programmed.
# This script once pr. hour writes a timestamp to a textfile.
# This of course only happens when the computer is awake, 
# thereby creating evidence of uptime and downtime.

logging_script="/etc/cron.hourly/simpleuptimelog"
cleanup_script="/etc/cron.monthly/cleanupsimpleuptimelog"
logfile="/home/superuser/simpleuptimelog.txt"

if [ "$1" == "disable" ]
then
    echo "Removing cron scripts and log-file."
    rm -f $logging_script
    rm -f $cleanup_script
    rm -f $logfile
    echo "Done."
    exit 0
elif [ "$1" == "enable" ]
then
  echo "Writing logging-script to cron.hourly."
  # Every hour add timestamp to a log-file
  rm -f $logging_script
  cat <<'EOF' >> $logging_script
    #!/bin/bash
    echo $(date +%Y-%m-%d_%H:%M) >> /home/superuser/simpleuptimelog.txt
EOF
  chmod +x $logging_script

  echo "Writing cleanup-script to cron.monthly."
  # Once a month empty the log-file
  rm -f $cleanup_script
    cat <<'EOF' >> $cleanup_script
    #!/bin/bash
    > /home/superuser/simpleuptimelog.txt
EOF
  chmod +x $cleanup_script
  
  echo "Done."
  exit 0
fi




