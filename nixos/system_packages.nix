{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # fundamentals
    alacritty
    firefox
    starship 

    # desktop experience
    dmenu
    feh
    bluez
    pavucontrol
    brightnessctl
  ];
}
