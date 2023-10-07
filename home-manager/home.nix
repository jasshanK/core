{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./neovim.nix
    ./steam.nix
    ./user_packages.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
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

  # Enable home-manager
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
