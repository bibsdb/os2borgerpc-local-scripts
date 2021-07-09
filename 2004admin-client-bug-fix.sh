#!/usr/bin/env bash

# Fix bug in admin_client that prevents os2borgerpc_push_config_keys from running
if ! grep -Fxq "from os2borgerpc.client.config import OS2borgerPCConfig" /usr/local/lib/python3.8/dist-packages/os2borgerpc/client/admin_client.py
then
  sed -i '1ifrom os2borgerpc.client.config import OS2borgerPCConfig' /usr/local/lib/python3.8/dist-packages/os2borgerpc/client/admin_client.py
fi