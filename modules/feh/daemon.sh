#!/bin/sh
# $WALLPAPER is set by nix
if [ ! -f $XDG_CONFIG_HOME/sxmo/xinit ]; then
  WALLPAPER="${WALLPAPER/\~/$HOME}"
  if [ -d $WALLPAPER ]; then
    DISPLAY=:0 $FEH --bg-fill --auto-reload -z $WALLPAPER/** # z = Randomize
  elif [[ -f $WALLPAPER ]]; then
    DISPLAY=:0 $FEH --bg-fill --auto-reload -z $WALLPAPER # z = Randomize
  else
    echo "$WALLPAPER is not a valid path"
    exit 1
  fi
fi
