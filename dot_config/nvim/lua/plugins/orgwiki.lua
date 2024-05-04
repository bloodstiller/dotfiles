return {
  "ranjithshegde/orgWiki.nvim",
  config = function()
    require("orgWiki").setup({
      wiki_path = { "~/Documents/Orgs/" },
      diary_path = "~/Documents/Orgs/diary/",
    })
  end,
}
