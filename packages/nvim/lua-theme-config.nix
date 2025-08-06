# Theme configuration and colorscheme setup
{ lib, pkgs, ... }: {
  vim.luaConfigRC.themeConfig = ''
    -- Doom One Theme Configuration
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

     -- Custom org-mode code block styling
     vim.api.nvim_set_hl(0, "@org.block", {
       bg = "#1b2229",  -- Darker background (adjust hex color as needed)
     })
     

  '';
}

