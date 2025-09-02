#!/usr/bin/env bash

# Get list of available wifi connections and format it
wifi_list=$(nmcli --fields "SECURITY,SSID" device wifi list | sed 1d | sed 's/  */ /g' | sed -E "s/WPA*.?\S/ /g" | sed "s/^--/ /g" | sed "s/  //g" | sed "/--/d")

# Check if connected
connected=$(nmcli -fields WIFI g)
if [[ "$connected" =~ "enabled" ]]; then
        toggle="󰖪  Disable WiFi"
elif [[ "$connected" =~ "disabled" ]]; then
        toggle="󰖩  Enable WiFi"
fi

# Use rofi or wofi to select wifi network
chosen_network=$(echo -e "$toggle\n$wifi_list" | wofi --dmenu --prompt "WiFi: " --lines 10 --width 400 || echo -e "$toggle\n$wifi_list" | rofi -dmenu -i -theme-str 'window {width: 400px;}' -p "WiFi: ")

# Get the selected SSID
chosen_id=$(echo "${chosen_network:3}" | xargs)

if [ "$chosen_network" = "" ]; then
        exit
elif [ "$chosen_network" = "󰖩  Enable WiFi" ]; then
        nmcli radio wifi on
elif [ "$chosen_network" = "󰖪  Disable WiFi" ]; then
        nmcli radio wifi off
else
        # Check if network is saved
        saved_connections=$(nmcli -g NAME connection)
        if [[ $(echo "$saved_connections" | grep -w "$chosen_id") = "$chosen_id" ]]; then
                nmcli connection up id "$chosen_id"
        else
                # If not saved, prompt for password
                if [[ "$chosen_network" =~ "" ]]; then
                        wifi_password=$(echo "" | wofi --dmenu --password --prompt "Password: " --lines 1 || echo "" | rofi -dmenu -password -p "Password: ")
                fi
                nmcli device wifi connect "$chosen_id" password "$wifi_password"
        fi
fi
