#!/usr/bin/env bash

## Author  : Aditya Shakya
## Mail    : adi1090x@gmail.com
## Github  : @adi1090x
## Twitter : @adi1090x

style="$($HOME/.config/rofi/applets/applets/style.sh)"

dir="$HOME/.config/rofi/applets/applets/configs/$style"
rofi_command="rofi -theme $dir/powermenu.rasi"

uptime=$(uptime -p | sed -e 's/up //g')
cpu=$($HOME/.config/rofi/bin/usedcpu)
memory=$($HOME/.config/rofi/bin/usedram)

# Options
shutdown=""
reboot=""
lock=""
hibernate=""
logout=""

# Variable passed to rofi
options="$shutdown\n$reboot\n$lock\n$hibernate\n$logout"

chosen="$(echo -e "$options" | $rofi_command -p "UP - $uptime" -dmenu -selected-row 2)"
case $chosen in
    $shutdown)
		systemctl poweroff
		
        ;;
    $reboot)
		systemctl reboot
		
        ;;
    $lock)
		betterlockscreen -l dim
        ;;
    $hibernate)
		mpc -q pause
		amixer set Master mute
		systemctl hibernate
		betterlockscreen -l dim
		
        ;;
    $logout)
		i3-msg exit
        ;;
esac
