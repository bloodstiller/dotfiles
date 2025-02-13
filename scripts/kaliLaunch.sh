#!/usr/bin/env sh
#
# Launches a new instance of Alacritty and runs a specified command within it

# Command to start Kali, wait, and then connect via xfreerdp
CMD='virsh --connect qemu:///system start Kali && echo "Please wait, Kali VM starting & RDP Server Starting" && sleep 30 && nohup xfreerdp3 /v:192.168.122.66 /u:kali /size:100% /dynamic-resolution /gfx:progressive /d:'

# Launch Alacritty and execute the command
alacritty -e sh -c "$CMD"
