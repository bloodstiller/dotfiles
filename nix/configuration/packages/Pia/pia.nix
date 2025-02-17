{ config, pkgs, ... }:

{
  home.file = {
    # Add PIA manual connections repo
    "Pia".source = pkgs.fetchFromGitHub {
      owner = "pia-foss";
      repo = "manual-connections";
      rev = "e956c57849a38f912e654e0357f5ae456dfd1742";  
      sha256 = "otDaC45eeDbu0HCoseVOU1oxRlj6A9ChTWTSEUNtuaI=";
    };
  };
}
