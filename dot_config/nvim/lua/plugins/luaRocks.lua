return {
  "vhyrro/luarocks.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-neotest/nvim-nio",
    "nvim-neorg/lua-utils.nvim",
    "nvim-lua/plenary.nvim",
  },
  opts = {
    luarocks_build_args = {
      "--with-lua-include=/usr/include",
      priority = 1000,
      config = true,
    },
  },
}
