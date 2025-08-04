# Extra Lua configuration
{ lib, pkgs, ... }: {
  vim.luaConfigRC.extraPlugins = ''
                --Org

                require("orgmode").setup({})

                require("org-bullets").setup()


                --require("org-roam").setup({
                  --database = {
                     --update_on_save = true,
                     --persist = true,
                  --},
                 -- })

                --local Menu = require("org-modern.menu")
                -- require("orgmode").setup({
                --   ui = {
                --     menu = {
                --       handler = function(data)
                --         Menu:new():open(data)
                --       end,
                --     },
                --   },
                -- })

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

                ---Org mode spell check and auto completion
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

    ___________________________________________

                --img-clip
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

             vim.keymap.set('n', '<leader>ip', ':PasteImage<CR>', { desc = 'Paste image' })



             local map = vim.keymap.set
             map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
             map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
             map("n", "<leader>t", "<cmd>Neotree toggle<cr>", { desc = "Neotree Open" })

            -- Move around windows with Ctrl + h/j/k/l
            map('n', '<C-h>', '<C-w>h', opts)
            map('n', '<C-j>', '<C-w>j', opts)
            map('n', '<C-k>', '<C-w>k', opts)
            map('n', '<C-l>', '<C-w>l', opts)



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

                                                          -- Terminal functions
                                                          vim.keymap.set("n", "<leader>ot", function() vim.cmd("belowright split | terminal") end, { desc = "Open terminal below" })
                                                          vim.keymap.set("n", "<leader>oT", function() vim.cmd("vsplit | terminal") end, { desc = "Open terminal to the right" })

                                                          -- Add ability to close terminal with same keymap
                                                          vim.keymap.set("t", "<leader>ot", "<C-\\><C-n>:bd!<CR>", { desc = "Close terminal" })
                                                          vim.keymap.set("t", "<leader>oT", "<C-\\><C-n>:bd!<CR>", { desc = "Close terminal" })

                                                          -- Keymaps to toggle on terminal.
                                                          vim.keymap.set("n", "<leader>T", function() floating_term:toggle() end, { desc = "[T]oggle [T]erminal" })
                                                          vim.keymap.set("t", "<leader>T", function() floating_term:toggle() end, { desc = "[T]oggle [T]erminal" })

                                                          --Harpoon
                                                          local map = vim.api.nvim_set_keymap
                                                          local opts = { noremap = true, silent = true }

                                                          -- Move to previous/next
                                                          map('n', '<leader><Tab>h', '<Cmd>BufferPrevious<CR>', opts)
                                                          map('n', '<leader><Tab>l', '<Cmd>BufferNext<CR>', opts)

                                                          -----BUFFERS AND WINDOWS ----
                                                          -- Close window/buffer with <leader>wc
                                                          map('n', '<leader>wx', ':bd<CR>', {desc = "Close whole buffer"})

                                                          -- Close Pane with <leader>wc
                                                          map('n', '<leader>wc', ':close<CR>', {desc = "Close selected pane"})

                                                          -- Create new blank buffer with <leader>wn
                                                          map('n', '<leader>wn', ':tabnew | Alpha<CR>', {desc = "Create New Tab with Alpha"})

                                                          -- Split pane horizontally with <leader>ws
                                                          map('n', '<leader>ws', ':split<CR>', {desc = "Split Pane horizontally"})

                                                          -- Split pane vertically with <leader>wv
                                                          map('n', '<leader>wv', ':vsplit<CR>', {desc = "Split Pane vertically"})

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


                                                          --Outline shortcut
                                                          vim.keymap.set("n", "<leader>oo", "<cmd>Outline<CR>", { desc = "Toggle Outline" })

                                                          -- Cycle through files
                                                          vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end, { desc = "Harpoon Prev" })
                                                          vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end, { desc = "Harpoon Next" })

                                                          -- DomeOne Theme
                                                          vim.g.doom_one_cursor_coloring = true
                                                          vim.g.doom_one_terminal_colors = true
                                                          vim.g.doom_one_italic_comments = true
                                                          vim.g.doom_one_enable_treesitter = true
                                                          vim.g.doom_one_diagnostics_text_color = false
                                                          vim.g.doom_one_transparent_background = false

                                                          vim.g.doom_one_pumblend_enable = false
                                                          vim.g.doom_one_pumblend_transparency = 20

                                                          vim.g.doom_one_plugin_neorg = true
                                                          vim.g.doom_one_plugin_barbar = true
                                                          vim.g.doom_one_plugin_telescope = true
                                                          vim.g.doom_one_plugin_neogit = true
                                                          vim.g.doom_one_plugin_nvim_tree = true
                                                          vim.g.doom_one_plugin_dashboard = true
                                                          vim.g.doom_one_plugin_startify = true
                                                          vim.g.doom_one_plugin_whichkey = true
                                                          vim.g.doom_one_plugin_indent_blankline = true
                                                          vim.g.doom_one_plugin_vim_illuminate = true
                                                          vim.g.doom_one_plugin_lspsaga = false

                                                          vim.cmd.colorscheme("doom-one")

                    -- Enhanced markview configuration for better spacing and organization
                            require("markview").setup({
                              preview = {
                                modes = { "n", "no", "c" },
                                hybrid_modes = { "n" }
                              }, -- Added missing comma here

                              markdown = {
                                headings = {
                                  enable = true,
                                  shift_width = 1,  -- Add some indentation
                                  heading_1 = {
                                    style = "label",
                                    hl = "MarkviewHeading1",
                                    padding_left = 2,  -- Add left padding
                                    padding_right = 2, -- Add right padding
                                  },
                                  heading_2 = {
                                    style = "label",
                                    hl = "MarkviewHeading2",
                                    padding_left = 2,
                                    padding_right = 2,
                                  },
                                  heading_3 = {
                                    style = "label",
                                    hl = "MarkviewHeading3",
                                    padding_left = 2,
                                    padding_right = 2,
                                  },
                                  heading_4 = {
                                    style = "label",
                                    hl = "MarkviewHeading4",
                                    padding_left = 2,
                                    padding_right = 2,
                                  },
                                  heading_5 = {
                                    style = "label",
                                    hl = "MarkviewHeading5",
                                    padding_left = 2,
                                    padding_right = 2,
                                  },
                                  heading_6 = {
                                    style = "label",
                                    hl = "MarkviewHeading6",
                                    padding_left = 2,
                                    padding_right = 2,
                                  },
                                },

                                -- Better list formatting - moved here and fixed
                                list_items = {
                                  enable = true,
                                  indent_size = 2,
                                  shift_width = 2,
                                  marker_minus = {
                                    text = "·", -- Much smaller centered dot
                                    hl = "MarkviewListItemMinus"
                                  },
                                },

                                code_blocks = {
                                  enable = true,
                                  style = "language", -- This preserves syntax highlighting
                                  language_direction = "right",
                                  min_width = 60,
                                  pad_amount = 2,  -- More padding around code blocks
                                },

                                -- Better emphasis and strong formatting
                                emphasis = {
                                  enable = true,
                                  hl = "MarkviewItalic"
                                },
                                strong = {
                                  enable = true,
                                  hl = "MarkviewBold"
                                }
                              },

                              code_blocks = {
                                enable = true,
                                style = "simple",
                                border_hl = "MarkviewCodeBlockBorder",
                                pad_amount = 1,
                              },

                              inline_codes = {
                                enable = true,
                                hl = "MarkviewInlineCode",
                                padding_left = 1,
                                padding_right = 1,
                              }
                            })

                            -- Enhanced highlight configuration for better visual organization
                            local function set_doom_one_markdown_highlights()
                              -- Doom One color palette
                              local blue = "#51afef"      -- H1 - Blue
                              local magenta = "#c678dd"   -- H2 - Magenta
                              local teal = "#4db5bd"      -- H3 - Teal
                              local cyan = "#46D9FF"      -- H4 - Cyan
                              local violet = "#a9a1e1"   -- H5 - Violet
                              local dark_cyan = "#5699AF" -- H6 - Dark cyan

                              local bg = "#282c34"        -- Main background
                              local bg_alt = "#21242b"    -- Darker background
                              local base5 = "#5B6268"     -- Muted text

                        -- Headings with different colors per level and better backgrounds
                        vim.api.nvim_set_hl(0, "MarkviewHeading1", {
                          fg = blue,        -- #51afef (blue)
                          bold = true,
                          bg = "#2a3441",
                          italic = false
                        })
                        vim.api.nvim_set_hl(0, "MarkviewHeading2", {
                          fg = magenta,     -- #c678dd (magenta)
                          bold = true,
                          bg = "#332a3d",
                          italic = false
                        })
                        vim.api.nvim_set_hl(0, "MarkviewHeading3", {
                          fg = teal,        -- #4db5bd (teal)
                          bold = true,
                          bg = "#2a3d37",
                          italic = false
                        })
                        vim.api.nvim_set_hl(0, "MarkviewHeading4", {
                          fg = cyan,        -- #46D9FF (cyan)
                          bold = true,
                          bg = "#2a3a41",
                          italic = false
                        })
                        vim.api.nvim_set_hl(0, "MarkviewHeading5", {
                          fg = violet,      -- #a9a1e1 (violet)
                          bold = true,
                          bg = "#35314a",
                          italic = false
                        })
                        vim.api.nvim_set_hl(0, "MarkviewHeading6", {
                          fg = dark_cyan,   -- #5699AF (dark cyan)
                          bold = true,
                          bg = "#2e3541",
                          italic = false
                        })

                              -- Better code styling
                              vim.api.nvim_set_hl(0, "MarkviewInlineCode", {
                                fg = "#c678dd",
                                bg = "#2d333b",
                                bold = true
                              })
                              vim.api.nvim_set_hl(0, "MarkviewCodeBlock", {
                                bg = "#1a1e23"
                              })
                              vim.api.nvim_set_hl(0, "MarkviewCodeBlockBorder", {
                                fg = base5,
                                bg = "#1a1e23"
                              })

                              -- Better text formatting
                              vim.api.nvim_set_hl(0, "MarkviewBold", { fg = "#c5cdd8", bold = true })
                              vim.api.nvim_set_hl(0, "MarkviewItalic", { fg = "#b18c00", bold = true })
                              vim.api.nvim_set_hl(0, "MarkviewStrike", {
                                fg = "#FF6c6b",
                                bold = true,
                                italic = true,
                                underline = true,
                                strikethrough = false
                              })

                              -- List markers - this will style your smaller bullets
                              vim.api.nvim_set_hl(0, "MarkviewListItemMinus", { fg = teal, bold = true })

                              -- Links
                              vim.api.nvim_set_hl(0, "MarkviewLink", { fg = blue, underline = true })
                              vim.api.nvim_set_hl(0, "MarkviewLinkText", { fg = cyan })

                              -- Only set fallback highlights for inline code and basic markup
                              vim.api.nvim_set_hl(0, "@markup.strong", { fg = "#c5cdd8", bold = true })
                              vim.api.nvim_set_hl(0, "@markup.italic", { fg = "#b18c00", bold = true })
                              vim.api.nvim_set_hl(0, "@markup.raw.markdown_inline", { fg = "#c678dd", bg = "#2d333b", bold = true })
                              vim.api.nvim_set_hl(0, "@markup.strikethrough", {
                                fg = "#FF6c6b",
                                bold = true,
                                italic = true,
                                underline = true,
                                strikethrough = false
                              })
                            end

                            -- Apply highlights after colorscheme loads
                            vim.api.nvim_create_autocmd("ColorScheme", {
                              callback = set_doom_one_markdown_highlights,
                            })

                            -- CONSOLIDATED FileType autocmd for markdown (replaces all your separate ones)
                            vim.api.nvim_create_autocmd("FileType", {
                              pattern = "markdown",
                              callback = function()
                                -- Apply highlights
                                vim.defer_fn(set_doom_one_markdown_highlights, 100)

                                -- Better line spacing and typography
                                vim.opt_local.linespace = 2

                                -- Enhanced wrapping and indentation
                                vim.opt_local.wrap = true
                                vim.opt_local.linebreak = true
                                vim.opt_local.breakindent = true
                                vim.opt_local.breakindentopt = "shift:2,min:20,sbr"
                                vim.opt_local.showbreak = "  ↳ "

                                -- Better visual spacing and concealment
                                vim.opt_local.conceallevel = 2
                                vim.opt_local.concealcursor = 'nc'

                                -- Improved scrolling and cursor
                                vim.opt_local.smoothscroll = true
                                vim.opt_local.scrolloff = 8
                                vim.opt_local.cursorline = true

                                -- Better movement on wrapped lines
                                vim.keymap.set('n', 'j', 'gj', { buffer = true })
                                vim.keymap.set('n', 'k', 'gk', { buffer = true })
                                vim.keymap.set('n', '0', 'g0', { buffer = true })
                                vim.keymap.set('n', '$', 'g$', { buffer = true })
                              end,
                            })

                            -- Apply highlights immediately on startup
                            vim.api.nvim_create_autocmd("VimEnter", {
                              callback = function()
                                vim.defer_fn(set_doom_one_markdown_highlights, 100)
                              end,
                            })

                                    -- Enhanced markdown editing features
                                    vim.api.nvim_create_autocmd("FileType", {
                                      pattern = "markdown",
                                      callback = function()
                                        -- Spell checking
                                        vim.opt_local.spell = true
                                        vim.opt_local.spelllang = "en_us"

                                        -- Quick formatting shortcuts
                                        vim.keymap.set('v', '<leader>mb', 'c**<C-r>"**<Esc>', { buffer = true, desc = 'Bold selection' })
                                        vim.keymap.set('v', '<leader>mi', 'c*<C-r>"*<Esc>', { buffer = true, desc = 'Italic selection' })
                                        vim.keymap.set('v', '<leader>mc', 'c`<C-r>"`<Esc>', { buffer = true, desc = 'Code selection' })

                                        -- Quick link creation
                                        vim.keymap.set('v', '<leader>ml', function()
                                          local url = vim.fn.input('URL: ')
                                          if url ~= "" then
                                            vim.cmd('normal! c[<C-r>"](' .. url .. ')')
                                          end
                                        end, { buffer = true, desc = 'Create link' })
                                      end,
                                    })

                                    -- Date/time insertion
                                    vim.keymap.set('n', '<leader>md', function()
                                      local date = os.date('%Y-%m-%d')
                                      vim.api.nvim_put({date}, 'c', true, true)
                                    end, { desc = 'Insert date' })

                                    vim.keymap.set('n', '<leader>mdt', function()
                                      local datetime = os.date('%Y-%m-%d %H:%M:%S')
                                      vim.api.nvim_put({datetime}, 'c', true, true)
                                    end, { desc = 'Insert datetime' })

                                    -- Quick TODO insertion
                                    vim.keymap.set('n', '<leader>todo', function()
                                      vim.api.nvim_put({'- [ ] '}, 'c', false, true)
                                      vim.cmd('startinsert!')
                                    end, { desc = 'Insert TODO' })

                                    -- Toggle TODO completion
                                    vim.keymap.set('n', '<leader>x', function()
                                      local line = vim.api.nvim_get_current_line()
                                      if line:match('%- %[ %]') then
                                        local new_line = line:gsub('%- %[ %]', '- [x]')
                                        vim.api.nvim_set_current_line(new_line)
                                      elseif line:match('%- %[x%]') then
                                        local new_line = line:gsub('%- %[x%]', '- [ ]')
                                        vim.api.nvim_set_current_line(new_line)
                                      end
                                    end, { desc = 'Toggle TODO' })

                                    -- Markdown preview and export
                                    vim.api.nvim_create_user_command('MarkdownPreview', function()
                                      local file = vim.fn.expand('%:p')
                                      vim.fn.system('glow "' .. file .. '"')
                                    end, { desc = 'Preview markdown with glow' })

                                    vim.api.nvim_create_user_command('MarkdownToPDF', function()
                                      local input = vim.fn.expand('%')
                                      local output = vim.fn.expand('%:r') .. '.pdf'
                                      vim.fn.system('pandoc "' .. input .. '" -o "' .. output .. '"')
                                      print('Exported to ' .. output)
                                    end, { desc = 'Export to PDF' })

                                    vim.keymap.set('n', '<leader>mp', ':MarkdownPreview<CR>', { desc = 'Preview markdown' })
                                    vim.keymap.set('n', '<leader>me', ':MarkdownToPDF<CR>', { desc = 'Export to PDF' })

                                    -- Quick note creation
                                    vim.keymap.set('n', '<leader>nn', function()
                                      local filename = vim.fn.input('Note name: ')
                                      if filename ~= "" then
                                        vim.cmd('edit ' .. filename .. '.md')
                                      end
                                    end, { desc = 'New note' })

                                    -- Table creation helper
                                    vim.keymap.set('n', '<leader>mt', function()
                                      local cols = tonumber(vim.fn.input('Number of columns: ')) or 2
                                      local rows = tonumber(vim.fn.input('Number of rows: ')) or 2

                                      local table_lines = {}

                                      -- Header row
                                      local header = '|'
                                      local separator = '|'
                                      for i = 1, cols do
                                        header = header .. ' Header ' .. i .. ' |'
                                        separator = separator .. ' --- |'
                                      end
                                      table.insert(table_lines, header)
                                      table.insert(table_lines, separator)

                                      -- Data rows
                                      for r = 1, rows do
                                        local row = '|'
                                        for c = 1, cols do
                                          row = row .. ' Cell ' .. r .. ',' .. c .. ' |'
                                        end
                                        table.insert(table_lines, row)
                                      end

                                      vim.api.nvim_put(table_lines, 'l', true, true)
                                    end, { desc = 'Create table' })

                                    -- Enhanced folding for markdown
                                    vim.api.nvim_create_autocmd("FileType", {
                                      pattern = "markdown",
                                      callback = function()
                                        vim.opt_local.foldmethod = "expr"
                                        vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
                                        vim.opt_local.foldenable = false  -- Start with folds open
                                        vim.opt_local.foldlevel = 99
                                      end,
                                    })

                                    -- Markdown-specific telescope searches
                                    vim.keymap.set('n', '<leader>mf', function()
                                      require('telescope.builtin').find_files({
                                        prompt_title = "Markdown Files",
                                        find_command = { 'find', '.', '-type', 'f', '-name', '*.md' },
                                      })
                                    end, { desc = 'Find markdown files' })

                                    vim.keymap.set('n', '<leader>mg', function()
                                      require('telescope.builtin').live_grep({
                                        prompt_title = "Search in Markdown",
                                        type_filter = "md",
                                      })
                                    end, { desc = 'Search in markdown files' })

                                    -- Image paste configuration
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
                                          dir_path = "assets",
                                        },
                                      },
                                    })

                                    vim.keymap.set('n', '<leader>ip', ':PasteImage<CR>', { desc = 'Paste image' })




  '';

}

