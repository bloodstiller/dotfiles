#!/usr/bin/env bash

# Check if hyprshade is running
if pgrep -x "hyprshade" >/dev/null 2>&1; then
        hyprshade off
        echo '{"text":"off","class":"off","alt":"off"}'
else
        hyprshade on blue-light-filter
        echo '{"text":"on","class":"on","alt":"on"}'
fi
