{ config, pkgs, inputs, ... }:

{  
  # set bootloader
  boot = {
    cleanTmpDir = true;
    loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
    };
  };
  
  # set network
  networking = {
    networkmanager.enable = true;
  };

  # set local
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # setup xserver
  services.xserver = {
    enable = true;
    displayManager.gdm = {
        enable = true;
        wayland = true;
    };

    desktopManager.gnome = {
        enable = true;
    };

    displayManager.autoLogin = {
        enable = true;
        user = "gregb";
    };

    xkb = {
        layout = "us";
        variant = "";
    };
  };

  # enable printing
  services.printing.enable = true;

  # enable sound
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.gregb = {
    isNormalUser = true;
    description = "Greg Buehler";
    extraGroups = [ "networkmanager" "wheel" "input" "podman" "docker"];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # set nix
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # podman
  virtualisation = {
    containers.enable = true;

    ## podman has issues with kind and delegation, regress to docker for now
    # podman = {
    #   enable = true;

    #   # create docker aliases so it's a drop in replacement
    #   dockerCompat = true;

    #   # allow containers to resolve eachother
    #   defaultNetwork.settings.dns_enabled = true;
    # };

    docker = {
      enable = true;
      storageDriver = "overlay2";
      rootless = {
        enable = false;
        setSocketVariable = true;
      };
    };
  };

  programs.streamdeck-ui.enable = true;
  programs.firefox.enable = true;
  
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    neovim
    alacritty
    btop
    podman
    podman-compose
    kubectl
    cloudflared
    google-chrome
    vlc
    nodejs
    gimp3
    #kicad
    lmms
    yt-dlp
    gdb
    strace

    # fixes icons
    gnomeExtensions.appindicator
  ];


  # dont touch it
  system.stateVersion = "24.11";
}
