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
}
