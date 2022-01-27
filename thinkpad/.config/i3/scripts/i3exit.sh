#!/bin/sh


case "$1" in
    lock)
        --no-startup-id i3exit lock, mode "default"
        ;;
    logout)
    	--no-startup-id i3exit logout, mode "default"
        ;;
    suspend)
        --no-startup-id i3exit suspend, mode "default"
        ;;
    hibernate)
        --no-startup-id i3exit hibernate, mode "default"
        ;;
    reboot)
        --no-startup-id i3exit reboot, mode "default"
        ;;
    shutdown)
        --no-startup-id i3exit shutdown, mode "default"
        ;;
    *)
        echo "Usage: $0 {lock|logout|suspend|hibernate|reboot|shutdown}"
        exit 2
esac

exit 0
