{pkgs, ...}: let
  apps = with pkgs; [
    bitwarden
    maim
    hsetroot
    moonlight-qt
    android-tools
    ranger
    mupdf
    thunderbird
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
    wget
    yazi
    git
    xclip
    virt-viewer
    brave
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
    neofetch
    vim
    google-chrome
  ];
in {
  environment.systemPackages = apps;
}
