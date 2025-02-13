#!/usr/bin/env sh

#!/bin/bash

function loop {

    for dir in */; do # */ to matach only directories
        if [ -d "$dir" ]; then # check if directory has further directoies
            (cd "$dir" && ~/Emacs/conver.sh && loop); # replace pwd with the command to be executed in the directory
        fi
    done
}

loop
