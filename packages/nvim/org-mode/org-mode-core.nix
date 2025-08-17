# Core org-mode configuration and setup
{ lib, pkgs, ... }: {
  vim.luaConfigRC.orgModeCore = ''
    -- Main Org Mode Configuration
    require("orgmode").setup({
      org_agenda_files = "/home/martin/Org/01-Emacs/01.02-OrgGtd/*.org",
      org_default_notes_file = "/home/martin/Org/01-Emacs/01.02-OrgGtd/inbox.org",
      org_hide_emphasis_markers = true,
      org_startup_indented = true,
      org_edit_src_content_indentation = 2,

      -- Optimized TODO keywords for doom-one
      org_todo_keywords = {'TODO', 'NEXT', 'WAITING', '|', 'DONE', 'DELEGATED', 'CANCELED'},
      org_todo_keyword_faces = {
        TODO = ':foreground #ff6c6b :weight bold',
        NEXT = ':foreground #51afef :weight bold', 
        WAITING = ':foreground #ECBE7B :weight bold',
        DONE = ':foreground #98be65',
        DELEGATED = ':foreground #c678dd :slant italic',
        CANCELED = ':foreground #5B6268 :slant italic',
      },
      
      -- Better agenda layout for readability
      win_split_mode = 'horizontal',
      org_agenda_span = 'week',
      org_deadline_warning_days = 7,
    })

    -- Org-Modern menu integration
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

    -- Blink.cmp configuration for orgmode
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
  '';
}
