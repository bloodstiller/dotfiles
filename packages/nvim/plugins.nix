# Plugin configuration
{ lib, pkgs, ... }: {

  vim.assistant.avante-nvim = {
    enable = true;
    setupOpts = {
      # Set Claude as the default provider
      provider = "claude";

      # Claude is already the default for auto-suggestions, but making it explicit
      auto_suggestions_provider = "claude";

      # Configure Claude provider settings
      providers = {
        claude = {
          endpoint = "https://api.anthropic.com/v1/messages";
          model =
            "claude-3-5-sonnet-20241022"; # or claude-3-5-haiku-20241022 for faster responses
          api_key_name = "ANTHROPIC_API_KEY";
          timeout = 30000; # 30 seconds timeout
          extra_request_body = {
            max_tokens = 8192;
            temperature = 0.7;
          };
        };
      };

      # Behavior settings
      behaviour = {
        enable_token_counting = true;
        auto_suggestions = true; # Enable auto-suggestions with Claude
        auto_apply_diff_after_generation =
          false; # Set to true if you want automatic application
        minimize_diff = true;
        support_paste_from_clipboard = true;
      };

      # Window configuration
      windows = {
        position = "right";
        width = 30;
        wrap = true;
        ask = {
          floating = false;
          start_insert = true;
          border = "rounded";
        };
        edit = {
          start_insert = true;
          border = "rounded";
        };
        sidebar_header = {
          enabled = true;
          align = "center";
          rounded = true;
        };
      };

      # Suggestion timing settings
      suggestion = {
        debounce = 600; # Wait 600ms before making suggestion request
        throttle = 600; # Limit suggestion frequency
      };
    };
  };

  # Telescope file browser for emacs like counsel
  vim.lazy.plugins."telescope-file-browser.nvim" = {
    package = pkgs.vimPlugins.telescope-file-browser-nvim;
    event = [{
      event = "BufReadPre";
      pattern = "*";
    }];
  };

  # Org Mode (cant move to notes section as won't work)
  vim.lazy.plugins."orgmode" = {
    package = pkgs.vimPlugins.orgmode;
    setupModule = "orgmode";
    setupOpts = {
      org_agenda_files = [ "~/Dropbox/01-09_System/01-Emacs/**/*" ];
      org_default_notes_file =
        "~/Dropbox/01-09_System/01-Emacs/01.02-OrgGtd/inbox.org";
    };
    event = [{
      event = "User";
      pattern = "LazyFile";
    }];
  };

  # Doom one theme
  vim.lazy.plugins."doom-one.nvim" = {
    package = pkgs.vimPlugins.doom-one-nvim;
    event = [{
      event = "VimEnter";
      pattern = "*";
    }];
  };

  # Filter out the noise
  vim.lazy.plugins."twilight.nvim" = {
    package = pkgs.vimPlugins.twilight-nvim;
    setupModule = "twilight";
    event = [{
      event = "User";
      pattern = "LazyFile";
    }];
  };

  # Dashboard
  vim.lazy.plugins."alpha-nvim" = {
    package = pkgs.vimPlugins.alpha-nvim;
    event = [{
      event = "VimEnter";
      pattern = "*";
    }];
  };

  # Todo comments
  vim.lazy.plugins."todo-comments.nvim" = {
    package = pkgs.vimPlugins.todo-comments-nvim;
    event = [{
      event = "VimEnter";
      pattern = "*";
    }];
  };

  # Better visual styling  
  vim.lazy.plugins."indent-blankline.nvim" = {
    package = pkgs.vimPlugins.indent-blankline-nvim;
    event = [{
      event = "FileType";
      pattern = "markdown";
    }];
  };

  # General Dependency Used By other things, do not remove.
  vim.lazy.plugins."plenary.nvim" = { package = pkgs.vimPlugins.plenary-nvim; };

  # Harpoon
  vim.lazy.plugins."harpoon2" = {
    package = pkgs.vimPlugins.harpoon2;
    event = [{
      event = "BufReadPre";
      pattern = "*";
    }];
  };

  # Bars/Tabs
  vim.lazy.plugins."barbar.nvim" = {
    package = pkgs.vimPlugins.barbar-nvim;
    event = [{
      event = "BufReadPre";
      pattern = "*";
    }];
  };

  # Bar Bar Dep
  vim.lazy.plugins."gitsigns.nvim" = {
    package = pkgs.vimPlugins.gitsigns-nvim;
  };

  # Devicons so things look nice (bar-bar dep)
  vim.lazy.plugins."nvim-web-devicons" = {
    package = pkgs.vimPlugins.nvim-web-devicons;
    event = [{
      event = "VimEnter";
      pattern = "*";
    }];
  };

  # Devicons so things look nice (bar-bar dep)
  vim.lazy.plugins."mini.nvim" = {
    package = pkgs.vimPlugins.mini-nvim;
    event = [{
      event = "VimEnter";
      pattern = "*";
    }];
  };

  # Floating Terminal
  vim.lazy.plugins."FTerm.nvim" = {
    package = pkgs.vimPlugins.FTerm-nvim;
    event = [{
      event = "BufReadPre";
      pattern = "*";
    }];
  };

  # Outline for code navigation 
  vim.lazy.plugins."outline.nvim" = {
    package = pkgs.vimPlugins.outline-nvim;
    event = [{
      event = "BufReadPre";
      pattern = "*";
    }];
  };

  # Image Support Under Kitty 
  vim.lazy.plugins."image.nvim" = {
    package = pkgs.vimPlugins.image-nvim;
    event = [{
      event = "BufReadPre";
      pattern = "*";
    }];
  };

  # Image Copy and Paste
  vim.lazy.plugins."img-clip.nvim" = {
    package = pkgs.vimPlugins.img-clip-nvim;
    event = [{
      event = "BufReadPre";
      pattern = "*";
    }];
  };

  # Treesitter context 
  vim.lazy.plugins."nvim-treesitter-context" = {
    package = pkgs.vimPlugins.nvim-treesitter-context;
    event = [{
      event = "BufReadPre";
      pattern = "*";
    }];
  };

  # Easy bullet points for md
  vim.lazy.plugins."bullets.vim" = {
    package = pkgs.vimPlugins.bullets-vim;
    event = [{
      event = "BufReadPre";
      pattern = "*";
    }];
  };

  # Good headline themeing.
  vim.lazy.plugins."headlines.nvim" = {
    package = pkgs.vimPlugins.headlines-nvim;
    event = [{
      event = "BufReadPre";
      pattern = "*";
    }];
  };

  # Powershell treesitter 
  vim.lazy.plugins."vimplugin-treesitter-grammar-powershell" = {
    package = pkgs.vimPlugins.nvim-treesitter-parsers.powershell;
    event = [{
      event = "BufReadPre";
      pattern = "*";
    }];
  };

  # cmp 
  vim.lazy.plugins."blink.cmp" = {
    package = pkgs.vimPlugins.blink-cmp;
    event = [{
      event = "BufReadPre";
      pattern = "*";
    }];
  };

  # Oil
  vim.lazy.plugins."oil.nvim" = {
    package = pkgs.vimPlugins.oil-nvim;
    event = [{
      event = "BufReadPre";
      pattern = "*";
    }];
  };

  ## References raw lua for these plugins not nixified yet
  vim.startPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "org-modern-menu";
      src = ./neovim-plugins/org-modern-menu;
    })
    (pkgs.vimUtils.buildVimPlugin {
      name = "org-bullets";
      src = ./plugins/org-bullets;
    })
  ];
}

