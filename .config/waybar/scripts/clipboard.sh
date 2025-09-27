#!/bin/sh
# Show clipboard icon if something is copied
CLIP=$(wl-paste --no-newline)
if [ -n "$CLIP" ]; then
    echo ""
else
    echo "󰅯"
fi
