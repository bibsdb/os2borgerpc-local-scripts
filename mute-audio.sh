#!/usr/bin/env bash

# Mute audio
cat > /etc/profile.d/bibsdb-mute-audio.sh << EOF
#!/usr/bin/env bash
amixer set Master mute
EOF


