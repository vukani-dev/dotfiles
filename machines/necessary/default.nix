{lib, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../global-config.nix
    ../../modules/hyprland
    ../../modules/syncthing.nix
    ../../modules/mullvad.nix
    ../../modules/gaming.nix
    ../../modules/docker.nix
    ../../modules/logseq.nix
  ];

  # Disable X11/DWM — using Hyprland via greetd instead
  services.xserver.windowManager.dwm.enable = lib.mkForce false;
  services.xserver.displayManager.startx.enable = lib.mkForce false;

  # Hibernate support — resume from swap partition
  boot.resumeDevice = "/dev/disk/by-uuid/7c80dad4-d10e-4a0c-9d74-569e1c743c1b";

  # Auto CPU frequency scaling — switches between powersave/performance
  # based on battery vs AC and system load
  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };
}
