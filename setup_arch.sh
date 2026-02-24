#!/usr/bin/env bash

set -euo pipefail

ask_yes_no() {
    local prompt="$1"
    local ans
    read -rp "$prompt (y/n): " ans
    ans=${ans,,}  # lowercase
    [[ "$ans" =~ ^(y|yes)$ ]]
}

optional_install() {
    local pkg="$1"

    if pacman -Q "$pkg" &>/dev/null; then
        echo "$pkg already intalled - skipping"
        return
    fi

    if ask_yes_no "Install $pkg?"; then
        sudo pacman -S --needed --noconfirm "$pkg"
    else
        echo "Skipping installation of $pkg"
    fi
}

optional_yay() {
    local pkg="$1"

    if yay -Q "$pkg" &>/dev/null; then
        echo "$pkg already installed - skipping"
        return
    fi

    if ask_yes_no "Install $pkg?"; then
        yay -S --needed --noconfirm "$pkg"
    else
        echo "Skipping installation of $pkg"
    fi
}

echo "==> Updating system"
sudo pacman -Syu --noconfirm

# non-optional packages
echo "==> Installing official packages"
sudo pacman -S --needed --noconfirm \
    bitwarden \
    base-devel \
    cifs-utils \
    cowsay \
    eza \
    firefox \
    geeqie \
    git \
    inkscape \
    konsole \
    libreoffice-fresh \
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
    texlive \
    texlive-lang{arabic,german,english} \
    thunderbird \
    tldr \
    ttf-firacode-nerd \
    ttf-scheherazade-new \
    unzip \
    vlc \
    wget \
    zathura \
    zsh

# optional packages

optional_install anki
optional_install element-desktop
optional_install fastfetch
optional_install img2pdf
optional_install ktouch
optional_install openconnect
optional_install qbittorrent
optional_install speedtest-cli
optional_install telegram-desktop

if pacman -Q ex-vi-compat &>/dev/null; then
    if ask_yes_no "You should have nvim now. Do you want to remove vim-runtime, vim, ex-vi-compat? "; then
        sudo pacman -Rs --noconfirm ex-vi-compat vim vim-runtime
    fi
fi

if pacman -Q nano-syntax-highlighting &>/dev/null; then
    if ask_yes_no "You should have nvim now. Do you want to remove nano? Please confirm after the script, that $EDITOR=nvim. "; then
        sudo pacman -Rs --noconfirm nano-syntax-highlighting nano
    fi
fi

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
optional_yay dropbox 
optional_yay hdfview 
optional_yay zoom 
optional_yay zotero

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

# # Ensure theme is set
# ZSHRC="$HOME/.zshrc"
# touch "$ZSHRC"
# 
# if grep -q '^ZSH_THEME=' "$ZSHRC"; then
    # sed -i 's|^ZSH_THEME=.*|ZSH_THEME="powerlevel10k/powerlevel10k"|' "$ZSHRC"
# else
    # echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> "$ZSHRC"
# fi

echo "Creating symlinks..."

dotdir="$HOME/Repos/dotfiles"

mkdir -p "$HOME/.config/zathura"

ln -sf "$dotdir/gitconfig" "$HOME/.gitconfig"
ln -sf "$dotdir/zathurarc" "$HOME/.config/zathura/zathurarc"
ln -sf "$dotdir/latexmkrc" "$HOME/.latexmkrc"
ln -sf "$dotdir/zshrc" "$HOME/.zshrc"
# ln -sf "$dotdir/p10.zsh" "$HOME/.p10k.zsh"

echo "Symlinks created!"

# configure p10k
if ask_yes_no "open new konsole to run p10k configuration wizard?"; then
    konsole --nofork &
fi

echo "==> Setup complete"
echo "Remember to:"
echo "Check if you want hdf5"
echo " - Clone and configure your nvim setup"
if ask_yes_no "Do you want to reboot now?"; then
    reboot 
fi
