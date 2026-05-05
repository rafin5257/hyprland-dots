#!/bin/bash

WALLPAPER_DIR="$HOME/wallpapers"
STATE_FILE="/tmp/wallpaper_index.txt"

# Get all wallpapers into an array sorted
mapfile -t WALLPAPERS < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.gif" \) | sort)
TOTAL=${#WALLPAPERS[@]}

# Get current wallpaper name if exists
if [ -f "$STATE_FILE" ]; then
    CURRENT_INDEX=$(cat "$STATE_FILE")
    CURRENT_NAME=$(basename "${WALLPAPERS[$CURRENT_INDEX]}" 2>/dev/null || echo "None")
else
    CURRENT_INDEX=0
    CURRENT_NAME="Random"
fi

# Show rofi menu
CHOICE=$(echo -e "⏮ Previous\n⏭ Next\n🎲 Random\n📋 Current: $CURRENT_NAME\n❌ Cancel" | rofi -dmenu -i -p "Wallpaper Controls" -theme-str 'window {width: 250px;}')

case "$CHOICE" in
    "⏮ Previous")
        NEW_INDEX=$(( (CURRENT_INDEX - 1 + TOTAL) % TOTAL ))
        echo "$NEW_INDEX" > "$STATE_FILE"
        awww img "${WALLPAPERS[$NEW_INDEX]}" --transition-type fade --transition-fps 60 --transition-step 2
        notify-send "Wallpaper" "Previous: $(basename "${WALLPAPERS[$NEW_INDEX]}")" -t 1500
        ;;
    "⏭ Next")
        NEW_INDEX=$(( (CURRENT_INDEX + 1) % TOTAL ))
        echo "$NEW_INDEX" > "$STATE_FILE"
        awww img "${WALLPAPERS[$NEW_INDEX]}" --transition-type fade --transition-fps 60 --transition-step 2
        notify-send "Wallpaper" "Next: $(basename "${WALLPAPERS[$NEW_INDEX]}")" -t 1500
        ;;
    "🎲 Random")
        NEW_INDEX=$(( RANDOM % TOTAL ))
        echo "$NEW_INDEX" > "$STATE_FILE"
        awww img "${WALLPAPERS[$NEW_INDEX]}" --transition-type fade --transition-fps 60 --transition-step 2
        notify-send "Wallpaper" "Random: $(basename "${WALLPAPERS[$NEW_INDEX]}")" -t 1500
        ;;
    "📋 Current:"*|"❌ Cancel"|"")
        # Do nothing
        ;;
esac
