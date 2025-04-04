# What this is:
Here, my ubuntu specific configuration files are stored and synced.
The files are stored in ~/dotfiles and symlinks are created in the expected directories (e.g ~/.latexmkrc -> ~/dotfiles/latexmkrc)
# How to use it:
1. clone the repo into ~
2. make the script executable:
```zsh
chmod +x setup.sh
```
3. Execute the script
4. Enjoy


# Notes on aliases
The `pullall` alias pulls all git repos inside the current directorie.
However, you need to make sure that all subdirectories are indeed repos.
