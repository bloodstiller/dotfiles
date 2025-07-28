# Language-specific configuration
{ lib, pkgs, ... }: {
  vim.languages = {
    enableTreesitter = true;

    nix = {
      enable = true;
      treesitter.enable = true;
    };

    php = {
      enable = true;
      treesitter.enable = true;
    };

    python = {
      enable = true;
      treesitter.enable = true;
    };

    bash = {
      enable = true;
      treesitter.enable = true;
    };

    markdown = {
      enable = true;
      extensions = { markview-nvim.enable = true; };
      treesitter.enable = true;
      lsp.enable = true;
    };

    # This is javascript
    ts = {
      enable = true;
      treesitter.enable = true;
    };

    lua = {
      enable = true;
      treesitter.enable = true;
    };

    yaml = {
      enable = true;
      treesitter.enable = true;
    };

    html = {
      enable = true;
      treesitter.enable = true;
    };

    css = {
      enable = true;
      treesitter.enable = true;
    };

    sql = {
      enable = true;
      treesitter.enable = true;
    };

    go = {
      enable = true;
      treesitter.enable = true;
    };

    rust = {
      enable = true;
      treesitter.enable = true;
    };

    java = {
      enable = true;
      treesitter.enable = true;
    };
  };
}

