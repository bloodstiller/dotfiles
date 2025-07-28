# Markdown-specific configuration and markview setup
{ lib, pkgs, ... }: {
  vim.luaConfigRC.markdownConfig = ''
    -- Enhanced markview configuration for better spacing and organization
    require("markview").setup({
      preview = {
        modes = { "n", "no", "c" },
        hybrid_modes = { "n" }
      },

      markdown = {
        list_items = {
          enable = true,
          indent_size = 2,
          shift_width = 2,
          marker_minus = {
            text = "·",
            hl = "MarkviewListItemMinus"
          },
        },

        code_blocks = {
          enable = true,
          style = "language",
          language_direction = "right",
          min_width = 60,
          pad_amount = 2,
        },

        emphasis = {
          enable = true,
          hl = "MarkviewItalic"
        },
        strong = {
          enable = true,
          hl = "MarkviewBold"
        }
      },

      code_blocks = {
        enable = true,
        style = "simple",
        border_hl = "MarkviewCodeBlockBorder",
        pad_amount = 1,
      },

      inline_codes = {
        enable = true,
        hl = "MarkviewInlineCode",
        padding_left = 1,
        padding_right = 1,
      }
    })

    -- Enhanced highlight configuration for better visual organization
    local function set_doom_one_markdown_highlights()
      -- Doom One color palette
      local blue = "#51afef"
      local magenta = "#c678dd"
      local teal = "#4db5bd"
      local cyan = "#46D9FF"
      local violet = "#a9a1e1"
      local dark_cyan = "#5699AF"
      local bg = "#282c34"
      local bg_alt = "#21242b"
      local base5 = "#5B6268"

      -- Headings with different colors per level and better backgrounds
      vim.api.nvim_set_hl(0, "MarkviewHeading1", {
        fg = blue,
        bold = true,
        bg = "#2a3441",
        italic = false
      })
      vim.api.nvim_set_hl(0, "MarkviewHeading2", {
        fg = magenta,
        bold = true,
        bg = "#332a3d",
        italic = false
      })
      vim.api.nvim_set_hl(0, "MarkviewHeading3", {
        fg = teal,
        bold = true,
        bg = "#2a3d37",
        italic = false
      })
      vim.api.nvim_set_hl(0, "MarkviewHeading4", {
        fg = cyan,
        bold = true,
        bg = "#2a3a41",
        italic = false
      })
      vim.api.nvim_set_hl(0, "MarkviewHeading5", {
        fg = violet,
        bold = true,
        bg = "#35314a",
        italic = false
      })
      vim.api.nvim_set_hl(0, "MarkviewHeading6", {
        fg = dark_cyan,
        bold = true,
        bg = "#2e3541",
        italic = false
      })

      -- Better code styling
      vim.api.nvim_set_hl(0, "MarkviewInlineCode", {
        fg = "#c678dd",
        bg = "#2d333b",
        bold = true
      })
      vim.api.nvim_set_hl(0, "MarkviewCodeBlock", {
        bg = "#1a1e23"
      })
      vim.api.nvim_set_hl(0, "MarkviewCodeBlockBorder", {
        fg = base5,
        bg = "#1a1e23"
      })

      -- Better text formatting
      vim.api.nvim_set_hl(0, "MarkviewBold", { fg = "#c5cdd8", bold = true })
      vim.api.nvim_set_hl(0, "MarkviewItalic", { fg = "#b18c00", bold = true })
      vim.api.nvim_set_hl(0, "MarkviewStrike", {
        fg = "#FF6c6b",
        bold = true,
        italic = true,
        underline = true,
        strikethrough = false
      })

      -- List markers
      vim.api.nvim_set_hl(0, "MarkviewListItemMinus", { fg = teal, bold = true })

      -- Links
      vim.api.nvim_set_hl(0, "MarkviewLink", { fg = blue, underline = true })
      vim.api.nvim_set_hl(0, "MarkviewLinkText", { fg = cyan })

      -- Fallback highlights for inline code and basic markup
      vim.api.nvim_set_hl(0, "@markup.strong", { fg = "#c5cdd8", bold = true })
      vim.api.nvim_set_hl(0, "@markup.italic", { fg = "#b18c00", bold = true })
      vim.api.nvim_set_hl(0, "@markup.raw.markdown_inline", { fg = "#c678dd", bg = "#2d333b", bold = true })
      vim.api.nvim_set_hl(0, "@markup.strikethrough", {
        fg = "#FF6c6b",
        bold = true,
        italic = true,
        underline = true,
        strikethrough = false
      })
    end

    -- Apply highlights after colorscheme loads
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = set_doom_one_markdown_highlights,
    })

    -- CONSOLIDATED FileType autocmd for markdown
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        -- Apply highlights
        vim.defer_fn(set_doom_one_markdown_highlights, 100)

        -- Better line spacing and typography
        vim.opt_local.linespace = 2

        -- Enhanced wrapping and indentation
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.breakindent = true
        vim.opt_local.breakindentopt = "shift:2,min:20,sbr"
        vim.opt_local.showbreak = "  ↳ "

        -- Better visual spacing and concealment
        vim.opt_local.conceallevel = 2
        vim.opt_local.concealcursor = "nc"

        -- Add folding support
        vim.opt_local.foldmethod = "expr"
        vim.cmd("setlocal foldexpr=getline(v:lnum)=~'^#'?'>'.len(matchstr(getline(v:lnum),'^#*')):'='")
        vim.opt_local.foldlevelstart = 0

        -- Improved scrolling and cursor
        vim.opt_local.smoothscroll = true
        vim.opt_local.scrolloff = 8
        vim.opt_local.cursorline = true

        -- Better movement on wrapped lines
        vim.keymap.set('n', 'j', 'gj', { buffer = true })
        vim.keymap.set('n', 'k', 'gk', { buffer = true })
        vim.keymap.set('n', '0', 'g0', { buffer = true })
        vim.keymap.set('n', '$', 'g$', { buffer = true })
      end,
    })

    -- Apply highlights immediately on startup
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        vim.defer_fn(set_doom_one_markdown_highlights, 100)
      end,

      })

  '';
}
