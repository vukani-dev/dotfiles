#!/bin/sh
status=$(sudo systemctl is-active syncthing.service)

if [ "$status" = "active" ]; then
  echo "Stopping Syncthing..."
  sudo systemctl stop syncthing.service
else
  echo "Starting Syncthing..."
  sudo systemctl start syncthing.service
fi

sleep 1
new_status=$(sudo systemctl is-active syncthing.service)
echo "Syncthing is now $new_status"
