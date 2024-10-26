{
  config,
  pkgs,
  lib,
  ...
}: {
  systemd.services.syncthing = {
    wantedBy = lib.mkForce []; # Force override the default target
    wants = lib.mkForce []; # Force override additional auto-start triggers
    after = ["network-online.target"];
    serviceConfig = {
      Restart = lib.mkForce "no"; # Force override restart behavior
      RestartSec = lib.mkForce 0;
      StartLimitInterval = lib.mkForce 0;
      StartLimitBurst = lib.mkForce 0;
    };
  };
  services = {
    syncthing = {
      enable = true;
      user = "vukani";
      dataDir = "/home/vukani/sync";
      configDir = "/home/vukani/.config/syncthing";
      overrideDevices = true; # overrides any devices added or deleted through the WebUI
      overrideFolders = false; # overrides any folders added or deleted through the WebUI
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
}
