#!/bin/bash
# This script needs for using mouse control in BeamNG Drive Game.

# Put your class name instead if needed.
# Default name is - Native Linux BeamNG.Drive.
windows=$(hyprctl activewindow | grep -o "BeamNG.drive.x64" -m 1)

xd=$(hyprctl cursorpos | cut -d ',' -f1)

if [[ "$windows" == "BeamNG.drive.x64" ]]; then
  hyprctl dispatch movecursor "$xd" 780

  # else
  # Just for test.
  # echo "no"
fi
