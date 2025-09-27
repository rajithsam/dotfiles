#!/bin/sh
# Show network status, click to open nm-applet
STATUS=$(nmcli -t -f WIFI g)
if [ "$STATUS" = "enabled" ]; then
    SSID=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
    if [ -n "$SSID" ]; then
        echo " $SSID"
    else
        echo "睊 Disconnected"
    fi
else
    echo "睊 Disabled"
fi
