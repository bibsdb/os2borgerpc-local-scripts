#!/usr/bin/env bash

if ! grep -q 10.176.0.10 /etc/hosts ; then
sed -i '1i10.176.0.10 screen-sonderborg.teknik.local admin-sonderborg.teknik.local search-sonderborg.teknik.local middleware-sonderborg.teknik.local' /etc/hosts
fi

if ! grep -q 10.176.0.15 /etc/hosts ; then
sed -i '1i10.176.0.15 screen.os2display.teknik.local admin.os2display.teknik.local search.os2display.teknik.local middleware.os2display.teknik.local' /etc/hosts
fi
