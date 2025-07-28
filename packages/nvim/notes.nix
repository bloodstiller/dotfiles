{ lib, pkgs, ... }: {
  vim.notes = {
    obsidian.enable = true;
    obsidian.setupOpts = {
      completion.vim_cmp = true;
      daily_notes.folder =
        "~/Dropbox/50-59_PersonalDevelopment/51-Diaries/51.01-Daily_Diaries/";
      workspaces = [{
        name = "Main";
        path = "~/Dropbox/40-49_Career/40-Career-ZK/";
      }];
    };
  };
}
