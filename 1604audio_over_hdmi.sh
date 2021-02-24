#!/usr/bin/env bash

cat <<EOT >> /etc/pulse/default.pa

# anvend hdmi-lydudgang, så lyd afspilles gennem skærmen
set-card-profile 0 output:hdmi-stereo
EOT
