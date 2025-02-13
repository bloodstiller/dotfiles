#!/bin/bash

killall waybar && waybar & 2>/dev/null
#CONFIG_FILES="$HOME/.config/waybar/config $HOME/.config/waybar/style.css"
#
#trap "killall waybar" EXIT
#
#while true; do
	    #waybar &
	        #inotifywait -e create,modify $CONFIG_FILES
		    #killall waybar
	    #done
#waybar &
#
