#!/usr/bin/env bash


dotdir="$HOME/Repos/dotfiles"
configdir="$dotdir/config"
MACHINES=$configdir/hypr/config/machines
HOST=$(hostname)

command_exists() { command -v "$1" &>/dev/null; }


ask_yes_no() {
    local prompt="$1"
    local ans
    read -rp "$prompt (y/n): " ans < /dev/tty
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

optional_remove() {
    local pkg="$1"

    if ! yay -Q "$pkg" &>/dev/null; then
        return
    fi

    if ask_yes_no "Remove $pkg?"; then
        yay -Rs --noconfirm "$pkg"
    else
        echo "Keeping $pkg"
    fi
}

safe_link() {
    local src="$1"
    local dst="$2"

    if [[ -L "$dst" ]] && [[ "$dst" -ef "$src" ]]; then
        echo "symlink already correct: $dst"
        return
    fi

    if [[ -e "$dst" ]] && [[ ! -L "$dst" ]]; then
        echo "$dst exists as a real file"
        if ! ask_yes_no "Replace $dst with symlink to $src?"; then
            echo "Skipping $dst"
            return
        fi
    fi

    rm -rf "$dst"
    ln -sf "$src" "$dst"
}
