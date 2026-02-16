#!/bin/bash

# Update system
sudo pacman -Syu --noconfirm

command_exists() {
    command -v "$1" &>/dev/null
}

# List of packages (Arch package names)
list_pacman=(
    "git"
    "zsh"
    "neovim"
    "latexmk"
    "ripgrep"
    "python"
    "python-virtualenv"
    "python-numpy"
    "python-pandas"
    "python-scipy"
    "python-neovim"
    "python-pip"
    "nodejs"
    "tree"
    "neofetch"
    "zathura"
    "syncthing"
    "tldr"
    "wget"
    "unzip"
    "guake"
    "vlc"
    "cowsay"
    "inkscape"
    "cifs-utils"
    "pandoc"
)

# Check for missing packages
missing_packages=()
for pkg in "${list_pacman[@]}"; do
    if ! pacman -Qi "$pkg" &>/dev/null; then
        missing_packages+=("$pkg")
    fi
done

# Install missing packages
if [ ${#missing_packages[@]} -gt 0 ]; then
    sudo -v
    echo "Installing missing packages: ${missing_packages[*]}"
    sudo pacman -S --noconfirm "${missing_packages[@]}"
else
    echo "All packages are installed"
fi

# Change default shell to zsh for current user if not already
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Changing default shell to zsh..."
    chsh -s "$(which zsh)"
    echo "Shell changed. You may need to log out and log back in for it to take effect."
else
    echo "Default shell is already zsh."
fi

# Install Oh My Zsh non-interactively if not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    RUNZSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    echo "Oh My Zsh installed."
else
    echo "Oh My Zsh already installed."
fi

# Install Powerlevel10k theme if not already present
THEME_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
if [ ! -d "$THEME_DIR" ]; then
    echo "Installing Powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$THEME_DIR"
    echo "Powerlevel10k installed."
else
    echo "Powerlevel10k already installed."
fi

# Ensure Powerlevel10k is set as the active theme in .zshrc
ZSHRC="$HOME/.zshrc"
if [ -f "$ZSHRC" ]; then
    if grep -q '^ZSH_THEME=' "$ZSHRC"; then
        # Replace any existing theme line
        sed -i 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\\/powerlevel10k"/' "$ZSHRC"
        echo "Updated ZSH_THEME in .zshrc."
    else
        # Add theme line near the top if missing
        sed -i '1i ZSH_THEME="powerlevel10k/powerlevel10k"' "$ZSHRC"
        echo "Added ZSH_THEME to .zshrc."
    fi
else
    echo "Creating .zshrc with Powerlevel10k theme..."
    echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' > "$ZSHRC"
fi

echo "Please make sure Zoom, Anki, Obsidian and Zotero are installed manually."
echo "Please make sure Telegram, Firefox and Thunderbird are installed with Flatpak."
echo "Make sure to also clone and run the setup in the nvim repo."
echo "Make sure to install and use Fira Code Nerd Font."
