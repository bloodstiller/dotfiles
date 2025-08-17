# Basic keymaps and shortcuts
{ lib, pkgs, ... }: {
  vim.luaConfigRC.orgModeKeymaps = ''
    -- Open Inbox 
    vim.keymap.set('n', '<leader>=i', function()
      vim.cmd('edit ' .. vim.fn.expand('~/Org/01-Emacs/01.02-OrgGtd/inbox.org'))
    end, { desc = "Open Inbox" })

    -- Open Todo Files 
    vim.keymap.set('n', '<leader>=t', function()
      vim.cmd('edit ' .. vim.fn.expand('~/Org/01-Emacs/01.02-OrgGtd/org-gtd-tasks.org'))
    end, { desc = "Open Todo" })

    -- Map <leader>nd to toggle TODO state in org files
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "org",
      callback = function()
        vim.keymap.set('n', '<leader>nd', 'cit', { buffer = true, remap = true, desc = "Toggle TODO state" })
      end,
    })

    -- Map <leader>mds to toggle TODO schedule 
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "org",
      callback = function()
        vim.keymap.set('n', '<leader>mds', '<leader>ois', { buffer = true, remap = true, desc = "Set Scheduled Date" })
      end,
    })

    -- Map <leader>msa to archive 
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "org",
      callback = function()
        vim.keymap.set('n', '<leader>msa', '<leader>o$', { buffer = true, remap = true, desc = "Archive" })
      end,
    })

    -- Clock in and out easily 
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "org",
      callback = function()
        -- Clock In
        vim.keymap.set('n', '<leader>mci', function()
          require('orgmode').action('clock.clock_in')
        end, { buffer = true, desc = "Clock In" })
        
        -- Clock out  
        vim.keymap.set('n', '<leader>mco', function()
          require('orgmode').action('clock.clock_out')
        end, { buffer = true, desc = "Clock Out" })
      end,
    })

    -- Meta + RETURN to add list items + Checkboxes
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "org",
      callback = function()
        vim.keymap.set('n', '<M-CR>', '<Leader><CR>', { buffer = true, remap = true, desc = "Insert list/checkbox below" })
      end,
    })

    -- SHIFT + RETURN to add list items + Checkboxes
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "org",
      callback = function()
        vim.keymap.set('n', '<C-CR>', function()
          require('orgmode').action('org_mappings.insert_todo_heading_respect_content')
        end, { buffer = true, desc = "Insert TODO Heading" })
      end,
    })

    -- Easy src block creation  
    -- Type <s then hit space
    vim.keymap.set('i', '<s ', function()
      return '#+begin_src\n\n#+end_src\027ka'
    end, { expr = true })
  '';
}
