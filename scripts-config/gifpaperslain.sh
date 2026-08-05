#!/usr/bin/env bash
# gifpaperslain
#     by rav3ndust.xyz (xvoidsx)
# A simple way to set animated wallpapers in naviOS.
# Uses 'mpvpaper' and 'zenity' on the backend.
set -e
x="gifpaperslain"
notifier () {
	notify-send -u low -t 2000 --transient "$x" "Displaying available animated wallpaper selections."
}
kill_last_instance () {
	# kills the last instance of mpvpaper if one is running
	killall mpvpaper
}
main () {
	notifier
	gifpaper=$(zenity --file-selection --title "$x | Select an animated wallpaper:" --filename="$HOME/wiredWM/wp/gifpaperslain/")
	kill_last_instance
	mpvpaper ALL -o "loop panscan=1" "$gifpaper" 
}
main
