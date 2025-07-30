# Plugin setup and configuration
{ lib, pkgs, ... }: {
  vim.luaConfigRC.pluginConfigs = ''
    --Org
    require("orgmode").setup({
        org_agenda_files = "/home/martin/Dropbox/01-09_System/01-Emacs/01.02-OrgGtd/*.org",
        org_default_notes_file = "/home/martin/Dropbox/01-09_System/01-Emacs/01.02-OrgGtd/inbox.org",
        org_hide_emphasis_markers = true,
        org_startup_indented = true,
        org_edit_src_content_indentation = 2,
     })

         -- Set conceallevel for org files
         vim.api.nvim_create_autocmd('FileType', {
             pattern = 'org',
             callback = function()
                 vim.opt_local.conceallevel = 2
             end,
         })

         require("org-bullets").setup()

         --Org-Modern
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

        --Org-Roam 
        --Works but seeing if I can replace with normal relative links to 
        --require("org-roam").setup({
        --  directory = "/home/martin/Dropbox/40-49_Career/40-Career-ZK",
        --  org_files = {
        --    "/home/martin/Dropbox/40-49_Career/40-Career-ZK/*.org",
        --    },
        --  database = { 
        --    path = "/home/martin/Nextcloud/Dropbox/40-49_Career/40-Career-ZK/db", 
        --    persist = true,
        --    update_on_save = true,
        --  }
        --})

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

        --Blink config 
        require('blink.cmp').setup({
          sources = {
            per_filetype = {
              org = {'orgmode'}
            },
            providers = {
              orgmode = {
                name = 'Orgmode',
                module = 'orgmode.org.autocompletion.blink',
                fallbacks = { 'buffer' },
              },
            },
          },
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

