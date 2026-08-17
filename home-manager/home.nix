{
  pkgs,
  pkgsUnstable,
  ...
}:
{
  imports = [
    ./neovim.nix
    ./firefox.nix
    ./dunst.nix
    ./user_packages.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
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

  gtk = {
    enable = true;
    theme = {
      name = "Colloid-Dark";
      package = pkgs.colloid-gtk-theme;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  programs.git = {
    enable = true;
    settings.user = {
      name = "jasshanK";
      email = "jasshank@gmail.com";
    };
    lfs.enable = true;
  };

  systemd.user.startServices = "sd-switch";
  xsession.enable = true;

  home.stateVersion = "23.11";
}
