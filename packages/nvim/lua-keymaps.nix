# Lua-based keymap configurations
{ lib, pkgs, ... }: {
  vim.luaConfigRC.keymaps = ''
     local map = vim.keymap.set
     local opts = { noremap = true, silent = true }

     -- Open nvim config
     vim.keymap.set('n', '<leader>=dc', function()
       vim.cmd('edit ' .. vim.fn.expand('~/.dotfiles/packages/nvim/nvf-configuration.nix'))
     end, { desc = "Open nvf-configuration" })

     -- Open nix config
     vim.keymap.set('n', '<leader>=dn', function()
       vim.cmd('edit ' .. vim.fn.expand('~/.dotfiles'))
     end, { desc = "Open nvf-configuration" })
     
     -- Basic navigation and telescope
        map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
        map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
        map("n", "<leader>t", "<cmd>Neotree toggle<cr>", { desc = "Neotree Open" })

     -- Move around windows with Ctrl + h/j/k/l
        map('n', '<leader>wh', '<C-w>h', opts)
        map('n', '<leader>wj', '<C-w>j', opts)
        map('n', '<leader>wk', '<C-w>k', opts)
        map('n', '<leader>wl', '<C-w>l', opts)

     -- Terminal functions
        vim.keymap.set("n", "<leader>ot", function() vim.cmd("belowright split | terminal") end, { desc = "Open terminal below" })
        vim.keymap.set("n", "<leader>oT", function() vim.cmd("vsplit | terminal") end, { desc = "Open terminal to the right" })

    -- Add ability to close terminal with same keymap
        vim.keymap.set("t", "<leader>ot", "<C-\\><C-n>:bd!<CR>", { desc = "Close terminal" })
        vim.keymap.set("t", "<leader>oT", "<C-\\><C-n>:bd!<CR>", { desc = "Close terminal" })

    -- Keymaps to toggle floating terminal
        vim.keymap.set("n", "<leader>T", function() floating_term:toggle() end, { desc = "[T]oggle [T]erminal" })
        vim.keymap.set("t", "<leader>T", function() floating_term:toggle() end, { desc = "[T]oggle [T]erminal" })

    -- Buffer navigation with barbar
    local map_api = vim.api.nvim_set_keymap
        
    -- Move to previous/next
    map_api('n', '<leader><Tab>h', '<Cmd>BufferPrevious<CR>', opts)
    map_api('n', '<leader><Tab>l', '<Cmd>BufferNext<CR>', opts)

    -----BUFFERS AND WINDOWS ----
    -- Close window/buffer with <leader>wx
    map_api('n', '<leader>wx', ':bd<CR>', {desc = "Close whole buffer"})

    -- Close Pane with <leader>wc
        map_api('n', '<leader>wc', ':close<CR>', {desc = "Close selected pane"})

    -- Create new blank buffer with <leader> and new dashboard
        map_api('n', '<leader>wn', ':tabnew | Alpha<CR>', {desc = "Create New Tab with Alpha"})

    -- Split pane horizontally with <leader>ws
        map_api('n', '<leader>ws', ':split<CR>', {desc = "Split Pane horizontally"})

    -- Split pane vertically with <leader>wv
    map_api('n', '<leader>wv', ':vsplit<CR>', {desc = "Split Pane vertically"})

    -- Goto buffer in position...
    map_api('n', '<leader><Tab>1', '<Cmd>BufferGoto 1<CR>', opts)
    map_api('n', '<leader><Tab>2', '<Cmd>BufferGoto 2<CR>', opts)
    map_api('n', '<leader><Tab>3', '<Cmd>BufferGoto 3<CR>', opts)
    map_api('n', '<leader><Tab>4', '<Cmd>BufferGoto 4<CR>', opts)
    map_api('n', '<leader><Tab>5', '<Cmd>BufferGoto 5<CR>', opts)
    map_api('n', '<leader><Tab>6', '<Cmd>BufferGoto 6<CR>', opts)
    map_api('n', '<leader><Tab>7', '<Cmd>BufferGoto 7<CR>', opts)
    map_api('n', '<leader><Tab>8', '<Cmd>BufferGoto 8<CR>', opts)
    map_api('n', '<leader><Tab>9', '<Cmd>BufferGoto 9<CR>', opts)
    map_api('n', '<leader><Tab>0', '<Cmd>BufferLast<CR>', opts)

    -- Pin/unpin buffer
    map_api('n', '<leader><Tab>p', '<Cmd>BufferPin<CR>', opts)

        -- Close buffer
        map_api('n', '<leader><Tab>x', '<Cmd>BufferClose<CR>', opts)

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

        -- Image paste
        vim.keymap.set('n', '<leader>ip', ':PasteImage<CR>', { desc = 'Paste image' })
  '';
}

