#!/usr/bin/env bash

set -e

certificate=$1 

sudo apt-get update 
sudo apt-get install -y libnss3-tools

# Control will enter here if $DIRECTORY doesn't exist.
if [ ! -d "/home/.skjult/.pki/nssdb" ]; then
  mkdir -p /home/.skjult/.pki/nssdb
  certutil -d /home/.skjult/.pki/nssdb -N
fi

certutil -d sql:/home/.skjult/.pki/nssdb -A -t P -n $certificate -i $certificate 
