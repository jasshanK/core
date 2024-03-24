{ inputs, config, pkgs, ... }:
{
  fileSystems."/storage" = { 
    device = "/dev/disk/by-uuid/415912ce-4ddd-465b-a847-5148885c1330";
    fsType = "ext4";
  };
}
