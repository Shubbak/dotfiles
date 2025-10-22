#!/bin/bash

sudo apt update 

command_exists() {
    command -v "$1" &>/dev/null
}

list_apts=(
    "git"
    "zsh"
    "neovim"
    "latexmk"
    "ripgrep"
    "python3"
    "python3-venv"
    "python3-numpy"
    "python3-pandas"
    "python3-scipy"
    "python3-neovim"
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
    "inkscape"
    "cowsay"
    "cifs-utils"
    "pandoc"
)

missing_packages=()
for apt in "${list_apts[@]}"; do
    if ! command_exists "$apt"; then
        missing_packages+=("$apt")
    fi
done

if [ ${#missing_packages[@]} -gt 0 ]; then
    sudo -v
    echo "installing missing packages: ${missing_packages[*]}"
    sudo apt install -y "${missing_packages[@]}" 
else
    echo "all packages are installed"
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

echo "please make sure Zoom, Anki, Obsidian and Zotero are installed manually."
echo "please make sure Telegram, Firefox and Thunderbird are installed with flatpak. You may need to remove snaps and snapd first. Please refer to README.md."
echo "Make sure to also clone and run the setup in the nvim repo."


