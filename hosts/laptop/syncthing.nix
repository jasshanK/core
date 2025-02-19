{ config, lib, pkgs, ... }:
{
  services = {
    syncthing = {
      enable = true;
      user = "jasshank";
      dataDir = "/home/jasshank/core/src/syncthing";
      settings = {
        devices = {
          "desktop" = { 
            id = "HTISFCI-Y7D3CRO-6ASL3E5-K52BOAX-Z5BTZPG-Y7GY2UK-RISF7X4-USBEUAP";
          };
          "mobile" = { 
            id = "KYLZSPC-TMXWICL-E5LLABP-IN7KQQY-LAACVAZ-FHIRDCJ-45V3J57-2QAMGA5";
          };
        };
        folders = {
          "Notes" = {
            path = "/home/jasshank/notes";
            devices = [ "desktop" "mobile" ];
          };
          "Projects" = {
            path = "/home/jasshank/proj";
            devices = [ "desktop" ];
          };
          "Work" = {
            path = "/home/jasshank/work";
            devices = [ "desktop" ];
          };
          "Documents" = {
            path = "/home/jasshank/defaults/Documents/";
            devices = [ "desktop" ];
          };
        };
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 8384 22000 ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];
}
