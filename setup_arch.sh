#!/usr/bin/env bash

set -euo pipefail

SCRIPTS="$HOME/Repos/dotfiles/scripts"

source "$SCRIPTS/00_lib.sh"
source "$SCRIPTS/01_system.sh"
source "$SCRIPTS/02_zsh.sh"
source "$SCRIPTS/03_hyprland.sh"
source "$SCRIPTS/04_neovim.sh"
source "$SCRIPTS/05_symlinks.sh"
source "$SCRIPTS/06_cleanup.sh"

