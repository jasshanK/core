{ inputs, config, pkgs, ... }:

{
  imports =
    [ 
    /etc/nixos/hardware-configuration.nix
    ./bootloader.nix
    ./power.nix
    ./gpu.nix
    ./syncthing.nix
    ./virtualisation.nix
    ./filesystem.nix
    ./../../nixos/editor.nix
    ./../../nixos/fonts.nix
    ./../../nixos/user.nix
    ./../../nixos/desktop.nix
    ./../../nixos/system_packages.nix
    ./../../nixos/steam.nix
    ./../../nixos/udev_rules.nix
    ./../../nixos/podman.nix
    ./../../nixos/nus_vpn.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      jasshank = import ./../../home-manager/home.nix;
    };
  };

  networking.hostName = "nixos";

  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Singapore";

  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_SG.UTF-8";
    LC_IDENTIFICATION = "en_SG.UTF-8";
    LC_MEASUREMENT = "en_SG.UTF-8";
    LC_MONETARY = "en_SG.UTF-8";
    LC_NAME = "en_SG.UTF-8";
    LC_NUMERIC = "en_SG.UTF-8";
    LC_PAPER = "en_SG.UTF-8";
    LC_TELEPHONE = "en_SG.UTF-8";
    LC_TIME = "en_SG.UTF-8";
  };

  services.printing.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;
  services.libinput.touchpad.disableWhileTyping = true;

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "23.05";
}
