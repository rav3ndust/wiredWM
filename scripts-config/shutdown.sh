#!/bin/bash
# shutdown utility for r3-wm
##############
# define functions
###############
# the first function "shutDownAlert" will ask the user if they are sure they want to shut doen 
# if they select YES, the system closes down. if NO, it goes back to the WM. 
function shutDownAlert {
	dialog --title "Shut Down" --backtitle "nightshadeWM Shutdown" --yesno "Are you sure you would like to shut down your machine?" 0 0
}
# function 2 - "shutDown" 
# notifies the user the machine will shut down in 1 min, and exits all processes before shutting down
function shutDown {
	notify-send "nightshadeWM System Notification" "$HOSTNAME will shut down in one minute."
	shutdown -h 1 
}
# these run if the user hits "NO" or the esc key
function dontShutDown {
	notify-send "nightshadeWM System Notification" "You chose not to shut down your computer."
	exit
}
# user-cancellation 
function escPressed {
	notify-send "nightshadeWM System Notification" "Shutdown cancelled by user input."
	exit
}
# run the script
# ask the user for input with a dialog --yesno box 
dialog --title "Shut Down" --backtitle "nightshadeWM Shutdown" --yesno "Are you sure you would like to shut down your machine?" 0 0

# get the exit status. 
# an exit status of 0 indicates a YES answer. 
# an exit status of 1 means the user hit the NO answer. 
# an exit status of 255 indicates the user hit the Esc key. 
shutdownChoice=$?
case $shutdownChoice in 
	0) shutDown;;
	1) dontShutDown;;
	255) escPressed;;
esac
