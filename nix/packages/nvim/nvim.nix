{ pkgs, inputs, ... }:

# This just imports my nvf config into home manager to make nvim available globally without having to run from my flake.

#If using nvf for
let
  nvfNeovim = inputs.nvf.lib.neovimConfiguration {
    pkgs = pkgs;

    modules = [ ./nvf-configuration.nix ];
  };
in { home.packages = [ nvfNeovim.neovim ]; }
