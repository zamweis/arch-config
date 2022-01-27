#!/bin/bash
if [[ $(xrandr -q | grep " connected" | awk ' {print $1}' | grep 'DVI-I-1-1') == "DVI-I-1-1"  ]]; then
    xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1 --off --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --off --output DVI-I-1-1 --mode 1920x1080 --pos 1920x0 --rotate normal
fi
## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

# Set network interface variable for networkmodules
DEFAULT_NETWORK_INTERFACE=$(ip route | grep '^default' | awk '{print $5}' | head -n1)
echo ${env:DEFAULT_NETWORK_INTERFACE}

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar, using default config location ~/.config/polybar/config
# polybar -c ~/.config/polybar/config.ini main &

MAIN_MONITOR=eDP-1

MONITOR=${MAIN_MONITOR} polybar -c ~/.config/polybar/config.ini main &
sleep 1

# Launch bar1 and bar2
for m in $(xrandr --query | grep " connected" | cut -d" " -f1 | grep -v "eDP-1"); do
  MONITOR=$m polybar -c ~/.config/polybar/config.ini secondary &
done
