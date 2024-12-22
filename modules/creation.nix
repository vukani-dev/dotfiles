{pkgs, ...}: let
  apps = with pkgs; [
    android-studio-full
  ];
in {
  environment.systemPackages = apps;
}
