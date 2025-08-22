#!/bin/bash
# - - - wired power menu - - -
# power menu script for our polybar to match our waybar's custom/power launcher
# - this file should be copied to /usr/bin/power_menu
MENU="$(rofi -sep '|' -dmenu -p 'wired system menu' <<< 'shutdown|reboot|suspend|hibernate')"
case "$MENU" in
    shutdown) systemctl poweroff ;;
    reboot) systemctl reboot ;;
    suspend) systemctl suspend ;;
    hibernate) systemctl hibernate ;;
esac
