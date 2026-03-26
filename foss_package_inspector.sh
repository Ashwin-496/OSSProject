#!/bin/bash
# Script 2: FOSS Package Inspector

PACKAGE="apache2"

if dpkg -l | grep -q $PACKAGE; then
    echo "$PACKAGE is installed."
    dpkg -l | grep $PACKAGE
else
    echo "$PACKAGE is NOT installed."
fi

case $PACKAGE in
    apache2) echo "Apache: A powerful open-source web server" ;;
    mysql) echo "MySQL: Open-source relational database system" ;;
    firefox) echo "Firefox: Open web browser promoting privacy" ;;
    vlc) echo "VLC: Free multimedia player supporting all formats" ;;
    *) echo "Unknown package" ;;
esac
