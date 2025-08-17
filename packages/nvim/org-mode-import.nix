# Main org-mode configuration that imports all sub-modules
{ lib, pkgs, ... }: {
  imports = [
    ./org-mode/org-mode-core.nix
    ./org-mode/org-mode-appearance.nix
    ./org-mode/org-mode-keymaps.nix
    ./org-mode/org-mode-roam.nix
    ./org-mode/org-mode-refile.nix
    ./org-mode/org-mode-screenshots.nix
    ./org-mode/org-mode-export.nix
    ./org-mode/org-mode-utilities.nix
  ];
}
