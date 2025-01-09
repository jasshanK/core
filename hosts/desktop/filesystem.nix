{ ... }:
{
  fileSystems."/storage" = { 
    device = "/dev/disk/by-uuid/415912ce-4ddd-465b-a847-5148885c1330";
    fsType = "ext4";
  };

  fileSystems."/storage_ssd" = { 
    device = "/dev/disk/by-uuid/7992f661-ad11-427b-8b60-8b059483e38f";
    fsType = "ext4";
  };
}
