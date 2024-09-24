{ config, pkgs, ... }:
{
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  services.xserver = {
    enable = true;
    xkb.layout = "us";

    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false; };
    };

    displayManager = {
      lightdm = {
        enable = true;
        greeters.slick = {
          enable = true;
          theme.name = "Adwaita-dark";
        };
      };
    };

    windowManager.dwm.enable = true;
  };

  services.displayManager = {
    defaultSession = "xfce+dwm";
  };

  sound.mediaKeys.enable = true;

  services.gnome.gnome-keyring.enable = true;

  # DWM and dmenu custom build
  nixpkgs.overlays = [
    (final: prev: {
      dwm = prev.dwm.overrideAttrs (old: {
        src = ./../src/dwm;
        patches = [
          ./../src/suckless_patches/dwm-status2d-6.3.diff
        ];
      });
      dmenu = prev.dmenu.overrideAttrs (old: { 
        src = ./../src/dmenu;
      });
    })
  ];

  # status bar init
  systemd.user.services.status_bar = {
    enable = true;
    description = "service for dwm status bar";
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    path = [ pkgs.xorg.xsetroot pkgs.alsa-utils pkgs.networkmanager ];
    serviceConfig = {
      Type="simple";
      passEnvironment = "DISPLAY";
      ExecStart = "/home/jasshank/core/src/scripts/bar.sh";
      Restart = "on-failure";
    };
  };

  environment.systemPackages = with pkgs; [
    dmenu
    bluez
    pavucontrol
    brightnessctl
  ];
}

