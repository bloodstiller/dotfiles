# Org-mode theming configuration for Doom One theme
{ lib, pkgs, ... }: {
  vim.luaConfigRC.orgmodeTheme = ''
    -- Enhanced highlight configuration for org-mode code blocks (Doom One theme)
    local function set_doom_one_org_highlights()
      -- Doom One color palette
      local magenta = "#c678dd"
      local base5 = "#5B6268"
      local dark_bg = "#252a33"  -- Light background for code blocks

      -- Override the official org-mode highlight groups
      vim.api.nvim_set_hl(0, "@org.block", {
        bg = dark_bg,
        ctermbg = 235
      })

      -- Also set the directive lines (#+BEGIN_SRC, #+END_SRC)
      vim.api.nvim_set_hl(0, "@org.directive", {
        fg = base5,
        bg = dark_bg,
        ctermbg = 235
      })

      -- Inline code blocks
      vim.api.nvim_set_hl(0, "@org.inline_block", {
        fg = magenta,
        bg = "#2d333b",
        bold = true
      })

      -- Code text (=code=)
      vim.api.nvim_set_hl(0, "@org.code", {
        fg = magenta,
        bg = "#2d333b",
        bold = true
      })
      
      -- Verbatim text (~verbatim~)
      vim.api.nvim_set_hl(0, "@org.verbatim", {
        fg = magenta,
        bg = "#2d333b",
        bold = true
      })
    end

    -- Apply highlights after colorscheme loads
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = set_doom_one_org_highlights,
    })

    -- Apply highlights for org files
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "org",
      callback = function()
        vim.defer_fn(set_doom_one_org_highlights, 100)
      end,
    })

    -- Apply highlights immediately on startup
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        vim.defer_fn(set_doom_one_org_highlights, 100)
      end,
    })

  '';
}
