# Display configuration for marga (Dell Precision 5560)
{pkgs, ...}: let
  displayScript = pkgs.writeShellScriptBin "display-switch" ''
    # Wait a moment for display to be fully detected
    sleep 1

    EXTERNAL="DP-3"
    INTERNAL="eDP-1"

    # Check if external monitor is connected
    if xrandr | grep -q "$EXTERNAL connected"; then
      # External connected: use it at 3600x2400, disable internal
      xrandr --output $INTERNAL --off --output $EXTERNAL --primary --mode 3600x2400 --rate 60
    else
      # No external: use internal at native res
      xrandr --output $EXTERNAL --off --output $INTERNAL --primary --mode 2560x1600 --rate 60
    fi

    # Reset wallpaper
    ${pkgs.hsetroot}/bin/hsetroot -solid "#304D75" -center /home/vukani/pictures/wallpapers/wall1.jpg &
  '';
in {
  environment.systemPackages = [displayScript];

  # Run on boot and display hotplug
  services.udev.extraRules = ''
    ACTION=="change", SUBSYSTEM=="drm", RUN+="${pkgs.bash}/bin/bash -c 'DISPLAY=:0 ${displayScript}/bin/display-switch || true'"
  '';
}
