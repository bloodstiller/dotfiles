# Plugin setup and configuration
{ lib, pkgs, ... }: {
  vim.luaConfigRC.pluginConfigs = ''
     --Org
     require("orgmode").setup({})
     require("org-bullets").setup()

     local Menu = require("org-modern.menu")
     require("orgmode").setup({
       ui = {
         menu = {
           handler = function(data)
             Menu:new():open(data)
           end,
         },
       },
     })

    --NeoTree
    -- Also provides keyboard shortcut tab for expanding nodes
    require("neo-tree").setup({
      window = {
        mappings = {
          ["<Tab>"] = "toggle_node",
          ["<CR>"] = "open", -- Keep Enter for opening files 
        }
      }
    })


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

     --Img clip settings 
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
  '';
}

