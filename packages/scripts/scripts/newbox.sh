#!/usr/bin/env sh

read -p "Enter boxname value: " box_name
# Define the base directory, default if not provided
#

src="$HOME/Notes/Templates/BoxTemplate/"
dest="$HOME/Dropbox/40-49_Career/44-Blog/content-org/Walkthroughs/Boxes/BlogEntriesMade/"
box_dir="$HOME/Dropbox/40-49_Career/44-Blog/content-org/Walkthroughs/Boxes/BlogEntriesMade/$box_name"
# Create directories using a nested structure
mkdir -p "$box_dir"

cp -r $src/BoxTemplate.org "$box_dir/$box_name-box.org"
cp $src/Hashes.txt "$box_dir"
cp $src/Passwords.txt "$box_dir"
cp $src/Users.txt "$box_dir"

cd $box_dir
ln -s ~/Notes/screenshots .
mkdir -p loot/ticket scans/nmap scans/bloodhound scans/ldap payloads

# Confirmation message
echo "Folder structure, files, created in $box_dir."
