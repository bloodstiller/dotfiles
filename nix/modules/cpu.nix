{ config, pkgs, ... }:

{
  # Remove power-profiles-daemon and use TLP instead
  # services.power-profiles-daemon.enable = true;  # Removing this line

  powerManagement = {
    cpuFreqGovernor = "performance";
    powertop.enable = true;
  };

  services.thermald.enable = true;

  boot.kernelParams = [ "intel_pstate=active" ];

  hardware.cpu.intel.updateMicrocode = true;

  # TLP for better laptop power management
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
    };
  };
}
