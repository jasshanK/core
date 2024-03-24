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
   kicad
   xschem
   ngspice

   # general apps
   pkgsUnstable.thunderbird
   vscode-fhs
   pkgsUnstable.prusa-slicer
   drawio
   obsidian
   sioyek
   ferdium
   pkgsUnstable.lapce

   # recording 
   obs-studio
   gromit-mpx
 ];
}

