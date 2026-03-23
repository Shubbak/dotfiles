#!/usr/bin/env bash
set -euo pipefail

echo "=== Neovim Setup for EndeavourOS (Arch-based) ==="

# Helper functions
command_exists() { command -v "$1" &>/dev/null; }

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

# 1. Update system
# echo "[1/5] Updating system..."
# sudo pacman -Syu --noconfirm

# 2. Core dependencies
echo "[2/5] Installing essential tools..."
sudo pacman -S --needed --noconfirm \
  neovim git ripgrep fd python-pynvim nodejs 

# 3. Optional: Tree-sitter
echo "tree-sitter-cli is a tool for parsing files according to types and enabling syntax highlighting and similar"
optional_install tree-sitter-cli

# 4. Optional: LSP servers

if pacman -Q pyright typescript-language-server bash-language-server lua-language-server texlab &>/dev/null; then
    echo "LSP servers already installed - skipping"
else
    if ask_yes_no "Do you want to install common LSP servers (Python, TypeScript, Bash, Lua, LaTeX)?"; then
        sudo pacman -S --needed --noconfirm \
            pyright \
            typescript-language-server \
            bash-language-server \
            lua-language-server \
            texlab
        echo "✅ LSP servers installed."
    fi
fi



# 5. Optional: Neovide
optional_install neovide

# 6. Fonts (Nerd Font for icons)
optional_install ttf-firacode-nerd

echo ""
echo "=== Setup Complete ==="
echo "Next steps:"
echo " • Clone your Neovim config into ~/.config/nvim"
echo " • Open Neovim and run :checkhealth"
echo " • If you installed LSP, verify with :LspInfo or Mason inside Neovim"
