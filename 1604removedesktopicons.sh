#!/usr/bin/env bash

CALCDESKTOP="/home/.skjult/Desktop/calc.desktop"

if [ -f $CALCDESKTOP ]
then
    rm -f "/home/.skjult/Desktop/calc.desktop"
else
    echo "File does not exist"
    exit -1
fi

WRITERDESKTOP="/home/.skjult/Desktop/writer.desktop"

if [ -f $WRITERDESKTOP ]
then
    rm -f "/home/.skjult/Desktop/writer.desktop"
else
    echo "File does not exist"
    exit -1
fi

IMPRESSDESKTOP="/home/.skjult/Desktop/impress.desktop"

if [ -f $IMPRESSDESKTOP ]
then
    rm -f "/home/.skjult/Desktop/impress.desktop"
else
    echo "File does not exist"
    exit -1
fi

HELPDESKTOP="/home/.skjult/Desktop/Help.desktop"

if [ -f $HELPDESKTOP ]
then
    rm -f "/home/.skjult/Desktop/Help.desktop"
else
    echo "File does not exist"
    exit -1
fi



exit 0
