# What this is:
Here, my ubuntu specific configuration files are stored and synced.
The files are stored in ~/Repos/dotfiles and symlinks are created in the expected directories (e.g ~/.latexmkrc -> ~/dotfiles/latexmkrc)
# How to use it:
1. clone the repo into ~/Repos/
2. make the scripts executable:
```zsh
chmod +x setup.sh
chmod +x setup_WSL.sh
chmod +x setup_symlinks.sh
```
3. Execute the scripts in the order `setup(_WSL).sh, setup_symlinks.sh`
4. Enjoy


# Notes on aliases
The `pullall` alias pulls all git repos inside the current directorie.
However, you need to make sure that all subdirectories are indeed repos.
Else, an error occurs.
