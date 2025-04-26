{
  imports = [
    ./hardware-configuration.nix
    ../../global-config.nix
    ../../modules/syncthing.nix
    ../../modules/mullvad.nix
    ../../modules/media.nix
    ../../modules/logseq.nix
    ../../modules/cursor.nix
    ../../modules/outfox.nix
  ];
}
