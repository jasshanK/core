{ pkgs, ... }: 
{
  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    xfce.thunar
    xfce.thunar-volman
    xfce.thunar-archive-plugin

    htop

    unzip 
    zip

    alacritty
    starship 

    fzf
    busybox 
    mlocate
    shellcheck
    nmap
  ];
}
