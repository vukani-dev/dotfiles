{pkgs, ...}: let
  apps = with pkgs; [
    lshw
    keymapp
    qbittorrent
    arandr
    trezor-suite
    trezor-udev-rules
    gotop
    cmus
    nfs-utils
    nh
    freerdp
    libreoffice
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
    google-chrome
  ];
in {
  environment.systemPackages = apps;
}
