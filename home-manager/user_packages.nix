{ pkgs, ... }:
let 
  pkgsUnstable = import <nixpkgs-unstable> {
    config.allowUnfree = true;
  };
  jan-beta = import ./jan.nix { inherit pkgs; };
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
   ngspice

   # general apps
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
   jan-beta

   # recording 
   obs-studio
   gromit-mpx

   # minecraft
   ferium 
   prismlauncher
 ];
}

