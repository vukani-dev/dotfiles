{
  imports = [
    ./hardware-configuration.nix
    ../../global-config.nix
    ../../modules/syncthing.nix
    ../../modules/mullvad.nix
    ../../modules/gaming.nix
    ../../modules/media.nix
    ../../modules/docker.nix
    ../../modules/creation.nix
  ];
}
