#!/bin/bash

# Get the hostname
my_hostname=$(hostname)

# Run the command with sudo
sudo nixos-rebuild switch --flake "/home/vukani/.dotfiles/.#$my_hostname"

