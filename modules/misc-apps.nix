{pkgs, ...}: let
  apps = with pkgs; [
    # AI & Dev tools
    claude-code
    codex
    gemini-cli
    lazygit
    alejandra
    git

    # Terminals & Shells
    ghostty
    st

    # Editors
    vim

    # Browsers
    brave
    google-chrome

    # Media
    ffmpeg
    mpv
    cmus
    feh
    pulsemixer
    python313Packages.yt-dlp
    vdhcoapp

    # Documents & Office
    mupdf
    libreoffice
    thunderbird

    # File management
    yazi
    ueberzugpp

    # System utilities
    fastfetch
    htop
    gotop
    lshw
    wget
    host
    lzip
    nfs-utils
    nh

    # X11 utilities
    xclip
    xorg.xev
    arandr
    maim
    hsetroot
    brightnessctl
    dmenu
    slock
    xautolock

    # Remote & Networking
    freerdp
    moonlight-qt
    parsec-bin
    virt-viewer

    # Communication
    discord

    # Security & Privacy
    bitwarden-desktop
    keepassxc
    trezor-suite
    trezor-udev-rules

    # Hardware
    keymapp
    bluetuith
    android-tools

    # Downloads
    qbittorrent
  ];
in {
  environment.systemPackages = apps;
}
