# Apply display profile (autorandr handles hotplug via udev)
autorandr --change &

hsetroot -solid "#304D75" -center /home/vukani/pictures/wallpapers/wall1.jpg &
xautolock -time 10 -locker slock &
/home/vukani/scripts/statusbar.sh &
exec dwm
