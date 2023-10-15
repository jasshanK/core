{ config, pkgs, ... }:
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

   # electronics 
   pulseview
   sigrok-cli
   sigrok-firmware-fx2lafw
   pkgsUnstable.stm32cubemx
   kicad

   # general apps
   vscode-fhs
   pkgsUnstable.prusa-slicer
   drawio
   telegram-desktop 
   whatsapp-for-linux
   obsidian
 ];
}

