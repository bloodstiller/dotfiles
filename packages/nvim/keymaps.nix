# Keymap configuration
{ lib, pkgs, ... }: {
  vim.keymaps = [
    # I do not use these instead I have my keymaps defined using pure lua.
    # All keymaps are now defined in extra-lua.nix for consistency
    # You can uncomment and move these here if you prefer nix-style keymaps:

    # {
    #   key = "<leader>t";
    #   mode = "n";
    #   action = "<cmd>Neotree toggle<CR>";
    # }
    # {
    #   key = "<leader>ff";
    #   mode = "n";
    #   silent = true;
    #   action = ":Telescope find_files<CR>";
    # }
    # {
    #   key = "<leader>fg";
    #   mode = "n";
    #   silent = true;
    #   action = ":Telescope live_grep<CR>";
    # }
    # {
    #   key = "<C-s>";
    #   mode = "i";
    #   action = "<Esc>:w<CR>";
    # }
    # { # Vertical split: <leader>ws
    #   key = "<leader>ws";
    #   mode = "n";
    #   action = ":vsplit<CR>";
    # }
    # { # Horizontal split: <leader>wh
    #   key = "<leader>wh";
    #   mode = "n";
    #   action = ":split<CR>";
    # }
    # { # Close window
    #   key = "<leader>wx";
    #   mode = "n";
    #   action = ":close<CR>";
    # }
    # { # New empty window
    #   key = "<leader>wn";
    #   mode = "n";
    #   action = ":new<CR>";
    # }
  ];
}

