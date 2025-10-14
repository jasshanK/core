{ pkgs, ... }: 
{
  services.flatpak.enable = true;

  programs.nix-ld.enable = true;
  services.envfs.enable = true;

  environment.systemPackages = with pkgs; [
    podman-compose 

    xfce.thunar
    xfce.thunar-volman
    xfce.thunar-archive-plugin

    blueberry

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
