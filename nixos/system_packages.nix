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
    xfce.xfce4-clipman-plugin
    dmenu
    bluez
    pavucontrol
    brightnessctl
  ];
}
