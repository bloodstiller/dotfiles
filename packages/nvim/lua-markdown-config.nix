# Markdown-specific configuration and markview setup
{ lib, pkgs, ... }: {
  vim.luaConfigRC.markdownConfig = ''
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
  '';
}

