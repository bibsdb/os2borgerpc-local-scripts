#!/usr/bin/env bash


# BIBSDB: Change the background of the login screen
# Solution was found here:
# https://askubuntu.com/questions/797845/how-do-i-change-the-login-screen-in-ubuntu-16-04
# Requires a restart to take effect

set -x

if [ $# -ne 1 ]
then
    echo "Usage: $(basename $0) {filename} "
    echo ""
    exit -1
fi

# We have one and only one argument, the background image's file path.

IMAGE_FILE=$1

if [ ! -f $IMAGE_FILE ]
then
    echo "No such file: $IMAGE_FILE"
    echo "Please supply a path to an existing image file"
    exit -1
fi

# Do not check it's an image, the user can shoot self in foot if (s)he likes.

# Overwrite default desktop background
IMAGE_FULL_PATH=/usr/share/backgrounds/warty-final-ubuntu.png
sudo /bin/cp -rf "$IMAGE_FILE"  "$IMAGE_FULL_PATH"


exit 0

