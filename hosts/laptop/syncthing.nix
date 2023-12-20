{ config, lib, pkgs, ... }:
{
  services = {
    syncthing = {
      enable = true;
      user = "jasshank";
      dataDir = "/home/jasshank/core/src/syncthing";
      settings = {
        devices = {
          "desktop" = { id = "3AQL5UC-XGBTWJX-GXASITD-QF2OIQL-56G6DDU-SSN236G-NOKM4CY-3MGBOAR";};
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
  };

  networking.firewall.allowedTCPPorts = [ 8384 22000 ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];
}
