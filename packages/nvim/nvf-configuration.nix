# Main NeoVim configuration file
{ lib, pkgs, ... }: {
  imports = [
    ./autocomplete.nix
    ./formatter.nix
    ./image.nix
    ./keymaps.nix
    ./languages.nix
    ./lua-markdown-config.nix
    ./lua-markdown-theme.nix
    ./lua-keymaps.nix
    ./lua-plugin-configs.nix
    ./lua-theme-config.nix
    ./notes.nix
    ./org-mode-import.nix
    ./plugins.nix
    ./theme.nix
  ];

  vim = {
    statusline.lualine.enable = true;
    telescope.enable = true;
    autocomplete.nvim-cmp.enable = true;
    lsp.enable = true;

    # For spelling to work here we need to also add it to spellang below
    spellcheck = {
      enable = true;
      languages = [ "en_us" ];
    };

    options = {
      conceallevel = 3;
      spell = true;
      spelllang = "en_us";

    };

    binds = { whichKey.enable = true; };

    filetree.neo-tree.enable = true;
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

    # We can install lua packages here if they are depedencies
    luaPackages = [ "magick" ];

    # We can install real packages here, this is needed for image display.
    extraPackages = with pkgs; [
      imagemagick
      nodePackages.prettier
      ueberzugpp
      luajitPackages.magick
    ];
  };
}

