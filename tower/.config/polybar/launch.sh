#!/bin/bash

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 0.5; done

# Get all active monitor-connections
monitors=$(xrandr --listactivemonitors | awk '!/Monitors/ {print $4}')
if [[ $(xrandr --listactivemonitors | awk '!/Monitors/ {print $4}' | grep DP-2) == "DP-2" ]]; then
    MAIN_MONITOR=DP-2
else
    MAIN_MONITOR=HDMI-0
fi

MONITOR=${MAIN_MONITOR} polybar -c ~/.config/polybar/config.ini main &
for m in $(xrandr --query | grep " connected " | cut -d" " -f1 | grep -v ${MAIN_MONITOR}); do
	MONITOR=$m polybar -c ~/.config/polybar/config.ini secondary &
done
