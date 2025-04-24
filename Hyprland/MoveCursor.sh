#!/bin/bash
# This script needs for using mouse control in BeamNG Drive Game.

windows=$(hyprctl activewindow | grep -o "steam_app_284160" -m 1)
xd=$(hyprctl cursorpos | cut -d ',' -f1)

if [[ "$windows" == "steam_app_284160" ]]; then
  hyprctl dispatch movecursor "$xd" 780
else
  echo "no"
fi
