#!/bin/bash

# Run update and log
kitty --class system-update -e bash -c '
  sudo pacman -Syu --noconfirm && 
  echo "Checking if reboot required..." &&
  /home/$USER/.config/hypr/scripts/check-reboot.sh
  echo "Done. Close window when ready."
  read -p "Press Enter to exit..."
'
