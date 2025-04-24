#!/bin/bash

# VARIABLES
base_string="-A actionNum1=\${monitor[Num2]}"

dir="$HOME/Видео/Видеозаписи"
sDir="$HOME/.config/hypr/scripts"

time=$(date +"%Y-%m-%d %H-%M-%S")

filePart="${time}.mp4"
fileReg="$dir/Region $filePart"

# ARRAYs
RecParams=("-m" "mp4" "--audio")
monitors=($(xrandr | grep 'connected' | cut -d' ' -f1))

action=$(for ((i = 1; i <= repeats; i++)); do
  Num1=$1
  Num2=$((i - 1))
  Actions="-A action$Num1=\${monitor[$Num2]}"
  echo "$Actions"
done)

# NOTIFY BASES
notify_cmd_base="notify-send -t 10000 -A action1=Open -A action2=Delete -h string:x-canonical-private-synchronous:shot-notify"
notify_cmd_not="notify-send -t 10000 -h string:x-canonical-private-synchronous:shot-notify"
notify_cmd_opt="notify-send -t 99999 $action -h string:x-canonical-private-synchronous:shot-notify"

# NOTIFY VIEW.
notify_view() {
  # FULLSCREEN RECORDING.
  if [[ "$1" == "fullscreen" ]]; then
    resp2=$(notify-send -t 99999 $(for ((i = 1; i <= repeats; i++)); do
      Num1=$1
      Num2=$((i - 1))
      Actions="-A action$Num1=${monitor[$Num2]}"
      echo "$Actions"
    done) -h string:x-canonical-private-synchronous:shot-notify " Choose the monitor")
    case "$resp2" in
    action1)
      echo "Choosed first one"
      fullscreen
      ;;
    action2)
      echo "Choosed second"
      Monitor="2"
      ;;
    esac

    # SOUND ...
    "${sDir}/Sounds.sh" --error

  # elif [[ "$1" == "fullscreenEnd" ]]; then # END OF FULLSCREEN CAPTURE RECORDING..
  # REGION RECORDING.
  elif [[ "$1" == "region" ]]; then
    "${sDir}/Sounds.sh" --screenshot
    resp=$(${notify_cmd_base} " Region has recorded. ")
    case "$resp" in
    action1)
      echo "Opening " $fileReg
      mpv "$fileReg"
      ;;
    action2)
      rm "$fileReg"
      ;;
    esac

  else
    ${notify_cmd_not} " Choose option at first!"

  fi
}

# START RECORD.
fullscreen() {
  Monitor="$1"

  tmpfile=$(mktemp)
  rm $tmpfile &
  wf-recorder -f "$tmpfile" ${RecParams[@]} $Monitor

  if [[ -s "$tmpfile" ]]; then
    mv "$tmpfile" "$fileReg" # SAVING THE FILE TO VIDEOS FOLDER.
  fi

  notify_view # "fullscreen"

}

# START RECORD REGION.
region() {
  tmpfile=$(mktemp)
  rm $tmpfile &
  wf-recorder -g "$(slurp && "${sDir}/Sounds.sh" --error)" -f "$tmpfile" ${RecParams[@]}

  if [[ -s "$tmpfile" ]]; then
    mv "$tmpfile" "$fileReg" # SAVIMG THE FILE TO VIDEOS FOLDER.
  fi

  notify_view "region"
}

if [[ "$1" == "--region" ]]; then
  # STOP WORKING WF-PROCESS
  if pgrep -x "wf-recorder" >/dev/null; then
    pkill wf-recorder
  else
    region
  fi

elif [[ "$1" == "--fullscreen" ]]; then
  # if [[ a lot of monitors ]]; then................
  notify_view "fullscreen"
else
  echo -e "You should use some of this parametrs: --region"
  notify_view
fi

exit 0
