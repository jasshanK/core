{ config, lib, pkgs, ... }:
{
  services = {
    syncthing = {
      enable = true;
      user = "jasshank";
      configDir = "/home/jasshank/core/src/syncthing";
      devices = {
        "device1" = { id = "";};
      };
      folders = {
        "Projects" = {
          path = "/home/jasshank/proj";
          devices = [ "device1" ];
        };
        "Work" = {
          path = "/home/jasshank/work";
          devices = [ "device1" ];
        };
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 8384 22000 ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];
}
