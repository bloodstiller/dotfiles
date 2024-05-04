return {
  "akinsho/org-bullets.nvim",
  config = function()
    require("org-bullets").setup({
      concealcursor = false, -- If false then when the cursor is on a line underlying characters are visible
      symbols = {
        -- list symbol
        list = "•",
        -- headlines can be a list
        headlines = { "◉", "○", "✸", "✿" },
        -- or a function that receives the defaults and returns a list
        -- or false to disable the symbol. Works for all symbols
        checkboxes = {
          half = { "", "OrgTSCheckboxHalfChecked" },
          done = { "✓", "OrgDone" },
          todo = { "˟", "OrgTODO" },
        },
      },
    })
  end,
}
