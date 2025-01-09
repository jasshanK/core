{ pkgs, ... }: 
{
  environment.variables = {
    WEBKIT_DISABLE_DMABUF_RENDERER = "1";
  };

  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    nyxt

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
