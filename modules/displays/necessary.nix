# Display configuration for necessary (Microsoft Surface Pro)
# Laptop: eDP-1 @ 2496x1664
{pkgs, ...}: {
  services.autorandr = {
    enable = true;
    profiles = {
      # Docked: external monitor only
      docked = {
        fingerprint = {
          DP-1 = "*";
        };
        config = {
          DP-1 = {
            enable = true;
            primary = true;
            mode = "1920x1080";
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
            mode = "2496x1664";
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
