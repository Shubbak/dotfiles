#!/usr/bin/env bash
set -euo pipefail
source $HOME/Repos/dotfiles/scripts/lib.sh

echo "=== Neovim Setup for Arch ==="

# Helper functions




# 2. Core dependencies
echo "[1/4] Installing essential tools..."
sudo pacman -S --needed --noconfirm \
  neovim git ripgrep fd python-pynvim nodejs 

# 3. Optional: Tree-sitter
echo "[2/4] tree-sitter-cli is a tool for parsing files according to types and enabling syntax highlighting and similar"
optional_install tree-sitter-cli

# 4. Optional: LSP servers

if pacman -Q pyright typescript-language-server bash-language-server lua-language-server texlab &>/dev/null; then
    echo "LSP servers already installed - skipping"
else
    if ask_yes_no "[3/4] Do you want to install common LSP servers (Python, TypeScript, Bash, Lua, LaTeX)?"; then
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

echo " Open Neovim and run :checkhealth"
echo " If you installed LSP, verify with :LspInfo or Mason inside Neovim"
