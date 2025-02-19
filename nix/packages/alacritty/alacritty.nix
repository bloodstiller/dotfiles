{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;

    # Main configuration
    settings = {
      scrolling.history = 100000;

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

      colors.draw_bold_text_with_bright_colors = true;
    };
  };
}
