{ config, lib, pkgs, ... }:
{
  fonts = {
    packages = [
       pkgs.nerd-fonts.fira-mono
    ];

    fontconfig = {
      defaultFonts = {
        monospace = [ "FiraMono" ];
      };
    };

    fontDir.enable = true;
  };
}
