#! /usr/bin/env python3

import os
from urllib.parse import urlparse
from subprocess import check_output
from time import sleep
import sys

EXPECTED_ARG_COUNT = 4
if len(sys.argv) != EXPECTED_ARG_COUNT + 1:
    print(f"This script takes {EXPECTED_ARG_COUNT} arguments. Exiting.")
    sys.exit(1)

URL = sys.argv[1]
KEY = bytes(sys.argv[2], encoding="utf-8")
VALUE = bytes(sys.argv[3], encoding="utf-8")
KILL_BROWSER = sys.argv[4]

BROWSER_PROCESS_NAME = "chrome"
USER = "chrome"
DB_PATH_DIR = f"/home/{USER}/.config/google-chrome/Default/Local Storage/leveldb/"

PLYVEL_APT_PKG_NAME = "python3-plyvel"
PSUTIL_APT_PKG_NAME = "python3-psutil"

print(check_output(["apt-get", "update"]))
print(
    check_output(
        ["apt-get", "install", "--assume-yes", PLYVEL_APT_PKG_NAME, PSUTIL_APT_PKG_NAME]
    )
)

# Now these can be imported
import plyvel, psutil

browser_running = None
for proc in psutil.process_iter():
    if BROWSER_PROCESS_NAME in proc.name():
        browser_running = proc
        break

if browser_running and KILL_BROWSER.lower() == "true":
    browser_running.terminate()
    sleep(5)  # Give it some time to terminate

db = plyvel.DB(DB_PATH_DIR, create_if_missing=True)
parsed_url = urlparse(URL)
origin = f"{parsed_url.scheme}://{parsed_url.netloc}"
key = f"_chrome-extension://{origin}/{KEY.decode('utf-8')}".encode('utf-8')
db.put(key, VALUE)
db.close()

print(f"Stored {KEY.decode('utf-8')} with value {VALUE.decode('utf-8')} for {URL} in local storage.")