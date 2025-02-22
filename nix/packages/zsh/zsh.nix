{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    
    shellAliases = {
      ls = "eza -T -L=1 -a -B -h -l -g --icons";
      lsl = "eza -T -L=2 -a -B -h -l -g --icons";
      lss = "eza -T -L=1 -B -h -l -g --icons";
      cat = "bat";
      history = "history 0";
      host-update = "sudo nixos-rebuild switch";
      home-update = "home-manager switch";
      
      # PIA VPN connection aliases with common parameters
      pia-base = "cd ~/Pia && sudo PIA_USER=$(cat /run/user/1000/secrets/pia_user) PIA_PASS=$(cat /run/user/1000/secrets/pia_pass) DISABLE_IPV6=yes PIA_PF=false PIA_DNS=true VPN_PROTOCOL=wireguard";
      pia-ldn = "pia-base PREFERRED_REGION=uk ./get_region.sh";
      pia-sth = "pia-base PREFERRED_REGION=uk_southampton ./get_region.sh";
      pia-man = "pia-base PREFERRED_REGION=uk_manchester ./get_region.sh";

        # Work Aliases: 
        work-base = "ssh -i ~/.ssh/bvawslondon";
        reg-base = "work-base -L8000:127.0.0.8000";

        # Scoop
        scoop = "work-base $(cat /run/user/1000/secrets/scoop)";
        scoopreg = "reg-base $(cat /run/user/1000/secrets/scoop)";
        # Gobo
        gobo = "work-base $(cat /run/user/1000/secrets/gobo)";
        goboreg = "reg-base $(cat /run/user/1000/secrets/gobo)";
        # Wing
        wing = "work-base $(cat /run/user/1000/secrets/wing)";
        wingreg = "reg-base $(cat /run/user/1000/secrets/wing)";
        # Mirk
        mirk = "work-base $(cat /run/user/1000/secrets/mirk)";
        mirkreg = "reg-base $(cat /run/user/1000/secrets/mirk)";
        # Sand
        sand = "work-base $(cat /run/user/1000/secrets/sand)";
        sandreg = "reg-base $(cat /run/user/1000/secrets/sand)";
        # Boop
        boop = "work-base $(cat /run/user/1000/secrets/boop)";
        boopreg = "reg-base $(cat /run/user/1000/secrets/boop)";
        # Sally
        sally = "work-base $(cat /run/user/1000/secrets/sally)";
        sallyreg = "reg-base $(cat /run/user/1000/secrets/sally)";
        
        # Realms
        realms = "curl 127.0.0.1:8000/reg/realms? | jq";
        realmsr = "~/.config/scripts/realms.sh";
        realmsu = "curl '127.0.0.1:8000/reg/realms?u=9023' | jq";

        # Capture Scripts
        warm = "~/.config/work/HelpDesk/captureScripts/captureWarmTimer.sh";
        hot = "~/.config/work/HelpDesk/captureScripts/captureHotTimer.sh";

      # URL Encoding/Decoding Aliases
      urldecode = ''python3 -c "
import sys, urllib.parse as ul
if len(sys.argv) > 1 and sys.argv[1] != \"-\":
    print(ul.unquote_plus(sys.argv[1]))
else:
    print(ul.unquote_plus(sys.stdin.read().strip()))
"'';

      urlencode = ''python3 -c "
import sys, urllib.parse as ul
if len(sys.argv) > 1 and sys.argv[1] != \"-\":
    print(ul.quote_plus(sys.argv[1]))
else:
    print(ul.quote_plus(sys.stdin.read().strip()))
"'';

      # GPG and Security Aliases
      rkey = ''gpg-connect-agent "scd serialno" "learn --force" /bye'';

      # VM Management Aliases
      kvms = "virsh --connect qemu:///system start Kali";
      kvmssh = "ssh kali@$kali";
      kvmsshd = "ssh -D 1080 kali@$kali";
      kvmsshc = "kvms && sleep 30 && kvmsshd";
      kvmrc = ''xfreerdp3 /v:192.168.122.66 /u:kali /size:100% /dynamic-resolution /gfx:progressive /d: /network:lan -z'';
      kvmsrc = "kvms && sleep 40 && kvmrc";

      # Windows VM Aliases
      wvmsc = ''virsh --connect qemu:///system start Windows11 && sleep 40 && xfreerdp3 /v:192.168.122.182 /u:martin /size:100% /dynamic-resolution /gfx:progressive /d:'';
      wvmc = ''xfreerdp3 /v:192.168.122.182 /u:martin /size:100% /dynamic-resolution /gfx:progressive /d:'';
      wwu = ''wakeonlan -i 192.168.2.255 "2C:F0:5D:7A:71:0B"'';
      w11c = ''xfreerdp3 /v:192.168.2.115 /u:martin /size:100% /dynamic-resolution /gfx:progressive /d:'';

      # Work and Project Aliases
      cpts = "~/Dropbox/40-49_Career/41-Courses/41.22-CPTS";
      blog = "~/Dropbox/40-49_Career/44-Blog/bloodstiller";
      bx = "~/Dropbox/40-49_Career/46-Boxes/46.02-HTB";
      sw = "/home/martin/.config/scripts/start_work.sh 2>/dev/null";
      npt = "/home/martin/.config/scripts/newpentest.sh";
      nbx = "/home/martin/.config/scripts/newbox.sh";
      wbr = "/home/martin/.config/scripts/waybarRestart.sh";
    };

    initExtra = ''
      # History Configuration
      HISTFILE=/home/$USER/.zsh_history
      HISTSIZE=200000
      SAVEHIST=200000
      setopt hist_expire_dups_first
      setopt hist_ignore_dups
      setopt hist_ignore_space
      setopt hist_verify

      # VM Management Variables
      kali='192.168.56.174'

      # GPG and Security Functions
      function secret () {
        output=~/"$1".$(date +%s).enc
        gpg --encrypt --armor --output $output -r 0x79ea004594bd7e09 -r admin@mdbdev.io "$1" && echo "$1 -> $output"
      }

      function reveal () {
        output=$(echo "$1" | rev | cut -c16- | rev)
        gpg --decrypt --output $output "$1" && echo "$1 -> $output"
      }

      eval "$(atuin init zsh)"

      export WORK_EMAIL=$(cat ${config.sops.secrets.work_email.path})
    '';

    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.0";
          sha256 = "KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
        };
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.7.1";
          sha256 = "gOG0NLlaJfotJfs+SUhGgLTNOnGLjoqnUp54V9aFJg8=";
        };
      }
      {
        name = "fast-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zdharma-continuum";
          repo = "fast-syntax-highlighting";
          rev = "master";
          sha256 = "sha256-RVX9ZSzjBW3LpFs2W86lKI6vtcvDWP6EPxzeTcRZua4=";
        };
      }
      {
        name = "zsh-autocomplete";
        src = pkgs.fetchFromGitHub {
          owner = "marlonrichert";
          repo = "zsh-autocomplete";
          rev = "main";
          sha256 = "sha256-o8IQszQ4/PLX1FlUvJpowR2Tev59N8lI20VymZ+Hp4w=";
        };
      }
    ];

    oh-my-zsh = {
      enable = true;
      plugins = [ 
        "git" 
        "history" 
        "tmux" 
        "docker-compose"
      ];
      theme = "robbyrussell";
    };
  };
} 