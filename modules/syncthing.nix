{
  config,
  pkgs,
  lib,
  ...
}: {
  services = {
    syncthing = {
      enable = true;
      user = "vukani";
      dataDir = "/home/vukani/sync";
      configDir = "/home/vukani/.config/syncthing";
      overrideDevices = true;
      overrideFolders = false;
      settings = {
        devices = {
          "syncthing-hub" = {id = "E7QKE6I-ARNJZDG-E4G2IER-PGKX5JU-GFFMYDH-ZL6RZEL-JRPIWB3-RR5MDQR";};
        };
        folders = {
          "kmqkd-7ziwr" = {
            path = "/home/vukani/documents";
            devices = ["syncthing-hub"];
          };
          "twqcj-6uefd" = {
            path = "/home/vukani/logseq";
            devices = ["syncthing-hub"];
          };
        };
      };
    };
  };
  systemd.services.syncthing = {
    wantedBy = lib.mkForce ["multi-user.target"];
    wants = lib.mkForce ["network-online.target"];
    after = lib.mkForce ["network-online.target"];
    serviceConfig = {
      Restart = lib.mkForce "always";
      RestartSec = lib.mkForce 5;
      StartLimitBurst = lib.mkForce 5;
    };
  };
}
