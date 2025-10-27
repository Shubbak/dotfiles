#!/bin/bash


mkdir -p /home/$USER/.config/zathura

ln -sf /home/$USER/Repos/dotfiles/gitconfig ~/.gitconfig
ln -sf /home/$USER/Repos/dotfiles/zathurarc ~/.config/zathura/zathurarc
ln -sf /home/$USER/Repos/dotfiles/latexmkrc ~/.latexmkrc
ln -sf /home/$USER/Repos/dotfiles/zshrc ~/.zshrc
ln -sf /home/$USER/Repos/dotfiles/p10.zsh ~/.p10k.zsh
ln -sf /home/$USER/Repos/dotfiles/oh-my-posh ~/.oh-my-posh

echo "Symlinks created!"

