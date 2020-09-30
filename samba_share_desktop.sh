#!/usr/bin/env bash 

# This script will turn the Desktop into a Samba Network Share

# We have only one argument, the password

PASSWORD=$1

if [ $# -ne 1 ]
then
    echo "Please supply a password"
    exit -1
fi


apt-get update 
apt-get install -y samba

# Create the samba user and set password for user "user"
# If samba-user is already created this is just a password reset
echo -ne "$PASSWORD\n$PASSWORD\n" | smbpasswd -a -s user

# Make a backup if a backup does not already exist
cp -n /etc/samba/smb.conf /etc/samba/smb.conf.orig || true

# Force overwite smb.conf with backup
cp -f /etc/samba/smb.conf.orig /etc/samba/smb.conf

# Append network share config to smb.conf

cat >> /etc/samba/smb.conf <<- EOF
[user]
path = /home/user/Desktop
valid users = user
read only = no
EOF

# Restart samba
service smbd restart




