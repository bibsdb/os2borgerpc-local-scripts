#!/usr/bin/env bash

set -e

IMAGE_FILE=$1
SCRIPT=$2

sudo apt-get update 
sudo apt-get install -y libglib2.0-dev-bin

IMAGE_FULL_PATH=/usr/share/backgrounds/bibsdb-bg.png
sudo /bin/cp -rf "$IMAGE_FILE"  "$IMAGE_FULL_PATH"

# Save the script
SCRIPT_FULL_PATH=/home/superuser/change-gdm-background.sh
sudo /bin/cp -rf "$SCRIPT"  "$SCRIPT_FULL_PATH"
chmod +x /home/superuser/change-gdm-background.sh

# Run the script
/home/superuser/change-gdm-background.sh /usr/share/backgrounds/bibsdb-bg.png
