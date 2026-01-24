# Hyprland home-manager configuration
{pkgs, ...}: {
  # Hyprland config
  xdg.configFile."hypr/hyprland.conf".source = ../../modules/hyprland/hyprland.conf;
  xdg.configFile."hypr/hyprpaper.conf".source = ../../modules/hyprland/hyprpaper.conf;
  xdg.configFile."hypr/hypridle.conf".source = ../../modules/hyprland/hypridle.conf;
  xdg.configFile."hypr/hyprlock.conf".source = ../../modules/hyprland/hyprlock.conf;

  # Waybar config
  xdg.configFile."waybar/config".source = ../../modules/hyprland/waybar/config.jsonc;
  xdg.configFile."waybar/style.css".source = ../../modules/hyprland/waybar/style.css;

  # Cursor theme for Wayland
  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
    gtk.enable = true;
  };
}
