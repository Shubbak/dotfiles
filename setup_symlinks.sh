#!/bin/bash


mkdir -p ~/.config/zathura

ln -sf ~/Repos/dotfiles/gitconfig ~/.gitconfig
ln -sf ~/Repos/dotfiles/zathurarc ~/.config/zathura/zathurarc
ln -sf ~/Repos/dotfiles/latexmkrc ~/.latexmkrc
ln -sf ~/Repos/dotfiles/zshrc ~/.zshrc
ln -sf ~/Repos/dotfiles/p10.zsh ~/.p10k.zsh
ln -sf ~/Repos/dotfiles/oh-my-posh ~/.oh-my-posh

echo "Symlinks created!"

