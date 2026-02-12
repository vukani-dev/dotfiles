# Hyprland configuration module
{
  pkgs,
  lib,
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
    # wofi replaced by rofi-wayland (configured in home-manager)
    swaybg # Wallpaper
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
    kanshi # Auto monitor switching
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

  # Default monitor config — machines can override via their display module
  environment.etc."hypr/monitors.conf".text = lib.mkDefault ''
    monitor = eDP-1, preferred, 0x0, 1
    monitor = , preferred, auto, 1
  '';

}
