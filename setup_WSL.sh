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
    "cowsay"
    # "fortune"
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

# zsh as standard shell
chsh -s $(which zsh)

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

echo "Make sure to also clone and run the setup in the nvim repo. Also install Fira Code Nerd Font"

