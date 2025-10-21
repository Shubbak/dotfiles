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

# Connect SMB Server
1. `sudo apt install cifs-utils`
2. `mkdir -p /mnt/dirname` or other location
3. `touch ~/.smbcredentials`
4. `nvim .smbcredentials` 
5. Content of `~/.smbcredentials`:
```
username=uk123456
password=PASSWORD
domain=its-ad
```
6. `sudo nvim /etc/fstab`. Add line:
`//smb.uni-kassel.de/exp4_all /mnt/dirname cifs credentials=/home/YOUR_USER/.smbcredentials,uid=1000,gid=1000,iocharset=utf8,vers=3.0,sec=ntlmssp 0 0`
7. sudo mount -a
