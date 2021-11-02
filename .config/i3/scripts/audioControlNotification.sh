#!/bin/bash
# change Volume

msgId="991049"

if [[ $@ == "up" ]]; then
  volume="$(amixer -D pulse sset Master '5%+' | tail -1 | awk '{print $5}' | sed 's/[^0-9]*//g')"
elif [[ $@ == "down" ]]; then
  volume="$(amixer -D pulse sset Master '5%-' | tail -1 | awk '{print $5}' | sed 's/[^0-9]*//g')"
else
  echo "Error parsing input"
  return 1
fi

dunstify -a "changeVolume" -u low -i audio-volume-high -r "$msgId" "Volume: ${volume}%" "$(~/.config/i3/scripts/getProgressString.sh 10 "#" "_" $volume)"
