{ config, pkgs, ... }: 
{
  environment.systemPackages = with pkgs; [
    htop

    unzip 
    zip

    alacritty
    starship 
    fzf
    busybox 
    nmap
  ];

  services.softether = {
      enable = true;
      vpnclient.enable = true;
  };
}
