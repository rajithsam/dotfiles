#!/bin/bash

# File indicating reboot requirement
flag="/tmp/reboot-required"

important_paths=(
  /boot/vmlinuz-linux
  /boot/vmlinuz-linux-zen
  /boot/vmlinuz-linux-lts
  /usr/lib/systemd/systemd
  /usr/lib/libc.so.6
  /usr/lib/modules
)

# Check if any important files updated since boot
for f in "${important_paths[@]}"; do
  [[ -e "$f" ]] || continue
  if [[ "$f" -nt /proc/1" ]]; then
    touch "$flag"
    notify-send -u critical "Reboot required" "Kernel or system libraries updated. Please reboot."
    exit 0
  fi
done

# If not required, remove flag
[[ -f $flag ]] && rm -f $flag
