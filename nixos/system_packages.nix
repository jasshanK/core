{ config, pkgs, ... }: 
{
  environment.systemPackages = with pkgs; [
    # fundamentals
    htop
    unzip 
    zip
    alacritty
    starship 

    # desktop experience
    dmenu
    bluez
    pavucontrol
    brightnessctl
  ];
}
