{ config, pkgs, ... }: 
{
  imports = [
    #./picoscope/picoscope.nix
  ];

  environment.systemPackages = with pkgs; [
    # fundamentals
    alacritty
    firefox
    starship 

    # desktop experience
    dmenu
    bluez
    pavucontrol
    brightnessctl
  ];

}
