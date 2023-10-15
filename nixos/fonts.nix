{ config, lib, pkgs, ... }:
{
  fonts = {
    fonts = with pkgs; [
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
