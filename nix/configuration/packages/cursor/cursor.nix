# Create this file at /etc/nixos/packages/cursor.nix
{pkgs, ...}: let
  pname = "cursor";
  version = "0.45.11";

  src = pkgs.fetchurl {
    url = "https://downloader.cursor.sh/linux/appImage/x64";
    hash = "sha256-kpS4YHlv9C3e7Em4yCl4YS9nNgNNpMsSyXmMlT29hCI=";
  };
  appimageContents = pkgs.appimageTools.extract {inherit pname version src;};
in
  with pkgs;
    appimageTools.wrapType2 {
      inherit pname version src;

      extraInstallCommands = ''
        install -m 444 -D ${appimageContents}/${pname}.desktop -t $out/share/applications
        substituteInPlace $out/share/applications/${pname}.desktop \
          --replace-quiet 'Exec=AppRun' 'Exec=${pname}'
        cp -r ${appimageContents}/usr/share/icons $out/share

        if [ -e ${appimageContents}/AppRun ]; then
          install -m 755 -D ${appimageContents}/AppRun $out/bin/${pname}-${version}
          if [ ! -L $out/bin/${pname} ]; then
            ln -s $out/bin/${pname}-${version} $out/bin/${pname}
          fi
        else
          echo "Error: Binary not found in extracted AppImage contents."
          exit 1
        fi
      '';

      extraBwrapArgs = [
        "--bind-try /etc/nixos/ /etc/nixos/"
      ];

      dieWithParent = false;

      extraPkgs = pkgs: [
        unzip
        autoPatchelfHook
        asar
        (buildPackages.wrapGAppsHook.override {inherit (buildPackages) makeWrapper;})
      ];
    } 