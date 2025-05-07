#!/usr/bin/env sh

NOTE=$(wofi --dmenu -p "Capture TODO:" </dev/null)
[ -z "$NOTE" ] && exit 0 # exit if empty

emacsclient -e "
(let ((org-capture-templates
       '((\"x\" \"Quick Inbox\" entry
          (file+headline \"/home/martin/Dropbox/01-09_System/01-Emacs/01.02-OrgGtd/inbox.org\" \"inbox\")
          \"* TODO ${NOTE}\n  %U\"))))
  (org-capture nil \"x\")
  (org-capture-finalize))"

notify-send "Captured" "✅ Task added to inbox" -t 1500
