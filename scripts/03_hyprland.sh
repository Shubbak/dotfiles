#!/usr/bin/env bash
set -euo pipefail
source $HOME/Repos/dotfiles/scripts/lib.sh

echo "Installing hyprland-specific packages..."

sudo pacman --needed -S - < $dotdir/package_lists/hyprland_installs.txt
yay --needed -S - < $dotdir/package_lists/hyprland_installs_yay.txt

