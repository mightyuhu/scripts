#!/bin/bash
sleep 1
DISP=":0.0";
#XAUTH="/var/run/gdm/auth-for-myuser-4y8yFp/database";
echo "call" >> /tmp/test
DISPLAY=$DISP /usr/bin/xinput --set-prop "pointer:RAPOO RAPOO 5G Wireless Device" 263 1.7

