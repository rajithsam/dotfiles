#!/bin/bash
# Directory containing your wallpapers
WALLDIR="$HOME/.config/hypr/wallpapers"

# Pick a random wallpaper
WALL=$(find "$WALLDIR" -type f | shuf -n 1)

# Loop over all monitors and set the wallpaper
for MON in $(hyprctl monitors -j | jq -r '.[].name'); do
    hyprctl hyprpaper preload "$WALL"
    hyprctl hyprpaper wallpaper "$MON","$WALL"
done
# Notify the user
notify-send "Wallpaper changed" "New wallpaper: $(basename "$WALL")"