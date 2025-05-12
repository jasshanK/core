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
          "cube" = { 
            id = "2XFBDKJ-FUIVJHU-667BKO5-DOUDLBK-TIAIBMY-7HE5APC-3VIEQUL-QC6SCQA";
          };
        };
        folders = {
          "Notes" = {
            path = "/home/jasshank/notes";
            devices = [ "desktop" "mobile" "cube" ];
          };
          "Projects" = {
            path = "/home/jasshank/proj";
            devices = [ "desktop" "cube" ];
          };
          "Work" = {
            path = "/home/jasshank/work";
            devices = [ "desktop" "cube" ];
          };
          "Documents" = {
            path = "/home/jasshank/defaults/Documents/";
            devices = [ "desktop" "cube" ];
          };
        };
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 8384 22000 ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];
}
