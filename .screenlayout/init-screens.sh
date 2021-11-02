# find out the active monitor (tv or desk-monitors) and set corresponding sink
if [[ $(xrandr --listactivemonitors | awk '!/Monitors/ {print $4}' | grep DP-2) == "DP-2" ]]; then
    MAIN_MONITOR=DP-2
    if [ -z $(xrandr --listactivemonitors | awk '!/Monitors/ {print $4}' | grep HDMI-0) ]
    then
	xrandr --output DP-0 --off --output DP-1 --off --output HDMI-0 --off --output DP-2 --primary --mode 2560x1440 --pos 1080x240 --rotate normal --output DP-3 --off --output DP-4 --off --output DP-5 --mode 1920x1080 --pos 0x0 --rotate left
    else
	xrandr --output DP-0 --off --output DP-1 --off --output HDMI-0 --mode 1920x1080 --pos 0x0 --rotate left --output DP-2 --primary --mode 2560x1440 --pos 1080x240 --rotate normal --output DP-3 --off --output DP-4 --off --output DP-5 --mode 1920x1080 --pos 0x0 --rotate left
    fi
    default_sink=$(pacmd list-sinks | grep -e 'name:' -e 'index:' | grep "Creative" | awk '{print $2}'| awk '{print substr($0, 2, length($0) - 2)}')
    if [ -z "$default_sink" ]
    then
	sleep 1
	default_sink=$(pacmd list-sinks | grep -e 'name:' -e 'index:' | grep "hdmi" | awk '{print $2}'| awk '{print substr($0, 2, length($0) - 2)}')
    else
	/home/lluks/.config/setmic.sh
    fi
    pactl set-default-sink $default_sink
else
    MAIN_MONITOR=HDMI-0
    xrandr --output DP-0 --off --output DP-1 --off --output HDMI-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-2 --off --output DP-3 --off --output DP-4 --off --output DP-5 --off
    sleep 1
    pactl set-default-sink $(pacmd list-sinks | grep -e 'name:' -e 'index:' | grep "hdmi" | awk '{print $2}'| awk '{print substr($0, 2, length($0) - 2)}')
fi

GREEN='\033[0;36m'
NC='\033[0m' # No Color
echo -e "Connected monitors:" ${GREEN}$(xrandr --listmonitors | awk '!/Monitors/ {print $4}')
echo -e "${NC}Primary monitor:" ${GREEN}$MAIN_MONITOR
echo -e "${NC}Default sink:" ${GREEN}$default_sink
