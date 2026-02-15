{ pkgs, ... }:
let 
  pkgsUnstable = import <nixpkgs-unstable> {
    config.allowUnfree = true;
  };
  jan-custom = import ./jan.nix { inherit pkgs; };
in
{
  home.packages = with pkgs; [
   # fundamentals
   ripgrep
   gnome-disk-utility
   distrobox

   # electronics 
   pulseview
   serial-studio
   sigrok-cli
   sigrok-firmware-fx2lafw
   pkgsUnstable.stm32cubemx
   pkgsUnstable.kicad
   pkgsUnstable.easyeda2kicad
   ngspice
   pkgsUnstable.rkdeveloptool
   minicom

   # general apps
   tailscale
   onlyoffice-desktopeditors
   audacity
   qbittorrent
   vlc
   vesktop
   telegram-desktop
   tlaplusToolbox
   evince
   pkgsUnstable.prusa-slicer
   drawio
   obsidian
   vscode-fhs
   slack
   claude-code

   # recording 
   obs-studio
   gromit-mpx

   # minecraft
   ferium 
   prismlauncher
 ];
}

