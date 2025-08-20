#!/bin/bash
# power menu script for our polybar to match our waybar's custom/power launcher
# - this file should be copied to /usr/bin/power_menu
MENU="$(rofi -sep '|' -dmenu -p 'Power Menu' <<< 'Shutdown|Reboot|Suspend|Hibernate')"
case "$MENU" in
    Shutdown) systemctl poweroff ;;
    Reboot) reboot ;;
    Suspend) systemctl suspend ;;
    Hibernate) systemctl hibernate ;;
esac
