{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    
    # Add the plugins you're using
    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator
      yank
      logging
      {
        plugin = dracula;
        extraConfig = ''
          set -g @dracula-show-flags true
          set -g @dracula-show-left-icon session
          set -g @dracula-show-powerline true
        '';
      }
    ];

    # Your tmux configuration
    extraConfig = ''
      # Send prefix
      set-option -g prefix C-Space
      unbind-key C-b
      bind-key C-Space send-prefix

      # Set easier window split keys
      bind -n M-q split-window -v
      bind -n M-w split-window -h

      # Close pane
      bind -n C-x kill-pane

      # Use CTRL-arrow keys to switch panes
      bind -n C-h select-pane -L
      bind -n C-l select-pane -R
      bind -n C-k select-pane -U
      bind -n C-j select-pane -D

      # Resize Panes Easily
      bind -n M-h resize-pane -L 2
      bind -n M-l resize-pane -R 2
      bind -n M-k resize-pane -U 2
      bind -n M-j resize-pane -D 2

      # Shift arrow to switch windows
      bind -n S-Left previous-window
      bind -n S-Right next-window

      set-option -sa terminal-overrides ",xterm*:Tc"

      # Windows
      bind -n C-n new-window
      bind -n C-p next-window
      bind -n C-o previous-window

      # Rename Pane
      bind-key r command-prompt -I "#S" "rename-session '%%'"

      # Mouse mode
      setw -g mouse on

      # Vi mode
      setw -g mode-keys vi

      # Status bar position
      set -g status-position top

      # Performance tweaks
      set -s escape-time 0
      set -g history-limit 50000
      set -g display-time 4000
      set -g status-interval 5
      set -g default-terminal "screen-256color"
      set -g focus-events on
      setw -g aggressive-resize on

      # Logging path
      set -g @logging-path "~/Desktop"
    '';
  };

  # TPM Installation (if you still want to manage it this way)
  home.file.".tmux/plugins/tpm".source = pkgs.fetchFromGitHub {
    owner = "tmux-plugins";
    repo = "tpm";
    rev = "99469c4a9b1ccf77fade25842dc7bafbc8ce9946";
    sha256 = "hW8mfwB8F9ZkTQ72WQp/1fy8KL1IIYMZBtZYIwZdMQc=";
  };
}
