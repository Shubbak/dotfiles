#!/usr/bin/env bash
set -euo pipefail
source $HOME/Repos/dotfiles/scripts/lib.sh

# --------------------------------------------------
# Zsh setup
# --------------------------------------------------

if [[ "$SHELL" != "$(command -v zsh)" ]]; then
    echo "==> Setting zsh as default shell"
    chsh -s "$(command -v zsh)"
fi

# Oh My Zsh
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    echo "==> Installing Oh My Zsh"
    RUNZSH=no KEEP_ZSHRC=yes \
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Powerlevel10k
THEME_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
if [[ ! -d "$THEME_DIR" ]]; then
    echo "==> Installing Powerlevel10k"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$THEME_DIR"
fi

