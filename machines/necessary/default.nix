{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../global-config.nix
    ../../modules/syncthing.nix
    ../../modules/mullvad.nix
    ../../modules/gaming.nix
    ../../modules/docker.nix
    ../../modules/logseq.nix
    ../../modules/cursor.nix
  ];
}
