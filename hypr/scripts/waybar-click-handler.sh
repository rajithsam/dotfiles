#!/bin/bash

if grep -q "reboot-required" /tmp/reboot-required 2>/dev/null; then
  notify-send "Rebooting..." "Applying updates."
  systemctl reboot
else
  ~/.config/hypr/scripts/run-updates.sh
fi
