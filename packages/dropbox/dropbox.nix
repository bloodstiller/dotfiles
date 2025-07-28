{ pkgs, ... }:

{
  home.packages = with pkgs; [
    dropbox
  ];

  # Service Configuration
  systemd.user.services.dropbox = {
    Unit = {
      Description = "Dropbox service";
      After = ["graphical-session.target"];
      PartOf = ["graphical-session.target"];
    };
    Install = {
      WantedBy = ["graphical-session.target"];
    };
    Service = {
      Type = "forking";
      ExecStart = "${pkgs.dropbox}/bin/dropbox start";
      ExecStop = "${pkgs.dropbox}/bin/dropbox stop";
      Environment = [
        "DISPLAY=:0"
        "QT_PLUGIN_PATH=/run/current-system/sw/${pkgs.qt5.qtbase.qtPluginPrefix}"
      ];
      Restart = "on-failure";
      RestartSec = 1;
      # Prevent multiple instances
      KillMode = "process";
      TimeoutStopSec = 20;
    };
  };

}
