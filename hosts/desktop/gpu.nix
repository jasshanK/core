{ config, lib, pkgs, ... }:
{
  hardware.opengl.enable = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libvdpau-va-gl
    ];
  };
}


