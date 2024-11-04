#!/bin/bash

WALLPAPER_DIR=$HOME/Pictures/backgrounds

# Random select
WALLPAPER=$(find $WALLPAPER_DIR -type f | shuf -n 1)

# Change GNOME wallpaper
gsettings set org.gnome.desktop.background picture-uri "file://$WALLPAPER"