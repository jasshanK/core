{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  pkgsUnstable = import <nixpkgs-unstable> {};
in{
  imports = [
    ./neovim.nix
    ./user_packages.nix
    #./waybar.nix
    #./notif_daemon.nix
  ];

  nixpkgs = {
    overlays = [
      
    ];

    # Configure your nixpkgs instance
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (pkg: true);
    };
  };

  home = {
    username = "jasshank";
    homeDirectory = "/home/jasshank";
  };

  xdg.userDirs = {
    enable = true;
    desktop = "/home/jasshank/defaults/Desktop";
    documents = "/home/jasshank/defaults/Documents";
    download = "/home/jasshank/defaults/Downloads";
    templates = "/home/jasshank/defaults/Templates";
    publicShare = "/home/jasshank/defaults/Public";
    music = "/home/jasshank/defaults/media/Music";
    pictures = "/home/jasshank/defaults/media/Pictures";
    videos = "/home/jasshank/defaults/media/Videos";
  };

  # Enable home-manager
  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";
  xsession.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
