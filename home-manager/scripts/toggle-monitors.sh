#!/bin/sh
intern=eDP-1
extern=DP-1

if xrandr | grep "$extern disconnected"; then
    xrandr --output "$extern" --off --output "$intern" --auto
else
    xrandr --output "$intern" --auto --output "$extern" --primary --left-of "$intern" --auto
fi