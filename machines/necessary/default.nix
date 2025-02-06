{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../global-config.nix
    # ../../modules/syncthing.nix
    ../../modules/mullvad.nix
    ../../modules/gaming.nix
    ../../modules/docker.nix
  ];
}
