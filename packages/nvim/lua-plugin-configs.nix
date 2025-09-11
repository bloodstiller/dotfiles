# Plugin setup and configuration
{ lib, pkgs, ... }: {
  vim.luaConfigRC.pluginConfigs = ''
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

           --Telescope
           require("telescope").load_extension("file_browser")


           --image.nvim
           require("image").setup({
             backend = "kitty",
             processor = "magick_cli",
             integrations = {
               markdown = {
                 enabled = true,
                 clear_in_insert_mode = false,
                 download_remote_images = false,
                 only_render_image_at_cursor = false,
                 only_render_image_at_cursor_mode = "inline",
                 floating_windows = false,
                 filetypes = { "markdown", "vimwiki" },
               },
               neorg = {
                 enabled = true,
                 clear_in_insert_mode = false,
                 download_remote_images = false,
                 only_render_image_at_cursor = false,
                 filetypes = { "norg" },
               },
               -- Add org mode support for nvim-orgmode
               --org = {
               --  enabled = true,
               --  clear_in_insert_mode = false,
               --  download_remote_images = false,
               --  only_render_image_at_cursor = false,
               --  filetypes = { "org" },
               --},
             },
             max_width = 800,
             max_height = 600,
             max_width_window_percentage = 80,
             max_height_window_percentage = 50,
             scale_factor = 1.0,
             window_overlap_clear_enabled = true,
             window_overlap_clear_ft_ignore = { 
               "cmp_menu", 
               "cmp_docs", 
               "" 
             },
             editor_only_render_when_focused = false,
             tmux_show_only_in_active_window = false,
             hijack_file_patterns = { 
               "*.png", 
               "*.jpg", 
               "*.jpeg", 
               "*.gif", 
               "*.webp" 
             },
           })


            --Img clip settings 
            local screenshots_dir = vim.fn.expand(os.getenv("SCREENSHOTS") or "~/screenshots")

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

                  dir_path = screenshots_dir,
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

       -----Sessions with auto-session 

             require("auto-session").setup({
    -- Enable logging for debugging (set to false in production)
         log_level = "error",
         
         -- Automatically save sessions
         auto_save_enabled = true,
         auto_restore_enabled = true,
         
         -- Session save location
         auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
         
         -- Suppress session create/restore notifications
         auto_session_suppress_dirs = {
           "~/",
           "~/Projects",
           "~/Downloads",
           "/",
         },
         
         -- Don't auto-restore session when opening specific files
         auto_session_allowed_dirs = nil,
         
         -- Session lens integration (for telescope)
         session_lens = {
           -- If you have telescope installed
           buftypes_to_ignore = {}, -- list of buffer types what should not be deleted from current session
           load_on_setup = true,
           theme_conf = { border = true },
           previewer = false,
         },
         
         -- Pre and post hooks
         pre_save_cmds = {
           -- Only close file trees if they exist
           function()
             -- Close nvim-tree if it exists
             local nvim_tree_ok, nvim_tree_api = pcall(require, "nvim-tree.api")
             if nvim_tree_ok then
               nvim_tree_api.tree.close()
             end
             
             -- Close neo-tree if it exists
             if vim.fn.exists(":Neotree") > 0 then
               vim.cmd("silent! Neotree close")
             end
           end,
         },
         
         post_restore_cmds = {
           -- Only show dashboard if no files are loaded and we're still on dashboard
           function()
             vim.defer_fn(function()
               local buf_count = #vim.fn.filter(vim.api.nvim_list_bufs(), 'buflisted(v:val)')
               local current_buf_name = vim.api.nvim_buf_get_name(0)
               
               -- If we have buffers loaded, switch away from dashboard
               if buf_count > 0 and vim.bo.filetype == "alpha" then
                 vim.cmd("silent! bnext")
               elseif buf_count == 0 or current_buf_name == "" then
                 -- Only show Alpha if no real files are loaded
                 vim.cmd("silent! Alpha")
               end
             end, 100)
           end,
         },
         
         -- Don't save sessions for these file types
         bypass_session_save_file_types = {
           "alpha",
           "dashboard",
           "NvimTree",
           "neo-tree",
           "TelescopePrompt",
         },
       })

       -- Auto commands for better integration
       local autocmd = vim.api.nvim_create_autocmd
       local augroup = vim.api.nvim_create_augroup("AutoSession", { clear = true })

       -- Don't auto-save session when alpha dashboard is open
       autocmd("User", {
         pattern = "AlphaReady",
         group = augroup,
         callback = function()
           vim.g.auto_session_enabled = false
         end,
       })

       -- Re-enable auto-session when leaving alpha
       autocmd("BufLeave", {
         pattern = "*",
         group = augroup,
         callback = function()
           if vim.bo.filetype ~= "alpha" then
             vim.g.auto_session_enabled = true
           end
         end,
       })


  '';
}

