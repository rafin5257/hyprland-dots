#!/bin/bash

STATE_FILE="/tmp/wallpaper_index.txt"
WALLPAPER_DIR="$HOME/wallpapers"

if [ -f "$STATE_FILE" ]; then
    CURRENT_INDEX=$(cat "$STATE_FILE")
    mapfile -t WALLPAPERS < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.gif" \) | sort)
    
    if [ ${#WALLPAPERS[@]} -gt 0 ] && [ "$CURRENT_INDEX" -lt "${#WALLPAPERS[@]}" ]; then
        basename "${WALLPAPERS[$CURRENT_INDEX]}" | cut -c1-20
    else
        echo "No wallpaper"
    fi
else
    echo "Click to start"
fi
