-- lazy.nvim spec
local M = {
  "nvim-neorg/neorg",
  ft = "norg",
  dependencies = {
    "luarocks.nvim", -- this is it.
    -- "nvim-treesitter/nvim-treesitter",
    -- "nvim-treesitter/nvim-treesitter-textobjects",
    -- "nvim-cmp",
    -- "nvim-lua/plenary.nvim",
  },
  cmd = "Neorg",
}
local modules = {
  ["core.defaults"] = {},
  ["core.completion"] = { config = { engine = "nvim-cmp", name = "[Norg]" } },
  ["core.integrations.nvim-cmp"] = {},
  ["core.concealer"] = { config = { icon_preset = "diamond" } },
  ["core.keybinds"] = {
    -- https://github.com/nvim-neorg/neorg/blob/main/lua/neorg/modules/core/keybinds/keybinds.lua
    config = {
      default_keybinds = true,
      neorg_leader = "<Leader><Leader>",
    },
  },
  ["core.dirman"] = {
    config = {
      workspaces = {
        ZK = "~/Dropbox/40-49_Career/40-Career-ZK",
        Work = "~/Dropbox/60-69_Work/60-Work_ZK",
      },
      default_workspace = "ZK",
    },
  },
}
M.opts = {
  load = modules,
}
return M
