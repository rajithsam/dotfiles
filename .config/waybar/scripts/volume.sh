#!/bin/sh
# Toggle mute or open pavucontrol interactively
if [ "$1" = "toggle" ]; then
    pactl set-sink-mute @DEFAULT_SINK@ toggle
elif [ "$1" = "open" ]; then
    pavucontrol
else
    VOL=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+%' | head -1)
    MUTE=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -oP 'yes|no')
    if [ "$MUTE" = "yes" ]; then
        echo " Muted"
    else
        echo " $VOL"
    fi
fi
