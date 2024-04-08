{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./modules/suckless
    ./modules/misc-apps.nix
  ];

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    auto-optimise-store = true;
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
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

  # Configure X11 with DWM
  services.xserver = {
    windowManager.dwm.enable = true;
    xkb = {
      variant = "";
      layout = "us";
    };
    enable = true;
    displayManager.startx.enable = true;
    libinput = {
      enable = true;
      mouse.naturalScrolling = true;
      touchpad.naturalScrolling = true;
    };
  };

  # AUDIO
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vukani = {
    isNormalUser = true;
    description = "vukani";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.nushell;
  };

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  #  environment.systemPackages = with pkgs; [
  #  ];

  # FONTS
  fonts.packages = with pkgs; [
    nerdfonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    noto-fonts-lgc-plus
    openmoji-color
  ];

  # GARBAGE COLLECTION
  nix.gc = {
    automatic = true; # Enable the automatic garbage collector
    dates = "weekly"; # When to run the garbage collector
  };

  # HOME MANAGER MODULE
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      vukani = import ./home-manager/home.nix {
        username = "vukani";
        inherit inputs pkgs;
        homeDirectory = "/home/vukani";
      };
      root = import ./home-manager/home.nix {
        inherit inputs pkgs;
        username = "root";
        homeDirectory = "/root";
      };
    };
  };

  programs.dconf.enable = true;
  services.printing.enable = true;
  # services.logind.extraConfig = "HandleLidSwitch=ignore";
  # services.picom = {
  #   enable = true;
  #   inactiveOpacity = 0.8;
  #   activeOpacity = 1.0;
  #   opacityRules = [
  #     "99:class_g = 'St' && focused"
  #     "90:class_g = 'St' && !focused"
  #     "98:class_g = 'firefox' && !focused"
  #     "100:class_g = 'firefox' && focused"
  #   ];
  # };

  system.stateVersion = "23.11";
}
