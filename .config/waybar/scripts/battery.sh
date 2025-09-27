#!/bin/sh
# Show battery status, click to open power settings
BAT=$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null)
STATUS=$(cat /sys/class/power_supply/BAT*/status 2>/dev/null)
if [ "$STATUS" = "Charging" ]; then
    ICON=""
else
    ICON=""
fi
if [ -n "$BAT" ]; then
    echo "$ICON $BAT%"
else
    echo " N/A"
fi
