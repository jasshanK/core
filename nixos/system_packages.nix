{ pkgs, ... }: 
{
  services.flatpak.enable = true;

  programs.nix-ld.enable = true;
  services.envfs.enable = true;

  documentation.dev.enable = true;

  hardware.bluetooth.enable = true;

  services.tailscale.enable = true;
  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.package = pkgs.mullvad-vpn;
  services.resolved.enable = true;
  networking.firewall.checkReversePath = "loose";

  environment.systemPackages = with pkgs; [
    podman-compose 

    blueberry
    pavucontrol
    brightnessctl

    htop

    unzip 
    zip

    alacritty
    starship 
    xclip

    fzf
    busybox 
    mlocate
    shellcheck
    nmap

    (pkgs.writeShellScriptBin "settings-sound" "exec ${pkgs.pavucontrol}/bin/pavucontrol \"$@\"")
    (pkgs.writeShellScriptBin "settings-bluetooth" "exec ${pkgs.blueberry}/bin/blueberry \"$@\"")
    (pkgs.writeShellScriptBin "settings-display" "exec ${pkgs.xfce.xfce4-settings}/bin/xfce4-display-settings \"$@\"")
  ];
}
