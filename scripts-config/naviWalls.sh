#!/usr/bin/env bash
#	naviWalls
#	  by rav3ndust.xyz (xvoidsx)
# A simple way to change the desktop wallpaper in Wired.
# It uses `swaybg` and `zenity` on the backend.
set -e
nw="naviWalls"
notifier () {
	# sends a notification to the user
	notify-send -u low -t 2000 --transient "$nw" "Displaying available wallpaper selections."
}
original_removal () {
	# we need to stop the original wallpaper from displaying
	killall swaybg
}
main () {
	# TODO fill out logic here
	notifier
	new_wall=$(zenity --file-selection --title "$nw | Select a new wallpaper:" --filename="$HOME/wiredWM/wp/")
	original_removal
	swaybg -m fill -i "$new_wall" &
}
# - - - entry
main
