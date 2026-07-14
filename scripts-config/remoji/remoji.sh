#!/bin/sh
# - - - - - - - - - - - - - - - -
# remoji: 
# emoji picker for wiredWM/naviOS
# - - - - - - - - - - - - - - - -
set -e
emojidir="$HOME/wiredWM/scripts-config/remoji"
emojifile="$emojidir/emojis.txt"
# funcs
die () {
	printf "%s\n" "$1"
	exit 1
}
depends () {
	for dep in "$@"; do
		command -v "$dep" > /dev/null || die "$dep not found"
	done
}
# make sure dependencies are installed
depends rofi wl-copy
if [ ! -f "$emojifile" ]; then
	die "Error: '$emojifile' wasn't found. Please ensure emojis.txt is in the same directory as this script."
fi
# pipe emojifile into rofi, extract the emoji, copy it to wayland's clipboard
emoji=$(cat "$emojifile" | rofi -dmenu | cut -d " " -f 1 | tr -d '\n')
if [ "$emoji" ]; then
	wl-copy "$emoji"
fi
exit 0
