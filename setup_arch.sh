#!/bin/bash

# -----------------------------
# Helper functions
# -----------------------------
command_exists() {
    command -v "$1" &>/dev/null
}

install_yay() {
    # Install yay if not present
    if ! command_exists yay; then
        echo "Installing yay (AUR helper)..."
        sudo pacman -S --needed --noconfirm git base-devel
        tmpdir=$(mktemp -d)
        git clone https://aur.archlinux.org/yay.git "$tmpdir/yay"
        pushd "$tmpdir/yay" || exit
        makepkg -si --noconfirm
        popd || exit
        rm -rf "$tmpdir"
        echo "yay installed."
    fi
}

# -----------------------------
# Update system
# -----------------------------
echo "Updating system..."
sudo pacman -Syu --noconfirm

# -----------------------------
# Pacman packages
# -----------------------------
pacman_packages=(
    git zsh neovim latexmk ripgrep python python-virtualenv python-numpy
    python-pandas python-scipy python-neovim python-pip nodejs tree
    neofetch zathura syncthing tldr wget unzip guake vlc cowsay inkscape
    cifs-utils pandoc
)

missing_packages=()
for pkg in "${pacman_packages[@]}"; do
    if ! pacman -Qi "$pkg" &>/dev/null; then
        missing_packages+=("$pkg")
    fi
done

if [ ${#missing_packages[@]} -gt 0 ]; then
    echo "Installing missing pacman packages: ${missing_packages[*]}"
    sudo pacman -S --noconfirm "${missing_packages[@]}"
else
    echo "All pacman packages are installed."
fi

# -----------------------------
# AUR packages
# -----------------------------
aur_packages=(
    zoom anki-bin obsidian zotero
)

# Ensure yay is installed
install_yay

missing_aur=()
for pkg in "${aur_packages[@]}"; do
    if ! pacman -Qi "$pkg" &>/dev/null && ! yay -Qi "$pkg" &>/dev/null; then
        missing_aur+=("$pkg")
    fi
done

if [ ${#missing_aur[@]} -gt 0 ]; then
    echo "Installing missing AUR packages: ${missing_aur[*]}"
    yay -S --noconfirm "${missing_aur[@]}"
else
    echo "All AUR packages are installed."
fi

# -----------------------------
# Change default shell to zsh
# -----------------------------
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Changing default shell to zsh..."
    chsh -s "$(which zsh)"
    echo "Shell changed. Log out and back in for it to take effect."
else
    echo "Default shell is already zsh."
fi

# -----------------------------
# Oh My Zsh installation
# -----------------------------
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    RUNZSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    echo "Oh My Zsh installed."
else
    echo "Oh My Zsh already installed."
fi

# -----------------------------
# Powerlevel10k theme
# -----------------------------
THEME_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
if [ ! -d "$THEME_DIR" ]; then
    echo "Installing Powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$THEME_DIR"
    echo "Powerlevel10k installed."
else
    echo "Powerlevel10k already installed."
fi

# Ensure Powerlevel10k is set in .zshrc
ZSHRC="$HOME/.zshrc"
if [ -f "$ZSHRC" ]; then
    if grep -q '^ZSH_THEME=' "$ZSHRC"; then
        sed -i 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\\/powerlevel10k"/' "$ZSHRC"
    else
        sed -i '1i ZSH_THEME="powerlevel10k/powerlevel10k"' "$ZSHRC"
    fi
else
    echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' > "$ZSHRC"
fi

# -----------------------------
# Final notes
# -----------------------------
echo "Setup complete!"
echo "- Make sure Telegram, Firefox and Thunderbird are installed via Flatpak if desired."
echo "- Ensure Fira Code Nerd Font is installed and configured."
echo "- Clone and run the setup for your nvim config repository."
