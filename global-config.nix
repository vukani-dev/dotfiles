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

  # Core system configuration
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      substituters = ["https://claude-code.cachix.org"];
      trusted-public-keys = ["claude-code.cachix.org-1:YeXf2aNu7UTX8Vwrze0za1WEDS+4DuI2kVeWEE4fsRk="];
      # Build performance
      max-jobs = "auto";
      cores = 0; # Use all cores per job
      keep-outputs = true;
      keep-derivations = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  # Limit boot entries to prevent /boot filling up
  boot.loader.systemd-boot.configurationLimit = 10;

  # Hardware configuration
  hardware = {
    keyboard.zsa.enable = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  # Android USB
  services.usbmuxd.enable = true;

  # Networking
  networking = {
    networkmanager.enable = true;
    # hosts = {"x.x.x.x" = "test.io" };  # Consider enabling only if needed
  };
  services.nfs.server.enable = true;

  # Localization and time
  time.timeZone = "America/New_York";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
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
  };

  # Display and input
  services.xserver = {
    enable = true;
    windowManager.dwm.enable = true;
    displayManager.startx.enable = true;
    xkb = {
      variant = "";
      layout = "us";
    };
  };
  services.libinput = {
    enable = true;
    mouse.naturalScrolling = true;
    touchpad.naturalScrolling = true;
  };

  # Audio
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };
  services.blueman.enable = true;

  # User configuration
  programs.zsh.enable = true;
  users = {
    defaultUserShell = pkgs.zsh;
    users.vukani = {
      isNormalUser = true;
      description = "vukani";
      extraGroups = ["networkmanager" "wheel" "adbusers" "plugdev"];
      shell = pkgs.zsh;
    };
  };

  # Package management
  nixpkgs.config = {
    allowUnfree = true;
  };

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    noto-fonts-lgc-plus
    openmoji-color
  ];

  # Home Manager
  home-manager = {
    backupFileExtension = "old";
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

  # Additional services
  services = {
    trezord.enable = true;
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    fstrim.enable = true; # SSD maintenance
    earlyoom = {
      enable = true;
      freeMemThreshold = 5; # Prevent OOM freezes
    };
  };

  # Memory optimization
  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };
  programs.dconf.enable = true;

  # Power management / sleep
  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = "ignore"; # Don't suspend when plugged in with lid closed
    HandlePowerKey = "suspend";
  };
  # Ensure proper resume from suspend
  powerManagement.enable = true;

  system.stateVersion = "23.11";
}
