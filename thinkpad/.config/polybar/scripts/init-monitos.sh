# find out if second monitor is connected
if [[ $(xrandr --listactivemonitors | awk '!/Monitors/ {print $4}' | grep DVI-I-1-1) == "DVI-I-1-1" ]]; then
    xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1 --off --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --off --output DVI-I-1-1 --mode 1920x1080 --pos 1920x0 --rotate normal
fi

GREEN='\033[0;36m'
NC='\033[0m' # No Color
echo -e "Connected monitors:" ${GREEN}$(xrandr --listmonitors | awk '!/Monitors/ {print $4}')
