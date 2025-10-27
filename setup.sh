#!/bin/bash

sudo apt update 

command_exists() {
    command -v "$1" &>/dev/null
}

list_apts=(
    "git"
    "zsh"
    "ripgrep"
    "python3"
    "python3-venv"
    # "python3-numpy"
    # "python3-pandas"
    # "python3-scipy"
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
    # "thunderbird"
    "vlc"
    # "firefox"
    "inkscape"
    # "zotero"
    "cowsay"
    # "obsidian"
    "inkscape"
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


chsh -s $(which zsh)

# Install Powerlevel10k theme if not already installed
if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
    echo "Installing Powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
        "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
else
    echo "Powerlevel10k already installed."
fi

echo "please make sure Zoom, Anki and Telegram, Obsidian, Zotero and Thunderbird are installed manually."
echo "Make sure to also clone and run the setup in the nvim repo."
echo "Make sure to install and use Fira Code Nerd Font"


