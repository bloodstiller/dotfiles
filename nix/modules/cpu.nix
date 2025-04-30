{ config, pkgs, ... }:

{
  # Enable auto-cpufreq for better power management
  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };

  # Enable thermald for better temperature management
  services.thermald.enable = true;

  # Enable Intel P-state driver
  boot.kernelParams = [ "intel_pstate=active" ];

  # Enable microcode updates
  hardware.cpu.intel.updateMicrocode = true;

  # TLP configuration for finer power management control
  services.tlp = {
    enable = true;
    settings = {
      # CPU frequency scaling
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      
      # CPU energy/performance policies
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      # CPU boost settings
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;

      # Temperature thresholds for CPU speed throttling
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MAX_PERF_ON_BAT = 70;

      # Platform and fan control profiles
      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "quiet";
    };
  };

  # Optional: Install tools for monitoring
  environment.systemPackages = with pkgs; [
    auto-cpufreq  # For monitoring auto-cpufreq
    powertop      # For power consumption analysis
    s-tui         # Terminal UI for monitoring CPU
  ];
}
