{ config, lib, pkgs, ... }:
{
  hardware.cpu.x86.msr.settings.allow-writes = "on";

  boot.kernelParams = [ "amd_pstate=guided" ];
  powerManagement.enable = true;
  powerManagement.cpuFreqGovernor = "schedutil";

  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };
}
