{ config, pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.xserver = {
    enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };

  environment.systemPackages = with pkgs; [
    (waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      })
      )
    kitty

    mako
    libnotify

    networkmanagerapplet

    swww

    rofi-wayland
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  #services.xserver = {
  #  enable = true;
  #  layout = "us";
  #  xkbVariant = "";
  #  desktopManager = {
  #    xterm.enable = false;
  #    xfce = {
  #      enable = true;
  #      noDesktop = true;
  #      enableXfwm = false;
  #    };

  #    wallpaper.combineScreens = false;
  #    wallpaper.mode = "fill";
  #  };

  #  displayManager.defaultSession = "xfce+dwm";

  #  windowManager.dwm.enable = true;
  #};

  ## DWM and dmenu custom build
  #nixpkgs.overlays = [
  #  (final: prev: {
  #    dwm = prev.dwm.overrideAttrs (old: {
  #      src = ./../src/dwm;
  #      patches = [
  #        ./../src/suckless_patches/dwm-status2d-6.3.diff
  #      ];
  #    });
  #    dmenu = prev.dmenu.overrideAttrs (old: { 
  #      src = ./../src/dmenu;
  #    });
  #  })
  #];
  ## status bar init
  #systemd.user.services.status_bar = {
  #  enable = true;
  #  description = "service for dwm status bar";
  #  wantedBy = [ "graphical-session.target" ];
  #  after = [ "graphical-session.target" ];
  #  path = [ pkgs.xorg.xsetroot pkgs.alsa-utils];
  #  serviceConfig = {
  #    Type="simple";
  #    passEnvironment = "DISPLAY";
  #    ExecStart = "/home/jasshank/scripts/bar.sh";
  #    Restart = "on-failure";
  #  };
  #};
}

