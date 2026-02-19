#!/usr/bin/env bash
set -euo pipefail

echo "==> Updating system"
sudo pacman -Syu --noconfirm

echo "==> Installing official packages"
sudo pacman -S --needed --noconfirm \
    anki \
    base-devel \
    bitwarden \
    cifs-utils \
    cowsay \
    fastfetch \
    firefox \
    git \
    inkscape \
    neovim \
    nodejs \
    obsidian \
    pandoc \
    python \
    python-numpy \
    python-pandas \
    python-pip \
    python-pynvim \
    python-scipy \
    python-virtualenv \
    ripgrep-all \
    syncthing \
    telegram-desktop \
    texlive \
    thunderbird \
    tldr \
    tree \
    ttf-firacode-nerd \
    unzip \
    vlc \
    wget \
    zathura \
    zsh \


# --------------------------------------------------
# Install yay (AUR helper) if missing
# --------------------------------------------------

if ! command -v yay &>/dev/null; then
    echo "==> Installing yay"
    tmpdir=$(mktemp -d)
    git clone https://aur.archlinux.org/yay.git "$tmpdir/yay"
    pushd "$tmpdir/yay" >/dev/null
    makepkg -si --noconfirm
    popd >/dev/null
    rm -rf "$tmpdir"
else
    echo "==> yay already installed"
fi

echo "==> Installing AUR packages"
yay -S --needed --noconfirm \
    dropbox \
    zoom \
    zotero
    #hdfview 

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

# Ensure theme is set
ZSHRC="$HOME/.zshrc"
touch "$ZSHRC"

if grep -q '^ZSH_THEME=' "$ZSHRC"; then
    sed -i 's|^ZSH_THEME=.*|ZSH_THEME="powerlevel10k/powerlevel10k"|' "$ZSHRC"
else
    echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> "$ZSHRC"
fi

echo "==> Setup complete"
echo "Remember to:"
echo "Check if you want libreoffice, hdf5"
echo " - Clone and configure your nvim setup"
echo " - Log out and back in for shell change to apply"
