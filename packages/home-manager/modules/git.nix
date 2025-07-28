{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "bloodstiller";
    userEmail = "bloodstiller@bloodstiller.com";
    
    signing = {
      key = null;
      signByDefault = false;
      format = "ssh";
    };
    
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
      core.editor = "vim";
      credential.helper = "store";
    };
    
    # Uncomment and modify when needed
    #includes = [{ ... }];
  };
} 