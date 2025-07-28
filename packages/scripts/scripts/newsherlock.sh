#!/usr/bin/env sh

read -p "Enter sherlock name: " sherlock_name
# Define the base directory, default if not provided
#

src="$HOME/Dropbox/40-49_Career/44-Blog/bloodstiller/content-org/Templates/SherlockTemplate/"
dest="$HOME/Dropbox/40-49_Career/44-Blog/bloodstiller/content-org/Walkthroughs/HTB/Sherlocks/"
base_dir=$sherlock_name

# Create directories using a nested structure
mkdir -p "$dest/$base_dir"

# Check if the folder structure already exists before copying
cp $HOME/Dropbox/40-49_Career/44-Blog/bloodstiller/content-org/Templates/SherlockTemplate/SherlockTemplate.org "$dest/$base_dir/$sherlock_name-sherlock.org"

cd $dest/$base_dir/
ln -s ~/Dropbox/screenshots .

# Confirmation message
echo "Sherlock $sherlock_name created in $dest$base_dir"
