#!/bin/bash

command_exists() {
    command -v "$1" &>/dev/null
}

list_apts=(
    "git"
    "zsh"
    "ripgrep"
    "python3"
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
    # "thunderbird"
    "vlc"
    "firefox"
    "inkscape"
    # "zotero"
    "cowsay"
    # "obsidian"
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

echo "please make sure Zoom, Anki and Telegram, Obsidian, Zotero and Thunderbird are installed manually."
echo "Make sure to also clone and run the setup in the nvim repo."


