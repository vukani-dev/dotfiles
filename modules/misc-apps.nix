{pkgs, ...}: let
  apps = with pkgs; [
    keepassxc
    bluetuith
    mpv
    logseq
    betterbird
    wget
    yazi
    kitty
    git
    virt-viewer
    brave
    vscodium
    alejandra
    pulsemixer
    discord
    xorg.xev
    slock
    xautolock
    st
    dmenu
    brightnessctl
    htop
    ueberzugpp
    lazygit
    feh
    flameshot
    neofetch
    vim
  ];
in {
  environment.systemPackages = apps;
}
