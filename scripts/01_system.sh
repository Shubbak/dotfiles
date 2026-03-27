#!/usr/bin/env bash

echo "==> Updating system"
sudo pacman -Syu --noconfirm

# non-optional packages
echo "==> Installing official packages"
sudo pacman -S --needed --noconfirm - < "$dotdir/package_lists/package_list.txt"

# optional packages

echo "==> Installing optional packages"
while IFS= read -r pkg || [[ -n "$pkg" ]]; do
    [[ -z "$pkg" || "$pkg" == \#* ]] && continue
    optional_install "$pkg"
done < "$dotdir/package_lists/optional_pacman.txt"

echo "You should have nvim now. Do you want to remove vim-runtime, vim, ex-vi-compat?" 
optional_remove ex-vi-compat
optional_remove vim
optional_remove vim-runtime

echo "You should have nvim now. Do you want to remove nano? Please confirm after the script, that \$EDITOR=nvim. "
optional_remove nano-syntax-highlighting
optional_remove nano

optional_remove haruna
optional_remove gwenview

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
while IFS= read -r pkg || [[ -n "$pkg" ]]; do
    [[ -z "$pkg" || "$pkg" == \#* ]] && continue
    optional_yay "$pkg"
done < "$dotdir/package_lists/optional_yay.txt"

systemctl enable --user syncthing
