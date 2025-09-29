#!/usr/bin/env sh

read -p "Enter Lab Name: " lab_name

# Define paths
template_file="$HOME/Dropbox/40-49_Career/44-Blog/bloodstiller/content-org/Templates/PortSwiggerTemplate.org"
dest_dir="$HOME/Notes/portswiggerLabs"
dest_file="$dest_dir/$lab_name.org"

# Check if template exists
if [ ! -f "$template_file" ]; then
    echo "Error: Template file not found at $template_file"
    exit 1
fi

# Check if destination file already exists
if [ -f "$dest_file" ]; then
    echo "Error: File $dest_file already exists"
    exit 1
fi

# Copy the template with new name
cp "$template_file" "$dest_file"

# Confirmation message
echo "Template copied to: $dest_file"
