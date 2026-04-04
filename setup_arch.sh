#!/usr/bin/env bash

set -euo pipefail

SCRIPTS="$HOME/Repos/dotfiles/scripts"

for script in "$SCRIPTS"/[0-9]*.sh; do
    bash "$script"
done
