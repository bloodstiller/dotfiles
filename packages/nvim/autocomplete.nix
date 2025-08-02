# Autocomplete
# Autocomplete
{ lib, pkgs, ... }: {
  vim.autocomplete.blink-cmp.sourcePlugins = {
    spell.enable = true;
    emoji.enable = true;

    # Enable spellcheck only for specific file types
    vim.autocmd = [{
      event = "FileType";
      pattern = [ "markdown" "org" ];
      command = "setlocal spell spelllang=en_us";
    }];
  };

}
