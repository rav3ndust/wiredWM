#!/bin/bash
# Display our helpful reference manual, 'learn', using a keybinding (Super+Shift+H)
# Helps the user learn how to use navi/wired with built-in documentation. 
# the manual is a small website written in html and displayed using terminal browsers such as elinks.
# this also allows us to have the same reference manual available on the web for easy reference. 
help="$HOME/$USER/wiredWM/scripts-config/manual/manual.html"
alacritty -e elinks "$help"
