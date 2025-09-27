{ lib, pkgs, ... }: {
  vim.utility.images.image-nvim = {
    enable = true;
    setupOpts = { backend = "ueberzug"; };
  };
}
