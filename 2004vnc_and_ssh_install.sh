#!/usr/bin/env bash
# This script will set up a VNC server to listen on display :0 and will
# set a password given in the first parameter.

VNC_PASSWORD=$1

apt install -y ssh x11vnc xinetd

cat << EOF > /lib/systemd/system/x11vnc.service
[Unit]
Description=x11vnc service
After=display-manager.service network.target syslog.target

[Service]
Type=simple
ExecStart=/usr/bin/x11vnc -forever -display :0 -auth guess -passwdfile /etc/os2borgerpc/vncpasswd
ExecStop=/usr/bin/killall x11vnc
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

cat << EOF > /etc/os2borgerpc/vncpasswd
$VNC_PASSWORD
EOF

systemctl daemon-reload
systemctl enable x11vnc.service