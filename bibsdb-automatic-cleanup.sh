#!/usr/bin/env bash
# Modifies two scripts to enable/disable automated cleanup:
# /usr/share/bibos/bin/user-cleanup.bash
# /etc/init/bibos.conf

if [ $# -ne 1 ]
then
  echo "Dette script tager en parameter: aktiver/deaktiver"
  exit -1
fi

# Fix bug in admin_client that prevents bibos_push_config_keys from running
if ! grep -Fxq "from bibos_utils.bibos_config import BibOSConfig" /usr/local/lib/python2.7/dist-packages/bibos_client/admin_client.py
then
  sed -i '1ifrom bibos_utils.bibos_config import BibOSConfig' /usr/local/lib/python2.7/dist-packages/bibos_client/admin_client.py
fi


if [ "$1" == "aktiver" ]
then
  cp -f /home/superuser/bibos_image/image/overwrites/usr/share/bibos/bin/user-cleanup.bash /usr/share/bibos/bin/user-cleanup.bash
  cp -f /home/superuser/bibos_image/image/overwrites/etc/init/bibos.conf /etc/init/bibos.conf
  set_bibos_config oprydning "aktiveret"
  bibos_push_config_keys oprydning
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
  set_bibos_config oprydning "deaktiveret"
  bibos_push_config_keys oprydning
  echo "Automated cleanup has been de-activated."
  exit 0
else
  echo "Unsupported parameter"
  exit -1
fi
