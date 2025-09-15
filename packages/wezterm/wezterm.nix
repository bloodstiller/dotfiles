{ config, pkgs, ... }: {
  programs.wezterm = {
    enable = true;

    # Embed the entire Lua configuration
    extraConfig = ''
      local wezterm = require("wezterm")

      -- Configuration reload every 10 minutes
      wezterm.time.call_after(600, function()
          wezterm.reload_configuration()
      end)

      -- Font configuration with proper fallback chain
      local function font_with_fallback(name, params)
          local names = { 
              name, 
              "mini-file-icons",
              "Symbols Nerd Font Mono",
              "Hack Nerd Font",
              "JetBrains Mono"
          }
          return wezterm.font_with_fallback(names, params)
      end

      -- Theme selector (currently set to DoomOne, but easily customizable)
      local function get_theme()
          local hour = os.date("*t").hour
          
          -- You can customize themes based on time of day
          -- Example: return different themes for morning/day/evening/night
          if hour >= 6 and hour < 18 then
              return "DoomOne"  -- Day theme
          else
              return "DoomOne"  -- Night theme (change to a dark theme if desired)
          end
      end

      return {
          -- Font Configuration
          font = font_with_fallback("CommitMono Nerd Font", {
              weight = "Regular",
              stretch = "Normal",
              style = "Normal",
          }),
          font_size = 16.0,
          line_height = 1.6,
          cell_width = 0.9,
          
          -- Font rules for different text styles
          font_rules = {
              {
                  intensity = "Bold",
                  font = font_with_fallback("CommitMono Nerd Font", {
                      weight = "Bold",
                  }),
              },
              {
                  intensity = "Half",
                  font = font_with_fallback("CommitMono Nerd Font", {
                      weight = "DemiBold",
                  }),
              },
              {
                  italic = true,
                  font = font_with_fallback("CommitMono Nerd Font", {
                      style = "Italic",
                  }),
              },
              {
                  italic = true,
                  intensity = "Bold",
                  font = font_with_fallback("CommitMono Nerd Font", {
                      weight = "Bold",
                      style = "Italic",
                  }),
              },
          },
          
          -- Window Configuration
          initial_cols = 140,
          initial_rows = 38,
          window_decorations = "NONE",  -- Removes the title bar completely
          window_background_opacity = 1.0,
          
          -- Padding for maximum readability
          -- These values provide comfortable spacing without wasting screen space
          window_padding = {
              left = "1.5cell",
              right = "1.5cell",
              top = "0.5cell",
              bottom = "0.5cell",
          },
          
          -- Tab Bar Configuration
          hide_tab_bar_if_only_one_tab = true,
          use_fancy_tab_bar = true,
          tab_bar_at_bottom = true,
          show_tab_index_in_tab_bar = false,
          tab_max_width = 32,
          
          -- Color Scheme
          color_scheme = get_theme(),
          bold_brightens_ansi_colors = false,
          
          -- Cursor Configuration
          default_cursor_style = "BlinkingBar",
          cursor_blink_rate = 600,
          cursor_blink_ease_in = "Constant",
          cursor_blink_ease_out = "Constant",
          
          -- Scrollback
          scrollback_lines = 50000,
          enable_scroll_bar = false,
          
          -- Text Selection
          selection_word_boundary = " \t\n{}[]()\"'`,;:@│",
          
          -- Performance
          front_end = "OpenGL",
          enable_wayland = true,
          max_fps = 120,
          
          -- Misc Configuration
          use_dead_keys = false,
          bidi_enabled = true,
          bidi_direction = "LeftToRight",
          warn_about_missing_glyphs = false,
          
          -- Better rendering for Commit Mono
          freetype_load_target = "Normal",
          freetype_render_target = "Normal",
          freetype_load_flags = "NO_HINTING",
          
          -- Mouse Configuration
          mouse_bindings = {
              {
                  event = { Up = { streak = 1, button = "Left" } },
                  mods = "NONE",
                  action = wezterm.action.CompleteSelection("ClipboardAndPrimarySelection"),
              },
              {
                  event = { Up = { streak = 1, button = "Right" } },
                  mods = "NONE",
                  action = wezterm.action.CopyTo("ClipboardAndPrimarySelection"),
              },
          },
          
          -- Key Bindings
          keys = {
              -- Font size adjustments
              { key = "=", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
              { key = "-", mods = "CTRL", action = wezterm.action.DecreaseFontSize },
              { key = "0", mods = "CTRL", action = wezterm.action.ResetFontSize },
              
              -- Copy/Paste
              { key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("Clipboard") },
              { key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },
              
              -- Tab navigation
              { key = "Tab", mods = "CTRL", action = wezterm.action.ActivateTabRelative(1) },
              { key = "Tab", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },
              
              -- New tab
              { key = "t", mods = "CTRL|SHIFT", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
              
              -- Close tab
              { key = "w", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentTab({ confirm = true }) },
              
              -- Scrollback
              { key = "PageUp", mods = "SHIFT", action = wezterm.action.ScrollByPage(-1) },
              { key = "PageDown", mods = "SHIFT", action = wezterm.action.ScrollByPage(1) },
              
              -- Window management (useful since we removed the title bar)
              { key = "q", mods = "CTRL|SHIFT|ALT", action = wezterm.action.QuitApplication },
              { key = "n", mods = "CTRL|SHIFT", action = wezterm.action.SpawnWindow },
          },
      }
    '';
  };

  # Optional: Ensure the Commit Mono Nerd Font is installed
  # You might need to add this to your fonts configuration
  # fonts.fontconfig.enable = true;
  # home.packages = with pkgs; [
  #   (nerdfonts.override { fonts = [ "CommitMono" "Hack" "JetBrainsMono" ]; })
  # ];
}
