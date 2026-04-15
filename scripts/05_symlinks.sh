#!/usr/bin/env bash
set -euo pipefail
source $HOME/Repos/dotfiles/scripts/lib.sh

echo "Creating symlinks..."


mkdir -p "$HOME/.config/zathura"

if [ ! -d "$MACHINES/$HOST" ]; then
    echo "Warning: no machine config for '$HOST'. Available are:"
    ls "$MACHINES"
    echo "Falling back to safe defaults..."
    HOST=fallback
fi


safe_link "$dotdir/home/gitconfig" "$HOME/.gitconfig"
safe_link "$dotdir/home/zathurarc" "$HOME/.config/zathura/zathurarc"
safe_link "$dotdir/home/latexmkrc" "$HOME/.latexmkrc"
safe_link "$dotdir/home/zshrc" "$HOME/.zshrc"
safe_link "$configdir/zsh" "$HOME/.config/zsh"
safe_link "$configdir/hypr" "$HOME/.config/hypr"
safe_link "$configdir/waybar" "$HOME/.config/waybar"
safe_link "$configdir/nvim" "$HOME/.config/nvim"
safe_link "$MACHINES/$HOST" "$MACHINES/current"
safe_link "$MACHINES/current/hyprpaper.conf" "$HOME/.config/hypr/hyprpaper.conf"
safe_link "$configdir/ssh_config" "$HOME/.ssh/config"
safe_link "$configdir/task" "$HOME/.config/task"
safe_link "$configdir/timewarrior" "$HOME/.config/timewarrior"

for file in $(ls $dotdir/bin)
    do sudo ln -sf $dotdir/bin/$file "/usr/local/bin/$file"
done

safe_link "/current/hypridle.conf" "/home/abu-hamza/.config/hypr/hypridle.conf"
