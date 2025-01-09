{ config, lib, pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraMono" ]; })
    ];

    fontconfig = {
      defaultFonts = {
        monospace = [ "FiraMono" ];
      };
    };

    fontDir.enable = true;
  };
}
