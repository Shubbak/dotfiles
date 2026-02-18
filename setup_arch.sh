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
