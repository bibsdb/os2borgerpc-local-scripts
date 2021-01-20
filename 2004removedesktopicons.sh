#!/usr/bin/env bash

CALCSkrivebord="/home/.skjult/Skrivebord/libreoffice-calc.desktop"

if [ -f $CALCSkrivebord ]
then
    rm -f "/home/.skjult/Skrivebord/libreoffice-calc.desktop"
else
    echo "File does not exist"
    exit -1
fi

WRITERSkrivebord="/home/.skjult/Skrivebord/libreoffice-writer.desktop"

if [ -f $WRITERSkrivebord ]
then
    rm -f "/home/.skjult/Skrivebord/libreoffice-writer.desktop"
else
    echo "File does not exist"
    exit -1
fi

IMPRESSSkrivebord="/home/.skjult/Skrivebord/libreoffice-impress.desktop"

if [ -f $IMPRESSSkrivebord ]
then
    rm -f "/home/.skjult/Skrivebord/libreoffice-impress.desktop"
else
    echo "File does not exist"
    exit -1
fi


exit 0
