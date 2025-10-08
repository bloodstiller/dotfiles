#!/usr/bin/env bash

# Simple toggle using a state file
STATE_FILE="/tmp/hyprsunset_state"

if [ -f "$STATE_FILE" ]; then
    # Currently on, turn off
    hyprctl hyprsunset temperature 6500
    rm "$STATE_FILE"
    echo '{"text":"off","class":"off","alt":"off"}'
else
    # Currently off, turn on
    hyprctl hyprsunset temperature 2000
    touch "$STATE_FILE"
    echo '{"text":"on","class":"on","alt":"on"}'
fi
