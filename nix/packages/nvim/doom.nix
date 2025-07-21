{ config, pkgs, lib, ... }:

{
  # Enable Emacs with specific version
  programs.nvim = { enable = true; };
}
