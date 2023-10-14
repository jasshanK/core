{ inputs, config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./desktop.nix
    ./system_packages.nix
    ./steam.nix
    ./platformio_udev.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      jasshank = import ./../home-manager/home.nix;
    };
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking (wireless)
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Singapore";

  # Select internationalisation properties.
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

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jasshank = {
    name = "jasshank";
    home = "/home/jasshank";
    isNormalUser = true;
    description = "Jasshan Kumeresh";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = with pkgs; [
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # bash customization 
  programs.direnv = {
    enable = true;
  };

  environment.interactiveShellInit = ''
    eval "$(starship init bash)"
  '';

  # power management 
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };

  # set editor 
  environment.variables.EDITOR = "nvim";

  programs.tmux = {
    enable = true;
    extraConfig = ''
      unbind C-b
      set-option -g prefix C-e
      bind-key C-e send-prefix

      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      set -g mouse on

      set-option -g allow-rename off

      bind-key c new-window -c '#{pane_current_path}'
      bind-key '"' split-window -c '#{pane_current_path}'
      bind-key % split-window -h -c '#{pane_current_path}'

      set-option -g history-limit 20000
    '';
  };

  # fonts
  fonts = {
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraMono" ]; })
    ];

    fontconfig = {
      defaultFonts = {
        monospace = [ "FiraMono" ];
      };
    };

    fontDir.enable = true;
  };

  # Open ports in the firewall.
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 1701 9001 ];
  };

  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [ virt-manager ];

  system.stateVersion = "23.05";
}
