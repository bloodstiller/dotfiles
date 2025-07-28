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

  # Enable undervolting for better thermal performance and power consumption
  services.undervolt = {
    enable = true;
    # Voltage offsets in mV CORE AND CACHE VALUES MUST MATCH
    coreOffset = -50; # CPU core voltage offset (also affects cache)
    # gpuOffset = -50;   # GPU voltage offset (uncomment if needed)
    # uncoreOffset = -50;# Uncore voltage offset (uncomment if needed)
    # analogioOffset = -50;# Analog I/O voltage offset (uncomment if needed)
  };

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
      CPU_MAX_PERF_ON_AC = 95;
      CPU_MAX_PERF_ON_BAT = 70;

      # Platform and fan control profiles
      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "quiet";

      # Set the min/max/turbo frequency for the Intel GPU. Possible values depend on your hardware.
      # See the output of tlp-stat -g for available frequencies.
      # On AC: prioritize performance
      INTEL_GPU_MIN_FREQ_ON_AC = 600;
      INTEL_GPU_MAX_FREQ_ON_AC = 1200;
      # On Battery: prioritize battery life without killing responsiveness
      INTEL_GPU_MIN_FREQ_ON_BAT = 350;
      INTEL_GPU_MAX_FREQ_ON_BAT = 600;
    };
  };

  # Optional: Install tools for monitoring
  environment.systemPackages = with pkgs; [
    auto-cpufreq # For monitoring auto-cpufreq
    powertop # For power consumption analysis
    s-tui # Terminal UI for monitoring CPU
    stress # Used with s-tui for stressing
    undervolt # Used to undervolt system
    acpi # Advanced Configuration & Power
  ];
}
