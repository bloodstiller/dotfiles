#!/usr/bin/env sh

# Command to start Windows, wait, and then connect via xfreerdp

CMD='virsh --connect qemu:///system start Windows11 && echo "Please wait, Windows VM starting & RDP Server Starting" && sleep 40 && nohup xfreerdp3 /v:192.168.122.182 /u:martin /size:100% /dynamic-resolution /gfx:progressive /d:'
# Launch Alacritty and execute the command
alacritty -e sh -c "$CMD"
