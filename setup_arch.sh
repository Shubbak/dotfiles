#!/usr/bin/env bash

set -euo pipefail

ask_yes_no() {
    local prompt="$1"
    local ans
    read -rp "$prompt (y/n): " ans
    ans=${ans,,}  # lowercase
    [[ "$ans" =~ ^(y|yes)$ ]]
}

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
    geeqie \
    git \
    inkscape \
    konsole \
    ktouch \
    libreoffice-fresh \
    neovim \
    nodejs \
    obsidian \
    openconnect \
    pandoc \
    python \
    python-numpy \
    python-pandas \
    python-pip \
    python-pynvim \
    python-scipy \
    python-virtualenv \
    qbittorrent \
    ripgrep-all \
    speedtest-cli \
    syncthing \
    telegram-desktop \
    texlive \
    texlive-lang{arabic,german,english} \
    thunderbird \
    tldr \
    tree \
    ttf-firacode-nerd \
    ttf-scheherazade-new \
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

echo "Creating symlinks..."

dotdir="$HOME/Repos/dotfiles"

mkdir -p $HOME/.config/zathura

ln -sf $dotdir/gitconfig $HOME/.gitconfig
ln -sf $dotdir/zathurarc $HOME/.config/zathura/zathurarc
ln -sf $dotdir/latexmkrc $HOME/.latexmkrc
ln -sf $dotdir/zshrc $HOME/.zshrc
# ln -sf $dotdir/p10.zsh $HOME/.p10k.zsh

echo "Symlinks created!"

# configure p10k
konsole 

echo "==> Setup complete"
echo "Remember to:"
echo "Check if you want hdf5"
echo " - Clone and configure your nvim setup"
if ask_yes_no "Do you want to reboot now?"; then
    reboot 
fi
