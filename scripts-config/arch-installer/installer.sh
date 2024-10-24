#!/bin/bash
# nightshade Auto Installer
###########################################################################################################################
# Applies wiredWM, custom configs, scripts and more to a vanilla Arch install. 						  #
# Running this will give you a complete, functioning Arch setup with the "nightshade customizations" automatically.       #
###########################################################################################################################
# installer.sh -> for wiredWM
# This is the installer script for wiredWM.
# Assumes an Arch Linux environment.
# Important info for config files:
# - i3 config lives at /etc/i3/config and ~/.config/i3/config
# - i3status config lives at /etc/i3status.conf
# - dunst config (dunstrc) needs to live at /etc/dunst/dunstrc, and be copied to ~/.config/dunst/dunstrc
# - conky.conf lives at /etc/conky/conky.conf
# - polybar config lives at ~/.config/polybar/config.ini
###############################
# Some notes on the packages we need to download on installation:
# - we use *sddm* for login manager.
# - we have *fish* as a secondary shell with highlighting and autocomplete.
# - we use *flameshot* for taking screenshots.
# - we use *nm-applet* for handling networks - i3 ships with this.
# - we use *nitrogen* for handling wallpaper selection and restoring with GUI.
# - we use *feh* for handling wallpapers through CLI.
# - we use *arandr* for graphical display management.
# - we use *polybar* for handling status bar.
# - we use *kitty* and *alacritty* for lightweight terminals.
#	- users can set their favorite terminal in the i3 config file.
# - we have custom scripts built on top of surf browser called "nightsurf"
# - we also have a custom conky, so we need the *conky* package.
# - we use *vim* and *micro* for text editing in the terminal.
# - we use *code* for GUI text editing.
# - we use *rofi* for a simple run launcher.
# - we use *picom* for handling display compositing.
# - we use *nnn* as a terminal file browser.
# - we use *nemo* as a graphical file browser.
# - we also include *chromium* and *firefox* for web browsing.
# - we include *amfora* for browsing the Gemini network.
# - we have *xautolock* that runs *i3lock* after 10 mins of system inactivity.
# - we have *polkit-dumb-agent* for handling granting elevated user privs.
###############################
i3_CONFIG_1_LOCATION="/etc/i3/config"
i3_CONFIG_2_LOCATION="$HOME/.config/i3/config"
WIRED_i3_CONFIG="$HOME/wiredWM/scripts-config/configs/i3-config"
i3STATUS_LOCATION="/etc/i3status.conf"
WIRED_i3STATUS_CONFIG="$HOME/wiredWM/scripts-config/configs/i3status-config"
CONKY_CONFIG_LOCATION="/etc/conky/conky.conf"
WIRED_CONKY_CONFIG="$HOME/wiredWM/scripts-config/configs/conky.conf"
DUNSTRC_CONFIG_LOCATION_1="/etc/dunst/dunstrc"
DUNSTRC_CONFIG_LOCATION_2="$HOME/.config/dunst/dunstrc"
WIRED_DUNSTRC="$HOME/wiredWM/scripts-config/configs/dunstrc"
VIM_CONFIG="$HOME/.vimrc"
WIRED_VIM_CONFIG="$HOME/wiredWM/scripts-config/configs/vimrc"
POLYBAR_WIRED_CONFIG="$HOME/wiredWM/scripts-config/polybar-config/config.ini"
POLYBAR_CONFIG_LOCATION="$HOME/.config/polybar/config.ini"
DEF_WP_LOCATION="$HOME/wiredWM/wp/lain2.jpg"
CONFIGS="$HOME/wiredWM/scripts-config/configs"
################################
makeFolders () {
	# this function creates the necessary folders needed for some of our config files
	sudo mkdir /etc/i3 && sudo touch /etc/i3/config
	sudo mkdir $HOME/.config/i3 && sudo touch $HOME/.config/i3/config
	sudo touch /etc/i3status.conf
	sudo mkdir /etc/dunst && sudo touch /etc/dunst/dunstrc
	sudo mkdir $HOME/.config/dunst && sudo touch $HOME/.config/dunst/dunstrc
	sudo mkdir /etc/conky && sudo touch /etc/conky/conky.conf
}
updater () {		
	# this function updates arch repos
	sudo pacman -Sy
}
i3_install () {		
	# this function installs vanilla i3
	sudo pacman -S i3-wm i3status
}
wired_packs () {	
	# this function intalls the needed deps for wiredWM
	sudo pacman -S git nitrogen lxsession lxapperance arandr xterm xscreensaver fish xorg-xkill xautolock flameshot alacritty micro dunst amfora kitty feh code network-manager-applet conky vim sddm nnn picom chromium nemo volumeicon pavucontrol okular rofi
}
enable_AUR () {		
	# builds yay for using the AUR
	echo "Enabling the Arch User Repository (AUR)..."
	echo "Cloning the 'yay' repository from https://aur.archlinux.org/yay.git..."
	git clone https://aur.archlinux.org/yay.git
	echo "Yay downloaded. Building..."
	cd yay && makepkg -si
	echo "Yay AUR helper built."
}
meteo_qt_install () {
	# grabs meteo-qt from the aur.
 	# on wired, we use this to give the user a convenient way to display the weather in their i3bar.
  	local pkg="meteo-qt"
   	echo "Installing $pkg for you - it shows the weather in your i3bar!" && sleep 1
    	yay -S $pkg
     	echo "$pkg installed." && sleep 1
}
polkit-dumb-install () { 
	# builds polkit-dumb-agent
	echo "Installing polkit agent for superuser priveleges..."
	yay -S polkit-dumb-agent
	echo "Polkit agent installed."
}
# script begins here
# update system first and install needed wiredWM packages.
echo "Preparing your wiredWM install..."
sleep 1
echo "Updating the repositories..."
updater
sleep 1
# download Yay AUR Helper and build it.
enable_AUR
sleep 1
# install wiredWM repo and needed packages.
# we also want to grab i3lock-fancy-git from AUR (for WM lockscreen)
echo "Downloading needed packages for wiredWM..."
wired_packs
sleep 1
echo "WiredWM packages installed."
echo "Downloading i3lock-fancy from AUR..."
yay -S i3lock-fancy-git
echo "Lockscreen downloaded. Moving on..."
# install vanilla i3 and its components.
echo "Downloading i3 and its components. Please be patient."
i3_install
sleep 1
# grab meteo-qt for displaying weather in i3bar
meteo_qt_install
# download polkit-dumb-agent from AUR for elevated privs when needed.
polkit-dumb-install
sleep 1
# make needed directories and files
echo "Creating folders for config files..."
makeFolders
sleep 1
# apply the i3-config file to /etc/i3/config and ~/.config/i3/config
echo "Copying wiredWM configuration files..."
sleep 1
echo "Copying i3-config..."
sudo cp -f $WIRED_i3_CONFIG $i3_CONFIG_1_LOCATION
sudo cp -f $WIRED_i3_CONFIG $i3_CONFIG_2_LOCATION
echo "Done! If needed, you can edit your configuration files at ~/.config/i3/config anytime."
sleep 1
# apply the i3status-config file to /etc/i3status.conf
echo "Copying i3status-config..."
sudo cp -f $WIRED_i3STATUS_CONFIG $i3STATUS_LOCATION
sleep 1
echo "i3status-config copied." && sleep 1
echo "You can edit it anytime at /etc/i3status.conf" && sleep 1
# apply the conky config to /etc/conky/conky.conf
echo "Copying conky.conf..."
sudo cp -f $WIRED_CONKY_CONFIG $CONKY_CONFIG_LOCATION
sleep 1
echo "conky.conf copied." && sleep 1
echo "You can edit conky at /etc/conky/conky.conf anytime." && sleep 1
# apply the dunstrc to /etc/dunst/dunstrc and ~/config.dunst/dunstrc
echo "Copying dunstrc..."
sudo mkdir /etc/dunst && sudo touch /etc/dunst/dunstrc
sudo mkdir ~/.config/dunst && sudo touch ~/.config/dunst/dunstrc
sudo cp -f $WIRED_DUNSTRC $DUNSTRC_CONFIG_LOCATION_1
sudo cp -f $WIRED_DUNSTRC $DUNSTRC_CONFIG_LOCATION_2
echo "dunstrc copied." && sleep 1
# apply the vimrc to ~/.vimrc
echo "Copying vim configs..."
sudo cp -f $WIRED_VIM_CONFIG $VIM_CONFIG
echo "Vim configs copied. You can change it at ~/.vimrc."
# apply the polybar config to ~/.config/polybar/config.ini
echo "Copying polybar configs..."
sudo cp -f $POLYBAR_WIRED_CONFIG $POLYBAR_CONFIG_LOCATION
echo "Polybar config copied. Edit it anytime at ~/.config/polybar/config.ini."
# set the default background image.
# we are going to use wp/nExt.png.
echo "Setting default wallpaper..." && sleep 1
feh --bg-scale $DEF_WP_LOCATION
echo "Wallpaper saved. To change it, simply launch Nitrogen and choose whatever you would like." && sleep 1
# all done
echo "wiredWM has been installed." && sleep 1
echo "In order to log into it, please log out of your current X Session and log into 'i3', which you can now find in your desktop environment list in your login manager." && sleep 1
notify-send "wiredWM installer" "wiredWM has been installed."
sleep 1 && exit
