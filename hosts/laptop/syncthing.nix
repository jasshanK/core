{ config, lib, pkgs, ... }:
{
  services = {
    syncthing = {
      enable = true;
      user = "jasshank";
      configDir = "/home/jasshank/core/src/syncthing";
      devices = {
        "desktop" = { id = "2CSAWIN-4JSSK5T-CWWZ3TM-GORWFJU-UQTFDYY-X7ITTDH-62D4DH6-MJZZMA5";};
      };
      folders = {
        "Projects" = {
          path = "/home/jasshank/proj";
          devices = [ "desktop" ];
        };
        "Work" = {
          path = "/home/jasshank/work";
          devices = [ "desktop" ];
        };
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 8384 22000 ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];
}
