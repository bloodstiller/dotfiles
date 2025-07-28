# Main NeoVim configuration file
{ lib, pkgs, ... }: {
  imports = [
    ./languages.nix
    ./plugins.nix
    ./keymaps.nix
    ./formatter.nix
    ./notes.nix
    ./theme.nix
    ./lua-markdown-config.nix
    ./lua-markdown-theme.nix
    ./lua-keymaps.nix
    ./lua-plugin-configs.nix
    ./lua-theme-config.nix

  ];

  vim = {
    statusline.lualine.enable = true;
    telescope.enable = true;
    autocomplete.nvim-cmp.enable = true;
    lsp.enable = true;

    options = {
      # Have set conceal in markdown theme file
      # conceallevel = 1; # or 1
    };

    binds = { whichKey.enable = true; };

    filetree.neo-tree.enable = true;
    # Sensible default options
    filetree.neo-tree.setupOpts = {
      enable_git_status = true;
      enable_diagnostics = true;
      enable_modified_markers = true;
      enable_opened_markers = true;
      enable_refresh_on_write = true;
      git_status_async = true;
      filesystem = {
        hijack_netrw_behavior = "open_default";
        filtered_items = {
          visible = true; # Show hidden files (dotfiles)
          hide_dotfiles = false; # Explicitly do not hide dotfiles
          hide_gitignored = false; # Show gitignored files
          never_show = { }; # Add specific filenames/folders to never show here
        };
      };
      default_source = "filesystem";
      open_files_in_last_window = true;
    };

    # We can install lua packages here
    luaPackages = [ "magick" ];

    # We can install real packages here, this is needed for image display
    extraPackages = with pkgs; [ imagemagick nodePackages.prettier ];

  };
}

