{ lib, pkgs, ... }: {
  vim = {
    theme = {
      enable = true;
      name = "catppuccin";
      style = "mocha";
    };

    statusline.lualine.enable = true;
    telescope.enable = true;
    autocomplete.nvim-cmp.enable = true;
    lsp.enable = true;

    filetree.neo-tree.enable = true;
    # Sensible default options
    filetree.neo-tree.setupOpts = {
      enable_git_status = true;
      enable_diagnostics = true;
      enable_modified_markers = true;
      enable_opened_markers = true;
      enable_refresh_on_write = true;
      git_status_async = true;
      filesystem = { hijack_netrw_behavior = "open_default"; };
      default_source = "filesystem";
      open_files_in_last_window = true;
    };

    # Keymap to toggle NeoTree with <leader>t

    binds = { whichKey.enable = true; };

    keymaps = [
      # Keymap to toggle NeoTree with <leader>t
      {
        key = "<leader>t";
        mode = "n";
        action = "<cmd>Neotree toggle<CR>";
      }
      {
        key = "<leader>ff";
        mode = "n";
        silent = true;
        action = ":Telescope find_files<CR>";
      }
      {
        key = "<leader>fg";
        mode = "n";
        silent = true;
        action = ":Telescope live_grep<CR>";
      }
      {
        key = "<leader>or";
        mode = "n";
        silent = true;
        action = ":lua require('org-roam.ui').toggle()<CR>";
      }
      {
        key = "<C-s>";
        mode = "i";
        action = "<Esc>:w<CR>";
      }
      { # Vertical split: <leader>ws
        key = "<leader>ws";
        mode = "n";
        action = ":vsplit<CR>";
      }

      { # Horizontal split: <leader>ws
        key = "<leader>wh";
        mode = "n";
        action = ":split<CR>";
      }
      { # Close window
        key = "<leader>wx";
        mode = "n";
        action = ":close<CR>";
      }
      { # New empty window
        key = "<leader>wn";
        mode = "n";
        action = ":new<CR>";
      }

    ];

    languages = {
      nix.enable = true;
      ts.enable = true;
      python.enable = true;
      enableTreesitter = true;

      markdown = {
        enable = true;
        extensions = { markview-nvim.enable = true; };
      };
    };
  };

  vim.lazy.plugins."orgmode" = {
    package = pkgs.vimPlugins.orgmode;
    setupModule = "orgmode";
    setupOpts = {
      org_agenda_files = [ "~/orgfiles/**/*" ];
      org_default_notes_file = "~/orgfiles/refile.org";
    };
    event = [{
      event = "User";
      pattern = "LazyFile";
    }];
  };

  vim.lazy.plugins."org-roam.nvim" = {
    package = pkgs.vimPlugins.org-roam-nvim;
    setupModule = "org-roam";
    setupOpts = { directory = "~/orgfiles/roam"; };

    event = [{
      event = "User";
      pattern = "LazyFile";
    }];
  };

  vim.lazy.plugins."twilight.nvim" = {
    package = pkgs.vimPlugins.twilight-nvim;
    setupModule = "twilight";
    event = [{
      event = "User";
      pattern = "LazyFile";
    }];
  };

  # Devicons so things look nice
  vim.lazy.plugins."nvim-web-devicons" = {
    package = pkgs.vimPlugins.nvim-web-devicons;
    event = [{
      event = "VimEnter";
      pattern = "*";
    }];
  };

  # Devicons so things look nice
  vim.lazy.plugins."mini.nvim" = {
    package = pkgs.vimPlugins.mini-nvim;
    event = [{
      event = "VimEnter";
      pattern = "*";
    }];
  };

  vim.startPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "org-modern-menu";
      src = ./neovim-plugins/org-modern-menu;
    })
    (pkgs.vimUtils.buildVimPlugin {
      name = "org-bullets";
      src = ./plugins/org-bullets;
    })
    (pkgs.vimUtils.buildVimPlugin {
      name = "headlines";
      src = ./plugins/headlines;
    })
  ];

  vim.luaConfigRC.extraPlugins = ''
    require("orgmode").setup({})

    require("org-bullets").setup()

    require("headlines").setup()

    local Menu = require("org-modern.menu")
    require("orgmode").setup({
      ui = {
        menu = {
          handler = function(data)
            Menu:new():open(data)
          end,
        },
      },
    })
  '';
}
