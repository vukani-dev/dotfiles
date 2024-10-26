#!/bin/sh
status=$(systemctl is-active syncthing.service)

if [ "$status" = "active" ]; then
  echo "Stopping Syncthing..."
  systemctl stop syncthing.service
else
  echo "Starting Syncthing..."
  systemctl start syncthing.service
fi

sleep 1
new_status=$(systemctl is-active syncthing.service)
echo "Syncthing is now $new_status"
