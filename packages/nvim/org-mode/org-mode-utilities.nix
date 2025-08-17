# Utility functions for folding and other misc features
{ lib, pkgs, ... }: {
  vim.luaConfigRC.orgModeUtilities = ''
    -- Simulate msn & msN for folding focus in org-mode 
    local function focus_current_fold()
      -- Save current cursor position
      local cursor = vim.api.nvim_win_get_cursor(0)
      
      -- Close all folds
      vim.cmd('normal! zM')
      
      -- Restore cursor position
      vim.api.nvim_win_set_cursor(0, cursor)
      
      -- Open fold under cursor
      vim.cmd('normal! zv')
    end

    local function open_all_folds()
      -- Open all folds
      vim.cmd('normal! zR')
    end

    -- Set up the key mappings
    vim.keymap.set('n', '<leader>msn', focus_current_fold, { desc = 'Focus current fold' })
    vim.keymap.set('n', '<leader>msN', open_all_folds, { desc = 'Open all folds' })

    -- Fix Hugo Files After Converting From Org
    -- Syntax for tilde is correct has to be escaped for the conversion and in this lua
    vim.keymap.set('n', '<leader>Msc', function()
      vim.cmd('%s/\\~\\~/+/g')
      vim.cmd('%s/{.verbatim}//g')
      vim.cmd('%s/{.underline}//g')
    end, { desc = 'Run predefined find and replace' })
  '';
}
