# Appearance, colors, and formatting configuration
{ lib, pkgs, ... }: {
  vim.luaConfigRC.orgModeAppearance = ''
    -- Org bullets setup
    require("org-bullets").setup()

    -- Comprehensive color overrides for agenda readability  
    local function setup_orgmode_colors()
      local highlights = {
        -- Core agenda colors (fixes the main readability issues)
        ['@org.agenda.deadline'] = { fg = '#ff6c6b', bold = true },
        ['@org.agenda.scheduled'] = { fg = '#98be65' },
        ['@org.agenda.scheduled_past'] = { fg = '#ECBE7B', underline = true },
        ['@org.agenda.day'] = { fg = '#c678dd', bold = true },
        ['@org.agenda.today'] = { fg = '#98be65', bold = true, underline = true },
        
        -- Priority and metadata  
        ['@org.priority.highest'] = { fg = '#ff6c6b', bold = true, bg = '#2d1b1b' },
        ['@org.tag'] = { fg = '#fab005', italic = true },
        ['@org.timestamp.active'] = { fg = '#74c0fc' },
        ['@org.timestamp.inactive'] = { fg = '#868e96' },
      }
      
      for group, opts in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, opts)
      end
    end

    -- Apply on colorscheme changes AND immediately
    vim.api.nvim_create_autocmd('ColorScheme', {
      pattern = '*',
      callback = setup_orgmode_colors
    })

    setup_orgmode_colors() -- Apply now

    -- Dynamic Line wrapping based on window size
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'org',
      callback = function()
        vim.opt_local.conceallevel = 3
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.breakindent = true
        vim.opt_local.showbreak = "  "
        
        -- Smarter wrapping that respects window size
        local function set_wrap_width()
          local win_width = vim.api.nvim_win_get_width(0)
          if win_width > 200 then
            vim.opt_local.colorcolumn = "100"
          else
            vim.opt_local.colorcolumn = ""
          end
        end
        
        set_wrap_width()
        
        -- Adjust on window resize
        vim.api.nvim_create_autocmd('WinResized', {
          buffer = 0,
          callback = set_wrap_width
        })
      end,
    })
  '';
}
