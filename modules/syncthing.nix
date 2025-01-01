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
          "hub" = {id = "QAJ4HFL-AHT2J44-UXNS6NK-DXFVRYS-ZTCR5YP-TLZEBFO-FQXF7H2-PV63HAZ";};
        };
        folders = {
          "mpwsh-st49m" = {
            path = "/home/vukani/documents";
            devices = ["hub"];
          };
          "q5cwn-5surh" = {
            path = "/home/vukani/logseq";
            devices = ["hub"];
          };
          "kgjmx-ylimg" = {
            path = "/home/vukani/keys";
            devices = ["hub"];
          };
          "b3d5a-grf2q" = {
            path = "/home/vukani/ebooks";
            devices = ["hub"];
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
