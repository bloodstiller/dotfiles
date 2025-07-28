# Theme and appearance configuration
{ lib, pkgs, ... }: {
  vim = {
    # Uncomment to use catppuccin theme instead of doom-one
    # theme = {
    #   enable = true;
    #   name = "catppuccin";
    #   style = "mocha";
    # };
    
    # Note: Doom One theme is configured in plugins.nix and extra-lua.nix
    # All theme-related Lua configuration is in extra-lua.nix
  };
}