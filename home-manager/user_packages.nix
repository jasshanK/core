{ config, pkgs, ... }:
let 
 # unstable = import (
 #   builtins.fetchTarball {
 #     url = "https://github.com/NixOS/nixpkgs/archive/ea6e5c07302b8a574fbeef6e0e8d6be53a154f38.tar.gz";
 #     sha256 = "1blcplhib5l1pszdjxxszjkmz9hcxzzgxmmgiz3cah84l5l0drqq";
 #   })

 #   { config = config.nixpkgs.config; };

  pkgsUnstable = import <nixpkgs-unstable> {};

in
{
 home.packages = with pkgs; [
   # fundamentals
   htop 
   git
   nushell
   neofetch
   ripgrep
   unzip
   zip

   # electronics 
   pulseview
   sigrok-cli
   sigrok-firmware-fx2lafw
   stm32cubemx
   kicad

   # general apps
   vscode-fhs
   pkgsUnstable.prusa-slicer
   drawio
   telegram-desktop 
   whatsapp-for-linux
   obsidian
   weylus
 ];
}

