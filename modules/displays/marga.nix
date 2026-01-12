# Display configuration for marga (Dell Precision 5560)
# External: DP-3 @ 3000x2000, Laptop: eDP-1 @ 2560x1600
{pkgs, ...}: {
  # Autorandr handles hotplug automatically
  services.autorandr = {
    enable = true;
    profiles = {
      # Docked: external monitor only
      docked = {
        fingerprint = {
          DP-3 = "*"; # Match any external on DP-3
        };
        config = {
          DP-3 = {
            enable = true;
            primary = true;
            mode = "3600x2400";
            rate = "60.00";
            position = "0x0";
          };
          eDP-1 = {
            enable = false;
          };
        };
      };
      # Mobile: laptop screen only
      mobile = {
        fingerprint = {
          eDP-1 = "*";
        };
        config = {
          eDP-1 = {
            enable = true;
            primary = true;
            mode = "2560x1600";
            rate = "59.99";
            position = "0x0";
          };
        };
      };
    };
    hooks = {
      postswitch = {
        # Reset wallpaper and restart statusbar after display change
        "reset-desktop" = ''
          ${pkgs.hsetroot}/bin/hsetroot -solid "#304D75" -center /home/vukani/pictures/wallpapers/wall1.jpg &
          pkill -x statusbar.sh
          /home/vukani/scripts/statusbar.sh &
        '';
      };
    };
  };

  # Udev rule for hotplug detection
  services.udev.extraRules = ''
    ACTION=="change", SUBSYSTEM=="drm", RUN+="${pkgs.autorandr}/bin/autorandr --change"
  '';
}
