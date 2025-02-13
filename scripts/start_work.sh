#!/usr/bin/env bash

# Vars
chrome=/usr/bin/google-chrome-stable

# Retrieve the version number using `curl`
bvVersion=$(curl -s https://www.babblevoice.com/a/current)

# Define URLs as an array
declare -a urls=(
    "https://omniis.zendesk.com/agent/dashboard"
    "https://notion.so"
    "https://app.todoist.com/app/inbox"
    "https://www.babblevoice.com/a/${bvVersion}/#/"
    "https://www.babblevoice.com/a/${bvVersion}/admin/#/"
    "https://www.babblevoice.com/p4a/applications/babble/?newsession=1"
    "https://drive.google.com/drive/my-drive"
    "https://docs.google.com/spreadsheets/d/1I3E14TsD69NZmuKexGW1iN44xL-MYOt1ct3MLHKRCXk/edit#gid=0"
    "https://calendar.google.com/calendar/u/0/r?tab=rc"
    "https://docs.google.com/spreadsheets/d/1ZQJw6ZH7aTLUpazo7gj7aWyOjzp36an05SVPD0QRz1M/edit#gid=282679378"
    "http://13.42.100.67:3000/d/adyr4bamhlt6oa/rtp-stats?orgId=1&from=now-12h&to=now"
)

# Define functions
launch_chrome() {
    local urls=$@
    /usr/bin/google-chrome-stable --new-window ${urls[@]/#/--new-tab } &
}

open_emails() {
    /usr/bin/google-chrome-stable --new-window "https://mail.google.com/mail/u/0/#inbox" &
}

open_desktop() {
    /usr/bin/google-chrome-stable --new-window "https://www.babblevoice.com/a/$bvVersion/desktop/#" &
}

#open_tasks() {
#   /usr/bin/google-chrome-stable --new-window "https://fullscreen-for-googletasks.com/" &
#}

launch_slack() {
    /usr/bin/slack &
}

launch_todoist() {
    ~/Applications/Todoist-linux-8.12.2-x86_64_89afa4388cbce63f0a563938b4714e22.AppImage &
}

# Launch Google Chrome with all required browser-based apps
launch_chrome "${urls[@]}"

# Open emails for alerts
open_emails

# Open desktop for calls
open_desktop

# Launch Slack
launch_slack
