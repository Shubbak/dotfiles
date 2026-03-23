#!/usr/bin/env bash

echo "Installing hyprland-specific packages..."

sudo pacman --needed -S - < $dotdir/package_lists/hyprland_installs.txt
yay --needed -S - < $dotdir/package_lists/hyprland_installs_yay.txt

