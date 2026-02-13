# Hyprland home-manager configuration
{
  pkgs,
  config,
  ...
}: let
  homeDirectory = config.home.homeDirectory;
in {
  # Hyprland config
  xdg.configFile."hypr/hyprland.conf".source = ../../modules/hyprland/hyprland.conf;
  xdg.configFile."hypr/hyprpaper.conf".source = ../../modules/hyprland/hyprpaper.conf;
  xdg.configFile."hypr/hypridle.conf".source = ../../modules/hyprland/hypridle.conf;
  xdg.configFile."hypr/hyprlock.conf".source = ../../modules/hyprland/hyprlock.conf;

  # Waybar config
  xdg.configFile."waybar/config".source = ../../modules/hyprland/waybar/config.jsonc;
  xdg.configFile."waybar/style.css".source = ../../modules/hyprland/waybar/style.css;

  # Kanshi — automatic monitor profile switching
  services.kanshi = {
    enable = true;
    systemdTarget = "";
    settings = [
      {
        profile.name = "undocked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            mode = "2496x1664@60Hz";
          }
        ];
        profile.exec = ["${homeDirectory}/scripts/set-wallpaper.sh"];
      }
      {
        profile.name = "docked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "DP-1";
            status = "enable";
            mode = "3000x2000@60Hz";
          }
        ];
        profile.exec = ["${homeDirectory}/scripts/set-wallpaper.sh"];
      }
    ];
  };

  # Cursor theme for Wayland
  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
    gtk.enable = true;
  };
}
