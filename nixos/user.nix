{ config, lib, pkgs, ... }:
{
  users.users.jasshank = {
    name = "jasshank";
    home = "/home/jasshank";
    isNormalUser = true;
    description = "Jasshan Kumeresh";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
  };
}
