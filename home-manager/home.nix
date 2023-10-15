{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./neovim.nix
    ./firefox.nix
    ./user_packages.nix
  ];

  nixpkgs = {
    overlays = [
      
    ];

    # Configure your nixpkgs instance
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
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

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "jasshanK";
    userEmail = "jasshank@gmail.com";
  };

  systemd.user.startServices = "sd-switch";
  xsession.enable = true;

  home.stateVersion = "23.05";
}
