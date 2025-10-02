#!/bin/bash
#set -euo pipefail
########################################################
# installer.sh -> for wiredWM
#	- by @rav3ndust (https://github.com/rav3ndust.xyz)
#	( NOTE: This version of the script is for Debian-based installations.)
# This is the installer script for wiredWM. 
# Important info for config files: 
# - sway config lives at ~/.config/sway/config
# - i3 config lives at /etc/i3/config and ~/.config/i3/config
# - i3status config lives at /etc/i3status.conf
# - dunst config (dunstrc) needs to live at /etc/dunst/dunstrc, and be copied to ~/.config/dunst/dunstrc
# - conky.conf lives at /etc/conky/conky.conf
########################################################
# Some notes on the packages we need to download on installation: 
# - we use *grimshot* for taking screenshots.
# - we use *nm-applet* for handling networks - i3 ships with this.
# - we use *blueman* for handling bluetooth connections. 
#	- *blueman-applet* is the applet for interfacing with connections.
# - we use *nitrogen* for handling wallpaper selection and restoring with GUI.
# - we use *feh* for handling wallpapers through CLI.
# - we use *arandr* for graphical display management.
# - we use *volumeicon* for a GUI-friendly way of volume management.
# - we use *kitty* and *stterm* for lightweight terminals.
#	- note that stterm will be better for older machines.
#	- users can set their favorite terminal in the i3 config file.
# - we have custom scripts built on top of surf browser called "nightsurf"
# - we also have a custom conky, so we need the *conky* package.
# - we use *vim* for text editing.
# - *suckless-tools* is a collection of small software tools from the Suckless community.
# - we include *sxiv* as a minimal image viewer
# - we use *lxpolkit* for user authentication when elevated system privs are needed.
# - we use *lxappearance* for handling things like cursor selection and other graphical tweaks.
# - we use *nnn* for terminal file management. 
# - we use *cmus* for playing audio in the terminal. 
# - we use *mpv* for handling multimedia files.
# - we use *slock* for handling locking functionality and auto-locking.
# - there is a choice of *picom* or *xcompmgr* for compositing.
# - we use *meteo-qt* for displaying weather info in the i3bar.
# - we use *gsimplecal* as a floating calendar that's accessible when pressing meta+c 
# - we also add *calcurse* for tracking appointments and `TODO`s in the terminal.
# - *tty-clock* is here as a simple, terminal-based clock (used as a clickable element in waybar)
# - we include *fonts-inter* for our fonts
# - we include *pavucontrol* as another way to graphically adjust the volume
# - we use *gnome-characters* for emoji selection and handling
# - we include *tmux* for terminal multiplexing
# - - - - - - - - - - - - - - - 
# wayland-specific stuff
# - we are using, of course, sway to base all of our wired configs on
# - *swaybg* handles what nitrogen normally would, backgrounds/wallpapers
# - *waybar*, heavily configured, handles our status bar needs
# - *grimshot* and *flameshot* are both here
# - *calcurse can be used by clicking on the date in waybar
# - *xdg-desktop-portal-wlr* handles wlroots desktop portals
# - we have our wrapper around *swaylock* called *nslock* which is a custom lockscreen
# - we include *wf-recorder* for recording the screen
########################################################
WIRED_X11_CONFIG="$HOME/wiredWM/scripts-config/configs/display-configs/config-x11"
WIRED_WAYLAND_CONFIG="$HOME/wiredWM/scripts-config/configs/display-configs/config-wayland"
WIRED_X11_CONFIG_LOCATION="$HOME/.config/i3/config"
WIRED_WAYLAND_CONFIG_LOCATION="$HOME/.config/sway/config"
i3STATUS_LOCATION="/etc/i3status.conf"
WIRED_i3STATUS_CONFIG="$HOME/wiredWM/scripts-config/configs/i3status-config"
WIRED_POLYBAR_CONFIG="$HOME/wiredWM/scripts-config/configs/polybar-config/config.ini"
WIRED_POLYBAR_LOCATION="/etc/polybar/config.ini"
WIRED_PICOM_CONFIG="$HOME/wiredWM/scripts-config/configs/picom.conf"
WIRED_PICOM_LOCATION="$HOME/.config/picom/picom.conf"
CONKY_CONFIG_LOCATION="/etc/conky/conky.conf"
WIRED_CONKY_CONFIG="$HOME/wiredWM/scripts-config/configs/conky.conf"
DUNSTRC_CONFIG_LOCATION_1="/etc/dunst/dunstrc"
DUNSTRC_CONFIG_LOCATION_2="$HOME/.config/dunst/dunstrc"
WIRED_DUNSTRC="$HOME/wiredWM/scripts-config/configs/dunstrc" 
VIM_CONFIG="$HOME/.vimrc"
WIRED_VIM_CONFIG="$HOME/wiredWM/scripts-config/configs/vimrc" 
DEF_WP_LOCATION="$HOME/wiredWM/wp/lain3wp.jpg"
WAYBAR_CONFIG="$HOME/wiredWM/scripts-config/configs/wayland-config/config.jsonc"
WAYBAR_CONFIG_LOCATION="/etc/xdg/waybar/config.jsonc"
WAYBAR_USER_CONFIG_LOCATION="$HOME/.config/waybar/config.jsonc"
WAYBAR_CSS_CONFIG="$HOME/wiredWM/scripts-config/configs/wayland-config/style.css"
WAYBAR_CSS_CONFIG_LOCATION="/etc/xdg/waybar/style.css"
ROFI_CONFIG="$HOME/wiredWM/scripts-config/configs/rofi-config/config.rasi"
ROFI_CONFIG_LOCATION="$HOME/.config/rofi/config.rasi"
TMUX_CONFIG="$HOME/wiredWM/scripts-config/configs/tmux.conf"
TMUX_CONFIG_LOCATION="$HOME/.tmux.conf"
FOOT_CONFIG="$HOME/wiredWM/scripts-config/configs/foot.ini"
FOOT_CONFIG_LOCATION="$HOME/.config/foot/foot.ini"
ALACRITTY_CONFIG="$HOME/wiredWM/scripts-config/configs/alacritty.toml"
ALACRITTY_CONFIG_LOCATION="$HOME/.config/alacritty/alacritty.toml"
########################################################
# - - - Functions - - - 
########################################################
make_folders () {
	# this function handles wm config
	echo "Creating folders for config files..."
	sleep 1
	sudo mkdir -p /etc/i3 && sudo touch /etc/i3/config
	sudo mkdir -p $HOME/.config/i3 && sudo touch $HOME/.config/i3/config
 	sudo mkdir -p $HOME/.config/sway && sudo touch $HOME/.config/sway/config
	sudo touch /etc/i3status.conf
	sudo mkdir -p /etc/dunst && sudo touch /etc/dunst/dunstrc
 	sudo mkdir -p $HOME/.config/waybar && sudo touch $HOME/.config/waybar/config.jsonc
	sudo mkdir -p $HOME/.config/dunst && sudo touch $HOME/.config/dunst/dunstrc
	sudo mkdir -p /etc/conky && sudo touch /etc/conky/conky.conf
    sudo mkdir -p /etc/polybar && sudo touch /etc/polybar/config.ini
    sudo mkdir -p $HOME/.config/picom && sudo touch $HOME/.config/picom/picom.conf
 	sudo mkdir -p $HOME/.config/rofi && sudo touch $HOME/.config/rofi/config.rasi 
    sudo mkdir -p $HOME/.config/foot && sudo touch $HOME/.config/foot/foot.ini
	sudo mkdir -p $HOME/.config/alacritty && sudo touch $HOME/.config/alacritty/alacritty.toml
	# we also ensure $HOME/Pictures/Screenshots exists, as we use this location as the default folder for saving screenshots 
    mkdir -p $HOME/Pictures/Screenshots
}
install_wired_pkgs () {	
	# this function updates and intalls the needed deps for wiredWM
	sudo apt-get update
	sudo apt-get install -y i3 i3lock-fancy nitrogen pamixer opendoas pulseaudio-utils xcompmgr picom waybar slock alacritty fonts-inter xterm arandr nemo rofi xss-lock feh sxiv volumeicon-alsa polybar blueman dunst flameshot meteo-qt pasystray ffmpeg kitty stterm surf conky-all suckless-tools lxpolkit lxappearance vim nnn cmus xscreensaver amfora sway swaylock swayidle swaybg grimshot xdg-desktop-portal-wlr qt5ct tty-clock wf-recorder sakura foot gsimplecal calcurse pavucontrol yaru-theme-gtk yaru-theme-icon glow pipx gnome-characters tmux shotman nwg-look fonts-jetbrains-mono fonts-firacode fonts-noto wdisplays papirus-icon-theme fonts-font-awesome fonts-material-design-icons-iconfont bibata-cursor-theme
} 
apply_configs () {
	# this function applies the configs for: 
	#	- i3
	#	- i3status
    #   - polybar
	#   - picom
	#	- conky
	#	- dunst
	#	- vim
    #   - sway
	#	- waybar
 	#	- rofi
  	#	- tmux
    #   - alacritty
	#   - foot
	#	- other wayland-specific stuff
   	echo "Copying navi configuration files..." && sleep 1
    # apply the x11 config file to ~/.config/i3/config
    echo "Copying x11 config..." && sleep 1
	sudo cp -f $WIRED_X11_CONFIG $WIRED_X11_CONFIG_LOCATION
	echo "wired X11 configuration applied." && sleep 1
    # apply the wayland config file to ~/.config/sway/config
	echo "Copying wayland config..." && sleep 1
    sudo cp -f $WIRED_WAYLAND_CONFIG $WIRED_WAYLAND_CONFIG_LOCATION
	echo "wired Wayland configuration applied." && sleep 1
	# apply the i3status-config file to /etc/i3status.conf
	echo "Copying i3status-config..."
	sudo cp -f $WIRED_i3STATUS_CONFIG $i3STATUS_LOCATION
	echo "i3status-config copied." && sleep 1
	echo "You can edit it anytime at /etc/i3status.conf" && sleep 1
    # apply the polybar config to /etc/polybar/config.ini
	echo "Copying polybar config..."
    sudo cp -f $WIRED_POLYBAR_CONFIG $WIRED_POLYBAR_LOCATION
    echo "Polybar config has been copied." && sleep 1 
	# apply the picom config to .config/picom/picom.conf
    echo "Copying picom config..."; sleep 1
	sudo cp -f $WIRED_PICOM_CONFIG $WIRED_PICOM_LOCATION
    echo "Picom config has been copied."; sleep 1
	# apply the conky config to /etc/conky/conky.conf
	echo "Copying conky.conf..."
	sudo cp -f $WIRED_CONKY_CONFIG $CONKY_CONFIG_LOCATION
	sleep 1
	echo "conky.conf copied." && sleep 1
	echo "You can edit conky at /etc/conky/conky.conf anytime." && sleep 1
	# apply the dunstrc to /etc/dunst/dunstrc and ~/.config/dunst/dunstrc
	echo "Copying dunstrc..."
	sudo mkdir -p /etc/dunst && sudo touch /etc/dunst/dunstrc
	sudo mkdir -p ~/.config/dunst && sudo touch ~/.config/dunst/dunstrc
	sudo cp -f $WIRED_DUNSTRC $DUNSTRC_CONFIG_LOCATION_1
	sudo cp -f $WIRED_DUNSTRC $DUNSTRC_CONFIG_LOCATION_2
	echo "dunstrc copied." && sleep 1
	# apply the vimrc to ~/.vimrc
	echo "Copying vim configs..."
	sudo cp -f $WIRED_VIM_CONFIG $VIM_CONFIG
	echo "Vim configs copied. You can change it at ~/.vimrc."
	sleep 1 
	# apply the waybar config and stylesheet to /etc/xdg/waybar/config and /etc/xdg/waybar/style.css respectively (wayland)
	echo "Copying waybar configs..." && sleep 1
	sudo cp -f $WAYBAR_CONFIG $WAYBAR_CONFIG_LOCATION			# config file copy
 	sudo cp -f $WAYBAR_CONFIG $WAYBAR_USER_CONFIG_LOCATION      # user-config copy
	sudo cp -f $WAYBAR_CSS_CONFIG $WAYBAR_CSS_CONFIG_LOCATION	# stylesheet copy
	echo "waybar configs copied." && sleep 1
 	# apply for config for rofi ($HOME/.config/rofi/config.rasi)
  	echo "Copying rofi config..." && sleep 1
   	sudo cp -f $ROFI_CONFIG $ROFI_CONFIG_LOCATION
    echo "rofi config copied." && sleep 1
    # apply the config for our foot terminal ($HOME/.config/foot/foot.ini)
	echo "Copying foot config..." && sleep 1
 	sudo cp -f $FOOT_CONFIG $FOOT_CONFIG_LOCATION
  	echo "foot config copied." && sleep 1
	# apply the config for tmux
    # our tmux config applies a wiredWM-like scheme and keyboard shortcuts for the tmux environment
	echo "Copying tmux config..." && sleep 1
 	sudo cp -f $TMUX_CONFIG $TMUX_CONFIG_LOCATION
  	echo "tmux config has been copied." && sleep 1
    # apply the config for alacritty
	echo "Copying alacritty config..." && sleep 1
    sudo cp -f $ALACRITTY_CONFIG $ALACRITTY_CONFIG_LOCATION
	echo "alacritty config has been copied." && sleep 1
    # function to make sure the environment is correct
	apply_environment () {
 	    # applies 'environment' to /etc/environment
	    # ensures the PATH is correctly passed to wired
	    local environ="/etc/environment"
	    sudo cp -f environment $environ
	 }
	# function for creating our custom lockscreen (wayland)
 	apply_nslock() {
  		# applies the nslock script to /usr/bin. is only used on wayland.
		local nslock_script="$HOME/wiredWM/scripts-config/locker-scripts/nslock.sh"
  		local nslock_exec_location="/usr/bin/nslock"
    	echo "Applying nslock to $nslock_exec_location..."; sleep 1 
  		chmod +x $nslock_script; sudo cp $nslock_script $nslock_exec_location
    	echo "Done."; sleep 1
  	}
   copy_learn_script () {
   		# applies the learning script for showing keybindings as a helpful resource (accessible by pressing $mod+Shift+H)
	    local learn_script="learn.sh"
	    chmod +x $learn_script; sudo cp $learn_script /usr/bin/learn
	 }
    copy_power_menu () {
	    # applies the wired_power_menu script to /usr/bin/power_menu
		local power_menu="$HOME/wiredWM/scripts-config/wired_power_menu.sh"
        chmod +x $power_menu; sudo cp $power_menu /usr/bin/power_menu
	}
    apply_environment
   	apply_nslock
	copy_learn_script
    copy_power_menu
}
setup_doas () {
	# sets up 'opendoas': a great alternative to 'sudo'
    echo "Configuring doas for privilege escalation..."; sleep 1
	sudo touch /etc/doas.conf
    # allow $USER to run root commands
	echo "permit persist "${USER}" as root" | sudo tee /etc/doas.conf
    echo "Doas has been installed and configured."; sleep 1
	echo "You can now use doas instead of sudo for privilege escalation, if you prefer."; sleep 1
 }
 setup_flatpak () {
    # ensure flatpak and flathub are setup for extra apps, if the user wants them
	echo "Setting up Flatpak and configuring Flathub for extra software availability..."; sleep 1
    sudo apt install flatpak gnome-software-plugin-flatpak -y
	flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    echo "Flatpak is now setup and configured with Flathub so you can choose apps that might not be available or up to date in standard repos."; sleep 1
	echo "Open the Software Center or visit https://flathub.org to view and choose extra software!"; sleep 1
}
wp_set () {
	# this function uses nitrogen to set the default wallpaper.
	# we are going to use wp/lainwp3.png.
	echo "Setting default wallpaper..." && sleep 1
	nitrogen --set-scaled $DEF_WP_LOCATION
	echo "Wallpaper saved. To change it, simply launch Nitrogen and choose whatever you would like." 
	sleep 1 
}
override_fp () {
	# when running flatpak applications, some apps don't respect user appearance settings. 
 	# we noticed an issue with cursors being consistent on certain apps, such as firefox. 
  	# this function runs flatpak override commands to make the appearance more consistent.
   	local location_1="/home/$USER/.icons/"
    local location_2="/usr/share/icons/"
     echo "Overriding Flatpak appearance settings..." && sleep 1
     flatpak --user override --filesystem=$location_1:ro
     flatpak --user override --filesystem=$location_2:ro
     echo "Flatpak overrides finished." && sleep 1
}
main () {
	# 'main' function
	# update system and install needed wiredWM packages.
	echo "Updating repositories and preparing for installation..."
	sleep 1
	install_wired_pkgs		
	make_folders				
	apply_configs
    setup_doas
 	override_fp
	wp_set					
	# x x x x x x x x x x x x x x x x x x 
	# - - - finish up
	echo "wiredWM has been installed." && sleep 1
	echo "Preparing to exit..." 
	sleep 3 && exit 
}
########################################################
# Script Entry Point
########################################################
main
