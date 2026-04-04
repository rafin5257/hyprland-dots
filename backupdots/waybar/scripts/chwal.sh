
WALLPAPER_DIR="$HOME/wallpapers"


RANDOM_IMAGE=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.gif" \) | shuf -n 1)


awww img "$RANDOM_IMAGE" --transition-type fade --transition-fps 60 --transition-step 2
