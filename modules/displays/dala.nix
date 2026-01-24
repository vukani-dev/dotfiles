# Display configuration for dala (System76 Lemur)
{pkgs, ...}: let
  displayScript = pkgs.writeShellScriptBin "display-switch" ''
    sleep 1
    EXTERNAL="DP-1"
    INTERNAL="eDP-1"

    if xrandr | grep -q "$EXTERNAL connected"; then
      xrandr --output $INTERNAL --off --output $EXTERNAL --primary --mode 1920x1080 --rate 60
    else
      xrandr --output $EXTERNAL --off --output $INTERNAL --primary --mode 1920x1080 --rate 60
    fi

    ${pkgs.hsetroot}/bin/hsetroot -solid "#304D75" -center /home/vukani/pictures/wallpapers/wall1.jpg &
  '';
in {
  environment.systemPackages = [displayScript];

  services.udev.extraRules = ''
    ACTION=="change", SUBSYSTEM=="drm", RUN+="${pkgs.bash}/bin/bash -c 'DISPLAY=:0 ${displayScript}/bin/display-switch || true'"
  '';
}
