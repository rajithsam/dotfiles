#!/bin/sh
# Show update icon if Arch updates are available
UPDATES=$(checkupdates 2>/dev/null | wc -l)
if [ "$UPDATES" -gt 0 ]; then
    echo " $UPDATES"
else
    echo ""
fi
