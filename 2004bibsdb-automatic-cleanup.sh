#!/usr/bin/env bash
# Modifies script to enable/disable automated cleanup:
# /usr/share/os2borgerpc/bin/bibsdb.user-cleanup.bash

if [ $# -ne 1 ]
then
  echo "Dette script tager en parameter: aktiver/deaktiver"
  exit -1
fi


if [ "$1" == "aktiver" ]
then
  # Check if backup has been made
  BACKUP=/usr/share/os2borgerpc/bin/bibsdb.user-cleanup.bash
  if [[ -f "$BACKUP" ]]; then
    # Backup exists. Replace current script with backup.
      cp -f /usr/share/os2borgerpc/bin/bibsdb.user-cleanup.bash /usr/share/os2borgerpc/bin/user-cleanup.bash
  fi
  set_bibos_config oprydning "aktiveret"
  bibos_push_config_keys oprydning
  echo "Automated cleanup has been activated."
  exit 0
elif [ "$1" == "deaktiver" ]
then
  # Only make the backup-copy if bibsdb.user-cleanup.bash does not exist (-n)
  cp -n /usr/share/os2borgerpc/bin/user-cleanup.bash /usr/share/os2borgerpc/bin/bibsdb.user-cleanup.bash

cat <<EOF > /usr/share/os2borgerpc/bin/user-cleanup.bash
    # This script has been disabled by the script bibsdb-automatic-cleanup.sh
    # Run bibsdb-automatic-cleanup.sh to re-enable cleanup
EOF

  set_bibos_config oprydning "deaktiveret"
  bibos_push_config_keys oprydning
  echo "Automated cleanup has been de-activated."
  exit 0
else
  echo "Unsupported parameter"
  exit -1
fi
