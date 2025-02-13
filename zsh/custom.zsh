
# History Configuration
HISTFILE=/home/$USER/.zsh_history
HISTSIZE=200000
SAVEHIST=200000
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it

# URL Encoding/Decoding Aliases
alias urldecode='python3 -c "
import sys, urllib.parse as ul
if len(sys.argv) > 1 and sys.argv[1] != \"-\":
    print(ul.unquote_plus(sys.argv[1]))
else:
    print(ul.unquote_plus(sys.stdin.read().strip()))
"'

alias urlencode='python3 -c "
import sys, urllib.parse as ul
if len(sys.argv) > 1 and sys.argv[1] != \"-\":
    print(ul.quote_plus(sys.argv[1]))
else:
    print(ul.quote_plus(sys.stdin.read().strip()))
"'

# GPG and Security Functions
alias rkey='gpg-connect-agent "scd serialno" "learn --force" /bye'

function secret () {
    output=~/"${1}".$(date +%s).enc
    gpg --encrypt --armor --output ${output} -r 0x79ea004594bd7e09 -r admin@mdbdev.io "${1}" && echo "${1} -> ${output}"
}

function reveal () {
    output=$(echo "${1}" | rev | cut -c16- | rev)
    gpg --decrypt --output ${output} "${1}" && echo "${1} -> ${output}"
}

# VM Management Aliases
kali='192.168.56.174'
alias kvms='virsh --connect qemu:///system start Kali'
alias kvmssh='ssh kali@$kali'
alias kvmsshd='ssh -D 1080 kali@$kali'
alias kvmsshc='kvms && sleep 30 && kvmsshd'
alias kvmrc='xfreerdp3 /v:192.168.122.66 /u:kali /size:100% /dynamic-resolution /gfx:progressive /d: /network:lan -z'
alias kvmsrc='kvms && sleep 40 && kvmrc'

# Windows VM Aliases
alias wvmsc='virsh --connect qemu:///system start Windows11 && sleep 40 && xfreerdp3 /v:192.168.122.182 /u:martin /size:100% /dynamic-resolution /gfx:progressive /d:'
alias wvmc='xfreerdp3 /v:192.168.122.182 /u:martin /size:100% /dynamic-resolution /gfx:progressive /d:'
alias wwu='wakeonlan -i 192.168.2.255 "2C:F0:5D:7A:71:0B"'
alias w11c='xfreerdp3 /v:192.168.2.115 /u:martin /size:100% /dynamic-resolution /gfx:progressive /d:'

# Work and Project Aliases
alias cpts='~/Dropbox/40-49_Career/41-Courses/41.22-CPTS'
alias blog='~/Dropbox/40-49_Career/44-Blog/bloodstiller'
alias bx='~/Dropbox/40-49_Career/46-Boxes/46.02-HTB'
alias sw='/home/martin/.config/scripts/start_work.sh 2>/dev/null'
alias npt="/home/martin/.config/scripts/newpentest.sh"
alias nbx="/home/martin/.config/scripts/newbox.sh"
alias wbr="/home/martin/.config/scripts/waybarRestart.sh"

# SSH Aliases for Work Servers
# Scoop
alias scoopreg='ssh -i ~/.ssh/bvawslondon -L8000:127.0.0.1:8000 ec2-user@13.42.100.70'
alias scoop='ssh -i ~/.ssh/bvawslondon ec2-user@13.42.100.70'
alias scooprtp='ssh -i ~/.ssh/bvawslondon ec2-user@13.42.100.71'

# Gobo
alias goboreg='ssh -i ~/.ssh/bvawslondon -L8000:127.0.0.1:8000 ec2-user@13.42.100.68'
alias gobo='ssh -i ~/.ssh/bvawslondon ec2-user@13.42.100.68'
alias gobortp='ssh -i ~/.ssh/bvawslondon ec2-user@13.42.100.69'

# Wing
alias wingreg='ssh -i ~/.ssh/bvawslondon -L8000:127.0.0.1:8000 ec2-user@wingnut.babblevoice.com'
alias wing='ssh -i ~/.ssh/bvawslondon ec2-user@wingnut.babblevoice.com'
alias wingrtp='ssh -i ~/.ssh/bvawslondon ec2-user@13.42.100.71'

# Other Server Aliases
alias mirkreg='ssh -i ~/.ssh/bvawslondon -L8000:127.0.0.1:8000 ec2-user@mirkmonster.babblevoice.com'
alias mirk='ssh -i ~/.ssh/bvawslondon ec2-user@mirkmonster.babblevoice.com'
alias sandreg='ssh -i ~/.ssh/bvawslondon -L8000:127.0.0.1:8000 ec2-user@sandman.babblevoice.com'
alias sand='ssh -i ~/.ssh/bvawslondon ec2-user@sandman.babblevoice.com'
alias boopreg='ssh -i ~/.ssh/bvawslondon -L8000:127.0.0.1:8000 ec2-user@booper.babblevoice.com'
alias boop='ssh -i ~/.ssh/bvawslondon ec2-user@booper.babblevoice.com'

# Realms Check Aliases
alias realms='curl 127.0.0.1:8000/reg/realms? | jq'
alias realmsr='~/.config/scripts/realms.sh'
alias realmsu='curl "127.0.0.1:8000/reg/realms?u=9023" | jq'

# Git Alias
alias bvgit='ssh -i ~/.ssh/bv_ed25519 -o IdentitiesOnly=yes'

# Capture Scripts
alias warm='~/.config/work/HelpDesk/captureScripts/captureWarmTimer.sh'
alias hot='~/.config/work/HelpDesk/captureScripts/captureHotTimer.sh'

