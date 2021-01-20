#!/usr/bin/env bash

# Remove Suspend and Hibernate from the user switcher menu
# Solution was found here:
# https://bugs.launchpad.net/ubuntu/+source/policykit/+bug/1300460


cat > /etc/polkit-1/localauthority/90-mandatory.d/disable-suspend.pkla << EOF
[Disable suspend by default]
Identity=unix-user:*
Action=org.freedesktop.login1.suspend
ResultActive=no

[Disable suspend for all sessions]
Identity=unix-user:*
Action=org.freedesktop.login1.suspend-multiple-sessions
ResultActive=no
EOF
