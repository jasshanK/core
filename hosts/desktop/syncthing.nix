{ config, lib, pkgs, ... }:
{
  services = {
    syncthing = {
      enable = true;
      user = "jasshank";
      dataDir = "/home/jasshank/core/src/syncthing";
      settings = {
        devices = { 
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
            devices = [ "laptop" "mobile" ];
          };
          "Projects" = {
            path = "/home/jasshank/proj";
            devices = [ "laptop" ];
          };
          "Work" = {
            path = "/home/jasshank/work";
            devices = [ "laptop" ];
          };
          "Documents" = {
            path = "/home/jasshank/defaults/Documents/";
            devices = [ "laptop" ];
          };
        };
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 8384 22000 ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];
}
