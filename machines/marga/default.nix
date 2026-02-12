{lib, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../global-config.nix
    ../../modules/hyprland
    ../../modules/syncthing.nix
    ../../modules/mullvad.nix
    ../../modules/gaming.nix
    ../../modules/media.nix
    ../../modules/docker.nix
    ../../modules/logseq.nix
    ../../modules/displays/marga.nix
  ];

  # Disable X11/DWM — using Hyprland via greetd instead
  services.xserver.windowManager.dwm.enable = lib.mkForce false;
  services.xserver.displayManager.startx.enable = lib.mkForce false;

  # Always docked — run at full performance
  powerManagement.cpuFreqGovernor = "performance";

  # Pin Intel iGPU to max frequency — needed for 3600x2400 compositing
  systemd.tmpfiles.rules = [
    "w /sys/class/drm/card1/gt_min_freq_mhz - - - - 1400"
    "w /sys/class/drm/card1/gt_boost_freq_mhz - - - - 1400"
  ];
}
