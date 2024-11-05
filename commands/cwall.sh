#!/bin/bash

WALLPAPER_DIR=$HOME/Pictures/backgrounds

# Random select
WALLPAPER=$(find $WALLPAPER_DIR -type f | shuf -n 1)

# Change GNOME wallpaper
gsettings set org.gnome.desktop.background picture-uri-dark "file://$WALLPAPER"

# Change log wallpaper
echo "[$(date '+%Y-%m-%d %H:%M:%S')] change wallpaper: $WALLPAPER" >> $HOME/.cwall.log