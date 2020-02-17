#!/usr/bin/env bash

# Do it now
amixer set Master mute

# Preserve setting even when automatic cleanup is enabled
cat > /etc/profile.d/bibsdb-mute-audio.sh << EOF
#!/usr/bin/env bash
amixer set Master mute
EOF


