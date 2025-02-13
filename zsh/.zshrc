#source $ZSH/oh-my-zsh.sh

setopt autocd              # change directory just by typing its name
setopt correct            # auto correct mistakes
setopt interactivecomments # allow comments in interactive mode
setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch           # hide error message if there is no match for the pattern
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt

WORDCHARS=${WORDCHARS//\/}

PROMPT_EOL_MARK=""

bindkey -e                                        # emacs key bindings
bindkey ' ' magic-space                           # do history expansion on space
bindkey '^U' backward-kill-line                   # ctrl + U
bindkey '^[[3;5~' kill-word                       # ctrl + Supr
bindkey '^[[3~' delete-char                       # delete
bindkey '^[[1;5C' forward-word                    # ctrl + ->
bindkey '^[[1;5D' backward-word                   # ctrl + <-
bindkey '^[[5~' beginning-of-buffer-or-history    # page up
bindkey '^[[6~' end-of-buffer-or-history          # page down
bindkey '^[[H' beginning-of-line                  # home
bindkey '^[[F' end-of-line                        # end
bindkey '^[[Z' undo                               # shift + tab undo last action

autoload -Uz compinit
compinit -d ~/.cache/zcompdump
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

HISTFILE=/home/$USER/.zsh_history

HISTSIZE=200000
SAVEHIST=200000

setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
#setopt share_history         # share command history data

# force zsh to show the complete history
alias history="history 0"

TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'

case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi
toggle_oneline_prompt(){
    if [ "$PROMPT_ALTERNATIVE" = oneline ]; then
        PROMPT_ALTERNATIVE=twoline
    else
        PROMPT_ALTERNATIVE=oneline
    fi
    configure_prompt
    zle reset-prompt
}
zle -N toggle_oneline_prompt
bindkey ^P toggle_oneline_prompt


precmd() {
    # Print the previously configured title
    print -Pnr -- "$TERM_TITLE"

    # Print a new line before the prompt, but only if it is not the first line
    if [ "$NEWLINE_BEFORE_PROMPT" = yes ]; then
        if [ -z "$_NEW_LINE_BEFORE_PROMPT" ]; then
            _NEW_LINE_BEFORE_PROMPT=1
        else
            print ""
        fi
    fi
}

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    export LS_COLORS="$LS_COLORS:ow=30;44:" # fix ls color for folders with 777 permissions

    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'

    export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
    export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
    export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
    export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
    export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
    export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
    export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

    # Take advantage of $LS_COLORS for completion as well
    zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
    zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
fi

if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    . /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    # change suggestion color
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
fi

# enable command-not-found if installed
if [ -f /etc/zsh_command_not_found ]; then
    . /etc/zsh_command_not_found
fi

alias ls='eza -T -L=1 -a -B -h -l -g --icons'
alias lsl='eza -T -L=2 -a -B -h -l -g --icons'
alias lss='eza -T -L=1 -B -h -l -g --icons'

alias cat='bat'


alias autorecon='sudo env "PATH=$PATH" autorecon'


alias urldecode='python3 -c "
import sys, urllib.parse as ul
if len(sys.argv) > 1 and sys.argv[1] != \"-\":  # Single string input
    print(ul.unquote_plus(sys.argv[1]))
else:  # Read from stdin (e.g., piped input or a file)
    print(ul.unquote_plus(sys.stdin.read().strip()))
"'

alias urlencode='python3 -c "
import sys, urllib.parse as ul
if len(sys.argv) > 1 and sys.argv[1] != \"-\":  # Single string input
    print(ul.quote_plus(sys.argv[1]))
else:  # Read from stdin (e.g., piped input or a file)
    print(ul.quote_plus(sys.stdin.read().strip()))
"'

alias tmux-save-pane='tmux capture-pane -pS -'

kali='192.168.56.174'


alias cpts='~/Dropbox/40-49_Career/41-Courses/41.22-CPTS'

alias blog='~/Dropbox/40-49_Career/44-Blog/bloodstiller'

alias bx='~/Dropbox/40-49_Career/46-Boxes/46.02-HTB'

# Kali VM Aliases
alias kvms='virsh --connect qemu:///system start Kali'

alias kvmssh='ssh kali@$kali'

alias kvmsshd='ssh -D 1080 kali@$kali'

alias kvmsshc='kvms && sleep 30 && kvmsshd'

alias kvmrc='xfreerdp3 /v:192.168.122.66 /u:kali /size:100% /dynamic-resolution /gfx:progressive /d: /network:lan -z'

alias kvmsrc='kvms && sleep 40 && kvmrc'

## Windows VM Aliases
alias wvmsc='virsh --connect qemu:///system start Windows11 && sleep 40 &&
xfreerdp3 /v:192.168.122.182 /u:martin /size:100% /dynamic-resolution /gfx:progressive /d:'

alias wvmc='xfreerdp3 /v:192.168.122.182 /u:martin /size:100% /dynamic-resolution /gfx:progressive /d:'

alias kvmls='virsh --connect qemu:///system start Kali && sleep 40 &&
xfreerdp /v:192.168.100.194 /u:kali /size:100% /dynamic-resolution /d:'

alias kvmlc='xfreerdp /v:192.168.100.194 /u:kali /size:100% /dynamic-resolution /d:'

alias wvmls='virsh --connect qemu:///system start Windows11 && sleep 40 &&
xfreerdp3 /v:192.168.100.182 /u:martin /size:100% /dynamic-resolution /gfx:progressive /d:'

alias wvmlc='xfreerdp3 /v:192.168.100.182 /u:martin /size:100% /dynamic-resolution /gfx:progressive /d:'

# Windows Host Aliases
alias wwu='wakeonlan -i 192.168.2.255 "2C:F0:5D:7A:71:0B"'

alias w11c='xfreerdp3 /v:192.168.2.115 /u:martin /size:100% /dynamic-resolution /gfx:progressive /d:'

alias sw='/home/martin/.config/scripts/start_work.sh 2>/dev/null'

#nbx () {
    #mkdir loot scans exploit creds
    #mkdir -p scans/nmap scans/bh
    #mkdir -p creds/hashes creds/usernames creds/passwords
#}

# Pentesting Scripts
alias npt="/home/martin/.config/scripts/newpentest.sh"

# Box Scrtips for THM
alias nbx="/home/martin/.config/scripts/newbox.sh"

alias wbr="/home/martin/.config/scripts/waybarRestart.sh"

alias rkey='gpg-connect-agent "scd serialno" "learn --force" /bye'

# Encrypt a file with GPG and save it with a timestamped name
function secret () {
                output=~/"${1}".$(date +%s).enc
                gpg --encrypt --armor --output ${output} -r 0x79ea004594bd7e09 -r admin@mdbdev.io "${1}" && echo "${1} -> ${output}"
}

# Decrypt a file and save it with its original name
function reveal () {
                output=$(echo "${1}" | rev | cut -c16- | rev)
                gpg --decrypt --output ${output} "${1}" && echo "${1} -> ${output}"
}

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

# Mirk
alias mirkreg='ssh -i ~/.ssh/bvawslondon -L8000:127.0.0.1:8000 ec2-user@mirkmonster.babblevoice.com'
alias mirk='ssh -i ~/.ssh/bvawslondon ec2-user@mirkmonster.babblevoice.com'

# Sand
alias sandreg='ssh -i ~/.ssh/bvawslondon -L8000:127.0.0.1:8000 ec2-user@sandman.babblevoice.com'
alias sand='ssh -i ~/.ssh/bvawslondon ec2-user@sandman.babblevoice.com'

# boope
alias boopreg='ssh -i ~/.ssh/bvawslondon -L8000:127.0.0.1:8000 ec2-user@booper.babblevoice.com'
alias boop='ssh -i ~/.ssh/bvawslondon ec2-user@booper.babblevoice.com'

# Realms check:
# Check all domains on a server
alias realms='curl 127.0.0.1:8000/reg/realms? | jq'
alias realmsr='~/.config/scripts/realms.sh'
alias realmsu='curl "127.0.0.1:8000/reg/realms?u=9023" | jq'

#Git Alias:
alias bvgit='ssh -i ~/.ssh/bv_ed25519 -o IdentitiesOnly=yes'

# Start warm captures:
alias warm='~/.config/work/HelpDesk/captureScripts/captureWarmTimer.sh'

# Start hot captures:
alias hot='~/.config/work/HelpDesk/captureScripts/captureHotTimer.sh'

# Tmux auto-start (currently commented out)
#if [[ -z "$TMUX" && -z "$SSH_CONNECTION" && -n "$DISPLAY" ]]; then
#  exec tmux new-session -A -s default \; source-file ~/.tmux.conf
#fi

alias host-update='sudo nixos-rebuild switch'
alias home-update='home-manager switch'


# Enable Nixos autocomplete
bindkey "''${key[Up]}" up-line-or-search

# Initialize Starship prompt
eval "$(starship init zsh)"


