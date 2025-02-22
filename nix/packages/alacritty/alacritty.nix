{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;

    # Main configuration
    settings = {
      scrolling.history = 100000;

      # Doom One theme colors
      colors = {
        bright = {
          black = "#5b6268";
          blue = "#3071db";
          cyan = "#46d9ff";
          green = "#4db5bd";
          magenta = "#a9a1e1";
          red = "#da8548";
          white = "#dfdfdf";
          yellow = "#ecbe7b";
        };

        cursor = {
          cursor = "#528bff";
          text = "CellBackground";
        };

        normal = {
          black = "#1c1f24";
          blue = "#51afef";
          cyan = "#5699af";
          green = "#98be65";
          magenta = "#c678dd";
          red = "#ff6c6b";
          white = "#abb2bf";
          yellow = "#da8548";
        };

        primary = {
          background = "#282c34";
          foreground = "#bbc2cf";
        };

        selection = {
          background = "#3e4451";
          text = "CellForeground";
        };

        draw_bold_text_with_bright_colors = true;
      };

      window = {
        dynamic_padding = false;
        opacity = 1;
        title = "Alacritty";
        
        class = {
          general = "Alacritty";
          instance = "Alacritty";
        };
        
        padding = {
          x = 10;
          y = 10;
        };
      };

      font = {
        size = 13.5;
        
        bold = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold";
        };
        
        bold_italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Mono Bold";
        };
        
        italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Mono Bold";
        };
        
        normal = {
          family = "JetBrainsMono Nerd Font";
        };
        
        offset = {
          x = 0;
          y = 1;
        };
      };

      env.TERM = "xterm-256color";
    };
  };
}
