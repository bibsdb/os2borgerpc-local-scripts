#!/usr/bin/env bash

# Allow popups from Netics
# This script adds a Google Chrome policy that allows popup from Netics.

set -x

POLICY="/etc/opt/chrome/policies/managed/netics.json"

if [ ! -d "`dirname "$POLICY"`" ]; then
    mkdir -p "`dirname "$POLICY"`"
fi

cat > "$POLICY" <<END
{
    "PopupsAllowedForUrls": ["http://hotspot.sonderborg.dk", "https://hotspot.sonderborg.dk"]
}
END