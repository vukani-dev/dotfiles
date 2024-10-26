#!/bin/sh
intern=eDP-1
extern=DP-1
RESOLUTION=1280x720
hostname=$(uname -n);

if  [ "$hostname" = "marga" ]; then extern=DP-3; fi;
if  [ "$hostname" = "marga" ]; then RESOLUTION=2560x1600; elif [ "$hostname" = "dala" ] || [ "$hostname" = "necessary" ]; then RESOLUTION=1920x1080; else RESOLUTION=1280x720; fi;


if xrandr | grep "$extern disconnected"; then
    xrandr --output "$extern" --off --output "$intern" --mode $RESOLUTION
else
    xrandr --output "$intern" --off --output "$extern" --primary --left-of "$intern" --mode 2160x1440
fi
