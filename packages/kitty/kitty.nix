{ config, pkgs, ... }: {
  programs.kitty = {
    enable = true;

    # Use the proper Home Manager theme option
    themeFile = "Doom_One";

    # Font configuration using the dedicated font option
    font = {
      name = "nerd-fonts.commit-mono";
      size = 16;
    };

    # Main configuration
    settings = {
      # Scrollback
      scrollback_lines = 100000;

      # Window settings
      window_padding_width = 12;
      dynamic_background_opacity = false;
      background_opacity = "1.0";

      # Font adjustments (the family is handled by the font option above)
      bold_font = "source-code-pro Bold";
      italic_font = "source-code-pro Italic";
      bold_italic_font = "source-code-pro Bold Italic";
      adjust_line_height = 6;
      adjust_column_width = 1;

      # Terminal identification
      term = "xterm-256color";

      # Window title
      window_title = "Kitty";

      # Tab bar
      tab_bar_edge = "top";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";

      # Audio/visual settings
      enable_audio_bell = false;
      visual_bell_duration = "0.0";
      window_alert_on_bell = true;
      bell_on_tab = true;
      command_on_bell = "none";

      # Copy/paste
      copy_on_select = true;
      strip_trailing_spaces = "never";

      # Mouse
      mouse_hide_wait = "3.0";
      url_color = "#51afef";
      url_style = "curly";
      open_url_modifiers = "kitty_mod";
      open_url_with = "default";

      # Performance
      repaint_delay = 10;
      sync_to_monitor = true;

      # Set kitty_mod to match tmux prefix
      kitty_mod = "ctrl+shift";
    };

    # Key bindings (fixed conflicts)
    keybindings = {
      # Copy/paste
      "kitty_mod+c" = "copy_to_clipboard";
      "kitty_mod+v" = "paste_from_clipboard";
      "kitty_mod+s" = "paste_from_selection";
      "shift+insert" = "paste_from_selection";

      # Window management
      "kitty_mod+enter" = "new_window";
      "kitty_mod+x" = "close_window";
      "kitty_mod+;" = "next_window";
      "kitty_mod+l" = "previous_window";
      "kitty_mod+f" = "move_window_forward";
      "kitty_mod+b" = "move_window_backward";
      "kitty_mod+u" = "move_window_to_top";
      "kitty_mod+r" = "start_resizing_window";
      "kitty_mod+1" = "first_window";
      "kitty_mod+2" = "second_window";
      "kitty_mod+3" = "third_window";
      "kitty_mod+4" = "fourth_window";
      "kitty_mod+5" = "fifth_window";
      "kitty_mod+6" = "sixth_window";
      "kitty_mod+7" = "seventh_window";
      "kitty_mod+8" = "eighth_window";
      "kitty_mod+9" = "ninth_window";

      # Tab management (fixed conflict)
      "kitty_mod+p" = "next_tab";
      "kitty_mod+o" = "previous_tab";
      "kitty_mod+t" = "new_tab";
      "kitty_mod+q" = "close_tab";
      "kitty_mod+." = "move_tab_forward";
      "kitty_mod+," = "move_tab_backward";
      "kitty_mod+alt+t" = "set_tab_title";

      # Font size
      "kitty_mod+plus" = "change_font_size all +2.0";
      "kitty_mod+minus" = "change_font_size all -2.0";
      "kitty_mod+backspace" = "change_font_size all 0";

      # Scrolling (using different key for scrollback to avoid conflict)
      "kitty_mod+up" = "scroll_line_up";
      "kitty_mod+k" = "scroll_line_up";
      "kitty_mod+down" = "scroll_line_down";
      "kitty_mod+j" = "scroll_line_down";
      "kitty_mod+page_up" = "scroll_page_up";
      "kitty_mod+page_down" = "scroll_page_down";
      "kitty_mod+home" = "scroll_home";
      "kitty_mod+end" = "scroll_end";
      "kitty_mod+shift+h" = "show_scrollback"; # Changed to avoid conflict
    };
  };
}
