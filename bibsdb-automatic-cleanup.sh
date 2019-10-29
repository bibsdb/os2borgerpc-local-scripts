#!/usr/bin/env bash
# Modifies two scripts to enable/disable automated cleanup:
# /usr/share/bibos/bin/user-cleanup.bash
# /etc/init/bibos.conf

if [ $# -ne 1 ]
then
  echo "Dette script tager en parameter: aktiver/deaktiver"
  exit -1
fi

if [ "$1" == "aktiver" ]
then
  cp -f /home/superuser/bibos_image/image/overwrites/usr/share/bibos/bin/user-cleanup.bash /usr/share/bibos/bin/user-cleanup.bash
  cp -f /home/superuser/bibos_image/image/overwrites/etc/init/bibos.conf /etc/init/bibos.conf
  echo "Automated cleanup has been activated."
  exit 0
elif [ "$1" == "deaktiver" ]
then
	cat > /usr/share/bibos/bin/user-cleanup.bash <<- EOF
    # This script has been disabled by the script bibsdb-automatic-cleanup.sh
    # Run bibsdb-automatic-cleanup.sh to re-enable cleanup
	EOF
	cat > /etc/init/bibos.conf <<- EOF
		# upstart script for bibos
		# This script has been disabled by the script bibsdb-automatic-cleanup.sh
		# Run bibsdb-automatic-cleanup.sh to re-enable cleanup
	EOF
	echo "Automated cleanup has been de-activated."
	exit 0
else
  echo "Unsupported parameter"
  exit -1
fi
