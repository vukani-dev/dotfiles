{pkgs, ...}: let
  apps = with pkgs; [
    jellyfin-media-player
  ];
in {
  environment.systemPackages = apps;
}
