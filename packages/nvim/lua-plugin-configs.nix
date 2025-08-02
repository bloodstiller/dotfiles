# Plugin setup and configuration
{ lib, pkgs, ... }: {
  vim.luaConfigRC.pluginConfigs = ''
        --Org
        require("orgmode").setup({
            org_agenda_files = "/home/martin/Dropbox/01-09_System/01-Emacs/01.02-OrgGtd/*.org",
            org_default_notes_file = "/home/martin/Dropbox/01-09_System/01-Emacs/01.02-OrgGtd/inbox.org",
            org_hide_emphasis_markers = true,
            org_startup_indented = true,
            org_edit_src_content_indentation = 2,
         })

             -- Set conceallevel for org files
             vim.api.nvim_create_autocmd('FileType', {
                 pattern = 'org',
                 callback = function()
                     vim.opt_local.conceallevel = 2
                 end,
             })

             require("org-bullets").setup()

             --Org-Modern
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

            --Org-Roam 
            --Works but seeing if I can replace with normal relative links to 
            --require("org-roam").setup({
            --  directory = "/home/martin/Dropbox/40-49_Career/40-Career-ZK",
            --  org_files = {
            --    "/home/martin/Dropbox/40-49_Career/40-Career-ZK/*.org",
            --    },
            --  database = { 
            --    path = "/home/martin/Nextcloud/Dropbox/40-49_Career/40-Career-ZK/db", 
            --    persist = true,
            --    update_on_save = true,
            --  }
            --})

            --NeoTree
            -- Also provides keyboard shortcut tab for expanding nodes
            require("neo-tree").setup({
              window = {
                mappings = {
                  ["<Tab>"] = "toggle_node",
                  ["<CR>"] = "open", -- Keep Enter for opening files 
                }
              }
            })

            --Blink config 
            require('blink.cmp').setup({
              sources = {
                per_filetype = {
                  org = {'orgmode'}
                },
                providers = {
                  orgmode = {
                    name = 'Orgmode',
                    module = 'orgmode.org.autocompletion.blink',
                    fallbacks = { 'buffer' },
                  },
                },
              },
            })


             --Outline
             require("outline").setup()

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


             --Img clip settings 
             require("img-clip").setup({
               default = {
                 embed_image_as_base64 = false,
                 prompt_for_file_name = true,
                 drag_and_drop = {
                   insert_mode = true,
                 },
                 use_absolute_path = false,
                 relative_to_current_file = true,
               },
               filetypes = {
                 markdown = {
                   url_encode_path = true,
                   template = "![$CURSOR]($FILE_PATH)",
                   dir_path = "~/assets",
                 },
               },
             })

             -- FTerm for floating terminal only
             local fterm = require('FTerm')
             local floating_term = fterm:new({
                 ft = 'fterm',
                 cmd = os.getenv('SHELL'),
                 dimensions = {
                     height = 0.8,
                     width = 0.8,
                     x = 0.1,
                     y = 0.1,
                 },
                 border = 'double'
             })

    -- Oil nvim settings
    require("oil").setup({
      -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
      default_file_explorer = false,
      
      -- Id is automatically added at the beginning, and name at the end
      columns = {
        "icon",
        -- "permissions",
        -- "size",
        -- "mtime",
      },
      
      -- Buffer-local options to use for oil buffers
      buf_options = {
        buflisted = false,
        bufhidden = "hide",
      },
      
      -- Window-local options to use for oil buffers
      win_options = {
        wrap = false,
        signcolumn = "no",
        cursorcolumn = false,
        foldcolumn = "0",
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = "nvic",
      },
      
      -- Send deleted files to the operating system trash instead of permanently deleting them
      delete_to_trash = true,
      
      -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
      skip_confirm_for_simple_edits = false,
      
      -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
      prompt_save_on_select_new_entry = true,
      
      -- Oil will automatically delete hidden buffers after this delay
      cleanup_delay_ms = 2000,
      lsp_file_methods = {
        -- Time to wait for LSP file operations to complete before skipping
        timeout_ms = 1000,
        -- Set to true to autosave buffers that are updated with LSP willRenameFiles
        autosave_changes = false,
      },
      
      -- Constrain the cursor to the editable parts of the oil buffer
      constrain_cursor = "editable",
      
      -- Set to true to watch the filesystem for changes and reload oil
      experimental_watch_for_changes = false,
      
      -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
      --keymaps = {
      --  ["g?"] = "actions.show_help",
      --  ["<CR>"] = "actions.select",
      --  ["<C-s>"] = "actions.select_vsplit",
      --  ["<C-h>"] = "actions.select_split",
      --  ["<C-t>"] = "actions.select_tab",
      --  ["<C-p>"] = "actions.preview",
      --  ["<C-c>"] = "actions.close",
      --  ["<C-l>"] = "actions.refresh",
      --  ["-"] = "actions.parent",
      --  ["_"] = "actions.open_cwd",
      --  ["`"] = "actions.cd",
      --  ["~"] = "actions.tcd",
      --  ["gs"] = "actions.change_sort",
      --  ["gx"] = "actions.open_external",
      --  ["g."] = "actions.toggle_hidden", -- This toggles hidden files
      --  ["g\\"] = "actions.toggle_trash",
      --},
      
      -- Set to false to disable all of the above keymaps
      use_default_keymaps = false,
      
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = true, -- This shows hidden files by default
        
        -- This function defines what is considered a "hidden" file
        is_hidden_file = function(name, bufnr)
          return vim.startswith(name, ".")
        end,
        
        -- This function defines what will never be shown, even when `show_hidden` is set
        is_always_hidden = function(name, bufnr)
          return false
        end,
        
        -- Sort file names in a more intuitive order for humans. Is less performant,
        -- so you may want to set to false if you work with large directories.
        natural_order = true,
        
        sort = {
          -- sort order can be "asc" or "desc"
          -- see :help oil-columns to see which columns are sortable
          { "type", "asc" },
          { "name", "asc" },
        },
      },
      
      -- Configuration for the floating window in oil.open_float
      float = {
        -- Padding around the floating window
        padding = 2,
        max_width = 0,
        max_height = 0,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
        -- This is the config that will be passed to nvim_open_win.
        -- Change values here to customize the layout
        override = function(conf)
          return conf
        end,
      },
      
      -- Configuration for the actions floating preview window
      preview = {
        -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        -- min_width and max_width can be a single value or a list of mixed integer/float types.
        max_width = 0.9,
        -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
        min_width = { 40, 0.4 },
        -- optionally define an integer/float for the exact width of the preview window
        width = nil,
        -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        -- min_height and max_height can be a single value or a list of mixed integer/float types.
        max_height = 0.9,
        min_height = { 5, 0.1 },
        -- optionally define an integer/float for the exact height of the preview window
        height = nil,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
        -- Whether the preview window is automatically updated when the cursor is moved
        update_on_cursor_moved = true,
      },
      
      -- Configuration for the floating progress window
      progress = {
        max_width = 0.9,
        min_width = { 40, 0.4 },
        width = nil,
        max_height = { 10, 0.9 },
        min_height = { 5, 0.1 },
        height = nil,
        border = "rounded",
        minimized_border = "none",
        win_options = {
          winblend = 0,
        },
      },
      
      -- Configuration for the floating SSH window
      ssh = {
        border = "rounded",
      },
    })



  '';
}

