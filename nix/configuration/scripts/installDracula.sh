#!/bin/bash

# Check if ~/.themes directory exists
if [ ! -d "$HOME/.themes" ]; then
    echo "Creating ~/.themes directory..."
    mkdir -p "$HOME/.themes"
fi

# Download Dracula theme zip file
echo "Downloading Dracula theme..."
wget -O "$HOME/.themes/master.zip" https://github.com/dracula/gtk/archive/master.zip

# Extract the zip file
echo "Extracting Dracula theme..."
unzip "$HOME/.themes/master.zip" -d "$HOME/.themes"

# Rename extracted folder to Dracula
mv "$HOME/.themes/gtk-master" "$HOME/.themes/Dracula"

# Apply the theme using gsettings
echo "Applying Dracula theme..."
gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
gsettings set org.gnome.desktop.wm.preferences theme "Dracula"

echo "Dracula theme installation completed."
