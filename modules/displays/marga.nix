# Display configuration for marga (Dell Precision 5560) — Kanshi
# Docking behavior: when external monitor (DP-3) is connected, disable laptop screen
{pkgs, ...}: {
  # Marga monitor config: fallback rules for Hyprland
  environment.etc."hypr/monitors.conf".text = ''
    monitor = DP-3, 3000x2000@60, 0x0, 1
    monitor = eDP-1, disable
    monitor = , preferred, auto, 1
    exec-once = kanshi -c /etc/kanshi/config
  '';

  # Kanshi config: auto-switch on hotplug
  environment.etc."kanshi/config".text = ''
    profile docked {
      output DP-3 mode 3000x2000@60 position 0,0
      output eDP-1 disable
    }

    profile undocked {
      output eDP-1 enable mode 2560x1600@60 position 0,0 scale 1
    }
  '';
}
