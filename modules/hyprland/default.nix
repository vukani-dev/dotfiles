# Hyprland configuration module
{
  pkgs,
  config,
  ...
}: {
  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true; # X11 app compatibility
  };

  # Wayland packages
  environment.systemPackages = with pkgs; [
    # Core
    waybar # Status bar
    wofi # App launcher (wayland-native)
    hyprpaper # Wallpaper
    hypridle # Idle daemon
    hyprlock # Lock screen

    # Screenshot & clipboard
    grim # Screenshot
    slurp # Region select
    wl-clipboard # Clipboard

    # Utilities
    swaynotificationcenter # Notifications
    libnotify # notify-send
    playerctl # Media controls
    networkmanagerapplet # nm-applet for systray
    brightnessctl # Screen brightness (used by hypridle)
    jq # JSON parsing (used by transparency toggle)
  ];

  # Font for waybar
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # XDG portal for screen sharing, file dialogs
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-hyprland];
  };

  # Greetd display manager
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session --sessions /etc/greetd/sessions:${config.services.displayManager.sessionData.desktops}/share/wayland-sessions";
        user = "greeter";
      };
    };
  };


  # Session entries for greetd
  services.displayManager.sessionPackages = [pkgs.hyprland];

  # Create dwm X session entry for greetd
  # This uses startx to properly initialize X with .xinitrc
  environment.etc."greetd/sessions/dwm.desktop".text = ''
    [Desktop Entry]
    Name=dwm
    Comment=Dynamic Window Manager (via startx)
    Exec=startx
    Type=Application
  '';

  # NVIDIA environment variables (safe for both X11 and Wayland)
  environment.sessionVariables = {
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";
  };
}
