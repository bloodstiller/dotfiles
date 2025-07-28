{ lib, pkgs, ... }: {
  vim.formatter = {
    conform-nvim = {
      enable = true;
      setupOpts = {
        formatters_by_ft = {
          markdown = [ "prettier" ];
          json = [ "prettier" ];
          yaml = [ "prettier" ];
          lua = [ "stylua" ];
          nix = [ "nixfmt" ];
          python = [ "black" ];
          javascript = [ "prettier" ];
          typescript = [ "prettier" ];
        };
        format_on_save = {
          lsp_format = "fallback";
          timeout_ms = 1000;
        };
      };
    };
  };
}
