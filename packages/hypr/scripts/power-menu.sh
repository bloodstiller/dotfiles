#!/usr/bin/env bash

entries="Logout Suspend Reboot Shutdown"

selected=$(printf '%s\n' $entries | wofi --conf=$HOME/.config/wofi/config.power --style=$HOME/.config/wofi/style.widgets.css | awk '{print tolower($1)}')

case $selected in
logout)
  exec hyprctl dispatch exit 1
  ;;
suspend)
  exec systemctl suspend
  ;;
reboot)
  exec systemctl reboot
  ;;
shutdown)
  exec systemctl poweroff -i
  ;;
esac
