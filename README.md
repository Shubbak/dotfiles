# dotfiles

My personal configuration files for Arch Linux (primary) and Ubuntu/WSL.
Configs are stored in `~/Repos/dotfiles` and symlinked to their expected locations.

## Structure

```
dotfiles/
├── config/
│   ├── hypr/               # Hyprland window manager config
│   ├── nvim/               # Neovim config + install script
│   ├── waybar/             # Waybar status bar
│   └── zsh/                # Zsh config (.zshrc)
├── oh-my-zsh/              # Oh My Zsh customizations
├── sddm/                   # SDDM login manager customization
├── scripts/                # Modular setup sub-scripts
│   ├── 00_lib.sh              # Shared helper functions
│   ├── 01_system.sh        # System update + core packages
│   ├── 02_zsh.sh           # Zsh + Oh My Zsh + Powerlevel10k
│   ├── 03_hyprland.sh      # Hyprland packages + Neovim setup
│   ├── 04_neovim.sh           # yay install + AUR packages (prompted)
│   ├── 05_symlinks.sh      # Symlink creation
│   └── 06_cleanup.sh       # Optional removals + SDDM + reboot
├── package_lists/
│   ├── package_list.txt                # Core pacman packages
│   ├── optional_pacman.txt             # Optional pacman packages
│   ├── optional_yay.txt                # Optional AUR packages
│   ├── hyprland_installs.txt           # Hyprland-specific pacman packages
│   └── hyprland_installs_yay.txt       # Hyprland-specific AUR packages
├── gitconfig
├── latexmkrc
├── zathurarc
├── p10k.zsh                # Powerlevel10k prompt config
├── setup_arch.sh           # Arch Linux setup orchestrator
|-- archive
    ├── setup.sh                # Ubuntu setup script
    └── setup_WSL.sh            # WSL-specific setup script
```

## Usage

### Arch Linux

```bash
git clone https://github.com/Shubbak/dotfiles.git ~/Repos/dotfiles
cd ~/Repos/dotfiles
chmod +x setup_arch.sh
./setup_arch.sh
```

The script will:
1. Update the system and install core packages
2. Prompt you individually for each optional package
3. Install yay and prompt for AUR packages
4. Set up Zsh, Oh My Zsh, and Powerlevel10k
5. Install Hyprland packages and configure Neovim
6. Create all symlinks
7. Optionally remove conflicting packages, configure SDDM, and reboot

### Ubuntu / Debian

NOTE: Outdated and very likely will never be updated.

```bash
git clone https://github.com/Shubbak/dotfiles.git ~/Repos/dotfiles
cd ~/Repos/dotfiles
chmod +x setup.sh
./setup.sh
```

### WSL

NOTE: Outdated and very likely will never be updated.

```bash
chmod +x setup_WSL.sh
./setup_WSL.sh
```

## Symlinks created

| Dotfile | Symlinked to |
|---|---|
| `gitconfig` | `~/.gitconfig` |
| `latexmkrc` | `~/.latexmkrc` |
| `zathurarc` | `~/.config/zathura/zathurarc` |
| `config/zsh/.zshrc` | `~/.zshrc` |
| `config/zsh/` | `~/.config/zsh` |
| `config/hypr/` | `~/.config/hypr` |
| `config/waybar/` | `~/.config/waybar` |
| `config/nvim/` | `~/.config/nvim` |

## Machine-specific config

Hyprland configs that differ per machine (e.g. monitor layout, `hyprpaper.conf`)
live under `config/hypr/config/machines/<hostname>/`. The setup script detects
the current hostname and symlinks the correct machine config. If no config exists
for the current host, it falls back to `machines/fallback`.

To add a new machine:

```bash
mkdir config/hypr/config/machines/<your-hostname>
# add hyprpaper.conf and any machine-specific overrides
```

## SMB / Network drive

To mount a university SMB share on boot, see the instructions in the
[SMB section of the old README](https://github.com/Shubbak/dotfiles) or follow
these steps:

1. `sudo apt install cifs-utils` (Ubuntu) / `sudo pacman -S cifs-utils` (Arch)
2. Create mount point: `sudo mkdir -p /mnt/<dirname>`
3. Store credentials in `~/.smbcredentials`:
   ```
   username=uk123456
   password=PASSWORD
   domain=its-ad
   ```
4. Add to `/etc/fstab`:
   ```
   //smb.uni-kassel.de/exp4_all /mnt/<dirname> cifs credentials=/home/<user>/.smbcredentials,uid=1000,gid=1000,iocharset=utf8,vers=3.0,sec=ntlmssp 0 0
   ```
5. `sudo mount -a`

## Notes

- The `pullall` alias pulls all git repos inside the current directory. Make sure
  all subdirectories are git repos before using it, or it will error.
- Neovim replaces Vim/nano. After setup, confirm `$EDITOR=nvim` before removing nano.
- Fira Code Nerd Font should be installed manually for Powerlevel10k to render correctly.
- Use the fstab template but DO NOT replace the current fstab! Just `tee --append` and then edit manually.


## Disable snap on ubuntu

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


