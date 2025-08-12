#!/bin/bash
# Display our helpful reference manual, 'learn', using a keybinding (Super+Shift+H)
# Helps the user learn how to use wiredWM with built-in documentation.  
learning_doc="$HOME/wiredWM/scripts-config/learn.txt"
foot bash -c "less $learning_doc"
