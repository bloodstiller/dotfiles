#!/usr/bin/env sh

read -p "Enter micro-blog name: " blog_name
# Define the base directory, default if not provided

src="$HOME/Dropbox/40-49_Career/44-Blog/bloodstiller/content-org/Templates/MicroblogTemplate.org"
dest="$HOME/Dropbox/40-49_Career/44-Blog/bloodstiller/content-org/Micro-blog/"

cp $src $dest/$blog_name.org

# Confirmation message
echo "Blog File $blog_name.org made in $dest"
