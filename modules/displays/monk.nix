# Display configuration for monk (ThinkPad X220)
# Laptop: LVDS-1 @ 1280x720 (older ThinkPad uses LVDS, not eDP)
{pkgs, ...}: {
  services.autorandr = {
    enable = true;
    profiles = {
      # Docked: external monitor (VGA on X220)
      docked = {
        fingerprint = {
          VGA-1 = "*";
        };
        config = {
          VGA-1 = {
            enable = true;
            primary = true;
            mode = "1920x1080";
            rate = "60.00";
            position = "0x0";
          };
          LVDS-1 = {
            enable = false;
          };
        };
      };
      # Mobile: laptop screen only
      mobile = {
        fingerprint = {
          LVDS-1 = "*";
        };
        config = {
          LVDS-1 = {
            enable = true;
            primary = true;
            mode = "1366x768"; # X220 native resolution
            rate = "60.00";
            position = "0x0";
          };
        };
      };
    };
    hooks = {
      postswitch = {
        "reset-desktop" = ''
          ${pkgs.hsetroot}/bin/hsetroot -solid "#304D75" -center /home/vukani/pictures/wallpapers/wall1.jpg &
          pkill -x statusbar.sh
          /home/vukani/scripts/statusbar.sh &
        '';
      };
    };
  };

  services.udev.extraRules = ''
    ACTION=="change", SUBSYSTEM=="drm", RUN+="${pkgs.autorandr}/bin/autorandr --change"
  '';
}
