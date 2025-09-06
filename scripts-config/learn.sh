#!/bin/bash
# Display our helpful reference manual, 'learn', using a keybinding (Super+Shift+H)
# Helps the user learn how to use wiredWM with built-in documentation.  
help="manual/manual.html"
foot -e elinks $help
