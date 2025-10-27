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

# Disable snap
1. Identify snaps 
    `snap list`
2. Note which are apps and which are core snaps. Core snaps are for instance `core, core18, core20, snapd`
3. Remove apps `sudo snap remove APP`
4. Remove base packages `sudo snap remove BASE`
5. Disable & Remove `snapd`
```
sudo systemctl stop snapd
sudo systemctl disable snapd
sudo systemctl mask snapd
sudo apt purge snapd
sudo apt autoremove --purge
rm -rf ~/snap
sudo rm -rf /var/cache/snapd/
sudo rm -rf /snap
```
6. Prevent reinstallation. Create an apt preference:
    `echo -e 'Package: snapd\nPin: release a=*\nPin-Priority: -10' | sudo tee /etc/apt/preferences.d/nosnap.pref`
    `sudo apt update`
7. Enable flatpak 
```
sudo apt install flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```
8. Install desired apps as flatpaks


