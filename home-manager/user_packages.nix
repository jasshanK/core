{ config, pkgs, inputs, ... }:
let 
  pkgsUnstable = import <nixpkgs-unstable> {
    config.allowUnfree = true;
  };
in
{
  home.packages = with pkgs; [
   # fundamentals
   ripgrep
   gnome.gnome-disk-utility
   distrobox

   # electronics 
   pulseview
   serial-studio
   sigrok-cli
   sigrok-firmware-fx2lafw
   pkgsUnstable.stm32cubemx
   pkgsUnstable.kicad
   xschem
   ngspice

   # general apps
   vesktop
   telegram-desktop
   tlaplusToolbox
   sioyek
   pkgsUnstable.thunderbird
   pkgsUnstable.prusa-slicer
   drawio
   obsidian
   vscode-fhs

   # recording 
   obs-studio
   gromit-mpx
 ];
}

