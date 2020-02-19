#!/usr/bin/env bash

# This script is intended to be run from the BibOS admin.
# It will change the user's background image in a standard 
# BibOS installation.
# 
# Feel free to modify it as you need, but as is it can't be expected
# to work on non-BibOS setups.
#
# The script takes ONE parameter, a valid path to the image to be used
# as background.

# BIBSDB addition: Also change the background of the login screen
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

# Change the background of the login screen, hide dots and indicator
cat > /usr/share/glib-2.0/schemas/10_unity_greeter_background.gschema.override << EOF
[com.canonical.unity-greeter]
draw-grid=false
draw-user-backgrounds=false
background="$IMAGE_FULL_PATH"
indicators=['com.canonical.indicator.session']
EOF

sudo glib-compile-schemas /usr/share/glib-2.0/schemas

# Delete ubuntu logo
sudo rm -f /usr/share/unity-greeter/logo.png

exit 0

