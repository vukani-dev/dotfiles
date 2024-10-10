#!/bin/sh
intern=eDP-1
extern=DP-1

if xrandr | grep "$extern disconnected"; then
    xrandr --output "$extern" --off --output "$intern" --auto
else
    xrandr --output "$intern" --auto --output "$extern" --primary --right-of "$intern" --mode 2160x1440
fi
