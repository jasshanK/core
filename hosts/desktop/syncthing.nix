{ config, lib, pkgs, ... }:
{
  services = {
    syncthing = {
      enable = true;
      user = "jasshank";
      configDir = "/home/jasshank/core/src/syncthing";
      devices = {
        "laptop" = { id = "H5PI3OS-MUU6E3A-XJBTOUC-G3CVGN5-NX7TFT6-RKC65SY-KQJD275-MU3NPQS";};
      };
      folders = {
        "Projects" = {
          path = "/home/jasshank/proj";
          devices = [ "laptop" ];
        };
        "Work" = {
          path = "/home/jasshank/work";
          devices = [ "laptop" ];
        };
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 8384 22000 ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];
}
