#!/usr/bin/env bash

# Undgå kludder i Netics login 
# Override any settings found in /usr/lib/NetworkManager/conf.d/20-connectivity-ubuntu.conf.
# https://askubuntu.com/questions/1029108/how-do-i-programmatically-disable-connectivity-checking

if [ "$1" == "Nej" ]
then
    echo "Enabeling connectivity checking"
    rm /etc/NetworkManager/conf.d/20-connectivity-ubuntu.conf
    exit 0
elif [ "$1" == "Ja" ]
then
    echo "Disabeling connectivity checking"
    touch /etc/NetworkManager/conf.d/20-connectivity-ubuntu.conf
    exit 0
fi
