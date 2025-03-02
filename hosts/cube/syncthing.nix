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
          "laptop" = { 
            id = "KMWIVTC-G5CMA6D-QITJ7BD-XI7UK63-L2BPQHR-5QY3H2T-V2SBCGN-5ROORAO";
          };
          "mobile" = { 
            id = "KYLZSPC-TMXWICL-E5LLABP-IN7KQQY-LAACVAZ-FHIRDCJ-45V3J57-2QAMGA5";
          };
        };
        folders = {
          "Notes" = {
            path = "/home/jasshank/notes";
            devices = [ "desktop" "laptop" "mobile" ];
          };
          "Projects" = {
            path = "/home/jasshank/proj";
            devices = [ "desktop" "laptop" ];
          };
          "Work" = {
            path = "/home/jasshank/work";
            devices = [ "desktop" "laptop" ];
          };
          "Documents" = {
            path = "/home/jasshank/defaults/Documents/";
            devices = [ "desktop" "laptop" ];
          };
        };
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 8384 22000 ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];
}
