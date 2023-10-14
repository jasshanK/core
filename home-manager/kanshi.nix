{ config, lib, pkgs, ... }:
{
  services.kanshi = {
    enable = true;
    systemdTarget = "default.target";
    profiles = {
      undocked = {
        outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            scale = 1.25;
          }
        ];
      };

      dual_docked = {
        outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "DP-1";
            mode = "1920x1080";
            position = "0,250";
          }
          {
            criteria = "HDMI-A-1";
            mode = "1920x1080";
            position = "1920,0";
            transform = "90";
          }
        ];
      };
    };
  };
}
