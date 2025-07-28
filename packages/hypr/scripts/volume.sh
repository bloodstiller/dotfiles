#!/usr/bin/env sh

# Function to get the current volume
get_current_volume() {
    wpctl get-volume @DEFAULT_AUDIO_SINK@ | sed 's/Volume: //' | awk '{print int($1 * 100)}'
}

# Function to show volume notification
notify_volume() {
    VOLUME=$(get_current_volume)
    
    # Choose icon based on volume level
    if [ "$VOLUME" -ge 70 ]; then
        ICON="󰕾"  # High volume icon
    elif [ "$VOLUME" -ge 30 ]; then
        ICON="󰖀"  # Medium volume icon
    else
        ICON="󰕿"  # Low volume icon
    fi
    
    # Check if muted
    if wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED; then
        ICON="󰖁"  # Muted icon
    fi

    dunstify -t 3000 -r 2593 -a "volume" \
        -h "int:value:${VOLUME}" \
        "$ICON  Volume" \
        "${VOLUME}%"
}

# Check command line arguments
if [[ "$#" != 1 || ! ("$1" == "inc" || "$1" == "dec" || "$1" == "mute" ) ]]; then
    printf "Usage: $0 [inc|dec|mute]\n"
    exit 1
fi

# Check if wpctl is installed
if ! command -v wpctl &> /dev/null; then
    echo "Error: wpctl is not installed. Please install wireplumber and try again."
    exit 1
fi

# Perform volume adjustment
if [[ "$1" == "inc" ]]; then
    [ "$(get_current_volume)" -lt 150 ] && wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
    notify_volume
elif [[ "$1" == "dec" ]]; then
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    notify_volume
elif [[ "$1" == "mute" ]]; then
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    notify_volume
fi
