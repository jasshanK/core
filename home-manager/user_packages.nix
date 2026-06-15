{ pkgs, pkgsUnstable, ... }:
let
  nixpkgs-custom = import (/home/jasshank/nixpkgs-custom) { 
    config.allowUnfree = true;
  };
in
{
  home.packages = (with pkgs; [
   # fundamentals
   ripgrep
   gnome-disk-utility
   distrobox

   # electronics 
   pulseview
   serial-studio
   sigrok-cli
   sigrok-firmware-fx2lafw
   ngspice
   minicom
   nixpkgs-custom.kicad

   # comms
   vesktop
   slack
   telegram-desktop

   # general apps
   zotero
   evince
   drawio
   obsidian
   onlyoffice-desktopeditors

   vscode-fhs
   claude-code

   tailscale
   qbittorrent


   # media
   vlc
   audacity

   obs-studio
   gromit-mpx

   # minecraft
   prismlauncher

   (pkgs.writeShellScriptBin "browser" "exec ${pkgs.firefox}/bin/firefox \"$@\"")
   (pkgs.writeShellScriptBin "telegram" "exec ${pkgs.telegram-desktop}/bin/Telegram \"$@\"")
   (pkgs.writeShellScriptBin "discord" "exec ${pkgs.vesktop}/bin/vesktop \"$@\"")
   (pkgs.writeShellScriptBin "pdf-reader" "exec ${pkgs.evince}/bin/evince \"$@\"")
   (pkgs.writeShellScriptBin "media-player" "exec ${pkgs.vlc}/bin/vlc \"$@\"")
   (pkgs.writeShellScriptBin "media-audio" "exec ${pkgs.audacity}/bin/audacity \"$@\"")
   (pkgs.writeShellScriptBin "media-obs" "exec ${pkgs.obs-studio}/bin/obs \"$@\"")
   (pkgs.writeShellScriptBin "media-pointer" "exec ${pkgs.gromit-mpx}/bin/gromit-mpx \"$@\"")
   (pkgs.writeShellScriptBin "settings-disks" "exec ${pkgs.gnome-disk-utility}/bin/gnome-disks \"$@\"")
 ]) ++ (with pkgsUnstable; [
   easyeda2kicad
   stm32cubemx
   rkdeveloptool
   prusa-slicer
 ]);
}
