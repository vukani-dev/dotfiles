{pkgs, ...}: let
  apps = with pkgs; [
    luanti
  ];
in {
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  programs.gamemode.enable = true; # Run games with: gamemoderun %command%
  environment.systemPackages = apps;
}
