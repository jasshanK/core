{ config, pkgs, inputs, ... }:
let 
  pkgsUnstable = import <nixpkgs-unstable> {
    config.allowUnfree = true;
  };
in
{
  home.packages = with pkgs; [
   # fundamentals
   nushell
   neofetch
   ripgrep
   gnome.gnome-disk-utility

   # electronics 
   pulseview
   serial-studio
   sigrok-cli
   sigrok-firmware-fx2lafw
   stm32cubemx
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

   # recording 
   obs-studio
   gromit-mpx
 ];
}

