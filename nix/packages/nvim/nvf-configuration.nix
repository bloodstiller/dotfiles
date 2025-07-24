{ lib, pkgs, ... }: {
  vim = {
    #theme = {
    #enable = true;
    #name = "cattpuccin";
    #style = "mocha";
    #};

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
      filesystem = {
        hijack_netrw_behavior = "open_default";
        filtered_items = {
          visible = true; # Show hidden files (dotfiles)
          hide_dotfiles = false; # Explicitly do not hide dotfiles
          hide_gitignored = false; # Show gitignored files
          never_show =
            { }; # You can add specific filenames/folders to never show here
        };
      };
      default_source = "filesystem";
      open_files_in_last_window = true;
    };

    # Keymap to toggle NeoTree with <leader>t

    binds = { whichKey.enable = true; };

    keymaps = [
      # All keymaps in extra lua
      # Keymap to toggle NeoTree with <leader>t
      #{
      #key = "<leader>t";
      #mode = "n";
      #action = "<cmd>Neotree toggle<CR>";
      #}
      #{
      #key = "<leader>ff";
      #mode = "n";
      #silent = true;
      #action = ":Telescope find_files<CR>";
      #}
      #{
      #key = "<leader>fg";
      #mode = "n";
      #silent = true;
      #action = ":Telescope live_grep<CR>";
      #}
      #{
      #key = "<leader>or";
      #mode = "n";
      #silent = true;
      #action = ":lua require('org-roam.ui').toggle()<CR>";
      #}
      #{
      #key = "<C-s>";
      #mode = "i";
      #action = "<Esc>:w<CR>";
      #}
      #{ # Vertical split: <leader>ws
      #key = "<leader>ws";
      #mode = "n";
      #action = ":vsplit<CR>";
      #}
      #
      #{ # Horizontal split: <leader>ws
      #key = "<leader>wh";
      #mode = "n";
      #action = ":split<CR>";
      #}
      #{ # Close window
      #key = "<leader>wx";
      #mode = "n";
      #action = ":close<CR>";
      #}
      #{ # New empty window
      #key = "<leader>wn";
      #mode = "n";
      #action = ":new<CR>";
      #}

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

  # Telescope file browser for emacs like counsel
  vim.lazy.plugins."telescope-file-browser.nvim" = {
    package = pkgs.vimPlugins.telescope-file-browser-nvim;
    event = [{
      event = "BufReadPre";
      pattern = "*";
    }];
  };

  # Org Mode
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

  # Org Roam
  vim.lazy.plugins."org-roam.nvim" = {
    package = pkgs.vimPlugins.org-roam-nvim;
    setupModule = "org-roam";
    setupOpts = {
      directory = ''
        /home/martin/Dropbox/01-09_System/01-Emacs/01.02-OrgGtd
      '';
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

  # General Dependency Used By other things, do not remove.
  vim.lazy.plugins."plenary.nvim" = { package = pkgs.vimPlugins.plenary-nvim; };

  # Harpoon
  vim.lazy.plugins."harpoon2" = {
    package = pkgs.vimPlugins.harpoon2; # if you're using an override
    # If not, you might need to manually fetch the plugin via vimUtils
    # See alternative below
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
         --Org Lua
         require("orgmode").setup({})

         require("org-bullets").setup()

         require("headlines").setup()

        require("org-roam").setup({
          directory = "/home/martin/Dropbox/01-09_System/01-Emacs/01.02-OrgGtd",
           })

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

         -- Alpha (dashboard)
         local alpha = require("alpha")
         local dashboard = require("alpha.themes.dashboard")
         alpha.setup(dashboard.config)

         -- Harpoon
         require("harpoon"):setup()

         -- Barbar
         vim.g.barbar_auto_setup = false
          require("barbar").setup({
            animation = true,
            insert_at_start = true,
            icons = {
              buffer_index = true,
              filetype = {
                enabled = true,
              },
            },
          })

        --FT Term
        local fterm = require("FTerm")

        -- telescope
        require("telescope").setup({
           extensions = {
             file_browser = {
               hijack_netrw = true,
               grouped = true,
               hidden = true,
               respect_gitignore = false,
               initial_mode = "insert",
             },
           },
         })
         require("telescope").load_extension("file_browser")


    local map = vim.keymap.set
    map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
    map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
    map("n", "<leader>t", "<cmd>Neotree toggle<cr>", { desc = "Neotree Open" })

    -- Close window/buffer with <leader>wc
    map('n', '<leader>wx', ':bd<CR>', {desc = "Close whole buffer"})

    -- Close Pane with <leader>wc
    map('n', '<leader>wc', ':close<CR>', {desc = "Close selected pane"})

    -- Create new blank buffer with <leader>wn
    map('n', '<leader>wn', ':enew<CR>', {desc = "Create New Pane"})

    -- Split pane horizontally with <leader>ws
    map('n', '<leader>ws', ':split<CR>', {desc = "Split Pane horizontally"})

    -- Split pane vertically with <leader>wv
    map('n', '<leader>wv', ':vsplit<CR>', {desc = "Split Pane vertically"})

    -- Move around windows with Ctrl + h/j/k/l
    map('n', '<C-h>', '<C-w>h', opts)
    map('n', '<C-j>', '<C-w>j', opts)
    map('n', '<C-k>', '<C-w>k', opts)
    map('n', '<C-l>', '<C-w>l', opts)

    -- Open terminal in horizontal split at bottom
    map("n", "<leader>ot", function()
      vim.cmd("belowright split | terminal")
    end, { desc = "Open terminal below" })

    -- Open terminal in vertical split
    map("n", "<leader>oT", function()
      vim.cmd("vsplit | terminal")
    end, { desc = "Open terminal to the right" })


    -- Floating Terminal
    vim.keymap.set("n", "<leader>T", function() fterm:toggle() end, { desc = "[T]oggle [T]erminal" })
    vim.keymap.set("t", "<leader>T", function() fterm:toggle() end, { desc = "[T]oggle [T]erminal" })

    --Harpoon
    local map = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }

    -- Move to previous/next
    map('n', '<leader><Tab>h', '<Cmd>BufferPrevious<CR>', opts)
    map('n', '<leader><Tab>l', '<Cmd>BufferNext<CR>', opts)

    -- Goto buffer in position...
    map('n', '<leader><Tab>1', '<Cmd>BufferGoto 1<CR>', opts)
    map('n', '<leader><Tab>2', '<Cmd>BufferGoto 2<CR>', opts)
    map('n', '<leader><Tab>3', '<Cmd>BufferGoto 3<CR>', opts)
    map('n', '<leader><Tab>4', '<Cmd>BufferGoto 4<CR>', opts)
    map('n', '<leader><Tab>5', '<Cmd>BufferGoto 5<CR>', opts)
    map('n', '<leader><Tab>6', '<Cmd>BufferGoto 6<CR>', opts)
    map('n', '<leader><Tab>7', '<Cmd>BufferGoto 7<CR>', opts)
    map('n', '<leader><Tab>8', '<Cmd>BufferGoto 8<CR>', opts)
    map('n', '<leader><Tab>9', '<Cmd>BufferGoto 9<CR>', opts)
    map('n', '<leader><Tab>0', '<Cmd>BufferLast<CR>', opts)

    -- Pin/unpin buffer
    map('n', '<leader><Tab>p', '<Cmd>BufferPin<CR>', opts)

    -- Close buffer
    map('n', '<leader><Tab>x', '<Cmd>BufferClose<CR>', opts)


    -- Copy to system clipboard
    vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })
    vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank line to clipboard" })

    -- Paste from system clipboard
    vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from clipboard" })
    vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', { desc = "Paste before from clipboard" })

    -- Easily open files with telescope like emacs
    vim.keymap.set("n", "<leader>.", function()
      require("telescope").extensions.file_browser.file_browser({
        path = "%:p:h",
        cwd = vim.fn.expand("%:p:h"),
        respect_gitignore = false,
        hidden = true,
        grouped = true,
        layout_strategy = "horizontal",
        layout_config = {
          height = 15,
          preview_width = 0.5,
        },
      })
    end, { desc = "File Browser (like Emacs)" })

    -- Easily navigate through open buffers with telescope
    vim.keymap.set("n", "<leader>,", "<cmd>Telescope buffers<CR>", { desc = "Switch Buffers" })


    --Harpoon mappings
    --This just ensures harpoon keymaps are loaded after harpoon
    local ok, harpoon = pcall(require, "harpoon")
    if not ok then return end

    local harpoon = require("harpoon")

    -- Add current file to Harpoon list
    vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon Add File" })

    -- Toggle quick menu
    vim.keymap.set("n", "<leader>hm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon Quick Menu" })

    -- Navigate to files
    vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end, { desc = "Harpoon File 1" })
    vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end, { desc = "Harpoon File 2" })
    vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end, { desc = "Harpoon File 3" })
    vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end, { desc = "Harpoon File 4" })

    -- Cycle through files
    vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end, { desc = "Harpoon Prev" })
    vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end, { desc = "Harpoon Next" })

    -- DomeOne Theme
    vim.g.doom_one_cursor_coloring = false
    vim.g.doom_one_terminal_colors = true
    vim.g.doom_one_italic_comments = false
    vim.g.doom_one_enable_treesitter = true
    vim.g.doom_one_diagnostics_text_color = false
    vim.g.doom_one_transparent_background = false

    vim.g.doom_one_pumblend_enable = false
    vim.g.doom_one_pumblend_transparency = 20

    vim.g.doom_one_plugin_neorg = true
    vim.g.doom_one_plugin_barbar = false
    vim.g.doom_one_plugin_telescope = false
    vim.g.doom_one_plugin_neogit = true
    vim.g.doom_one_plugin_nvim_tree = true
    vim.g.doom_one_plugin_dashboard = true
    vim.g.doom_one_plugin_startify = true
    vim.g.doom_one_plugin_whichkey = true
    vim.g.doom_one_plugin_indent_blankline = true
    vim.g.doom_one_plugin_vim_illuminate = true
    vim.g.doom_one_plugin_lspsaga = false

    vim.cmd.colorscheme("doom-one")
  '';

}
