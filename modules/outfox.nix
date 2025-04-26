{pkgs, ...}: let
  apps = with pkgs; [
    outfox
  ];
in {
  environment.systemPackages = apps;
}
