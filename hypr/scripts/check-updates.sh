#!/bin/bash

# Check pending updates
updates=$(checkupdates 2>/dev/null | wc -l)

# Reboot flag file
reboot_flag="/tmp/reboot-required"

# Display states with brackets
if [[ $updates -gt 0 ]]; then
  echo "{\"text\": \"[  󰚰 $updates  ]\", \"tooltip\": \"$updates updates available\", \"class\": \"updates\"}"
elif [[ -f $reboot_flag ]]; then
  echo "{\"text\": \"[  󰜉  ]\", \"tooltip\": \"Reboot required\", \"class\": \"reboot\"}"
else
  echo "{\"text\": \"[    ]\", \"tooltip\": \"System up to date\", \"class\": \"uptodate\"}"
fi
