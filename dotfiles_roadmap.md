# Dotfiles Improvement Roadmap

Work through this top to bottom — items at the top are either quick wins or fix real breakage.
Check off as you go.

---

## 🔴 Broken / Silent Failures (fix these first)

- [x] **`keybinds.zsh` is never sourced** — `config/zsh/keybinds.zsh` exists but nothing loads it. Add `source ~/.config/zsh/keybinds.zsh` in `.zshrc` or remove the file if it's unused.
- [ ] **NVM is not installed by any script** — `plugins.zsh` sources NVM on startup, but no setup script installs it. Add a NVM install step to `02_zsh.sh` (via the official curl installer).
- [x] **Syncthing is installed but never enabled** — add `systemctl enable --user syncthing` to `01_system.sh` after the package install step.
- [ ] **`set -euo pipefail` missing from subscripts** — it's only in `setup_arch.sh`. Add it to the top of every `scripts/0*.sh` so they're safe to run standalone too.

---

## 🟠 Will Lose Data / Cause Confusion on Fresh Install

- [x] **Back up `~/.ssh/config`** — not the keys, just the config (hostnames, `ServerAliveInterval`, agent forwarding). Add it to `config/` and a symlink in `05_symlinks.sh`.
- [ ] **Back up `~/.config/mimeapps.list`** — without this, default app associations (PDF → zathura, etc.) won't be set on a fresh machine. Add to `config/` and symlink it.
- [x] **Bluetooth not set up** — the `connect-mouse` alias requires `bluez-utils` and an enabled bluetooth service. Add `bluez-utils` to `package_list.txt` and `systemctl enable bluetooth` to `01_system.sh`.
- [ ] **`venvh2` alias and `master()` function silently fail** — they reference `~/.venv/h2` which no script creates. Either add a venv creation step to the setup, or add a note/guard that prints a helpful error when the venv doesn't exist.

---

## 🟡 Cleanup — Remove Dead/Duplicate Files

- [x] **Delete `p10k.zsh` from repo root** — duplicate of `config/zsh/prompt/.p10k.zsh`. Remove it.
- [ ] **Delete `config/zsh/prompt/starship.zsh`** — you use p10k, not Starship. Dead config.
- [ ] **Remove `package_lists/todo.txt`** from the repo (add to `.gitignore` or just delete it).
- [ ] **Clarify `explicitly_installed_packages_fresh_arch_installscript.txt`** — if it's an auto-generated snapshot, rename it to `packages-snapshot.txt` and add a one-line comment at the top explaining what it is. If it's redundant with `package_list.txt`, delete it.
- [x] **Remove the entire `oh-my-zsh/` directory** from the repo and add it to `.gitignore`. The install script in `02_zsh.sh` already installs it correctly at setup time — having a stale full copy committed serves no purpose and adds thousands of files.

---

## 🟡 Code Quality — Shell Scripts

- [ ] **Quote all variables in `03_hyprland.sh`** — `$dotdir/package_lists/...` should be `"$dotdir/package_lists/..."`. Always quote path variables in shell.
- [ ] **Add `--noconfirm` to `03_hyprland.sh`** — the `pacman` and `yay` calls there are missing it, unlike the rest of your scripts.
- [x] **Fix `06_cleanup.sh` name** — it doesn't clean up anything; it handles SDDM and the reboot prompt. Rename to `06_finish.sh` or `06_post_setup.sh`.
- [ ] **Remove leftover scaffold in `04_neovim.sh`** — the `# Helper functions` comment followed by blank lines and no functions is dead noise.
- [ ] **Fix LSP check logic in `04_neovim.sh`** — the `if pacman -Q pyright typescript-language-server ...` block only skips if ALL are installed. Replace it with a loop using `optional_install` (which you already have) so each LSP is checked individually.
- [ ] **Consider running subscripts as subprocesses** — `setup_arch.sh` uses `source` for all subscripts, meaning a crash halts everything. Consider `export dotdir` and running each script as `bash "$SCRIPTS/01_system.sh"` so they can succeed/fail independently.

---

## 🟡 Code Quality — Zsh

- [ ] **Strip boilerplate from `.zshrc`** — most of the file is commented-out OMZ template. Delete it all and keep only what's actually active. It's currently hard to see what's enabled at a glance.
- [ ] **Rename `plugins.zsh` to `tools.zsh` or `init.zsh`** — it contains NVM, fzf, and zoxide init, not OMZ plugin declarations. The name is misleading.
- [ ] **Clean up `env.zsh`** — it contains the p10k instant-prompt block and OMZ bootstrap, which are shell init, not environment variables. Move those to `.zshrc` and keep `env.zsh` to only `export` statements.
- [ ] **Move OMZ plugin list to match plugin loading** — `plugins=(git)` is in `.zshrc` but all other plugin setup is in `plugins.zsh`/`init.zsh`. Put them together.
- [x] **Fix `gitend()` calling a git alias** — `git ca` is a gitconfig alias, which can fail in non-interactive contexts. Inline it as `git commit -am "$1" && git push`.

---

## 🟢 Security

- [ ] **Replace `credential.helper = store` in `gitconfig`** — this stores passwords in plaintext at `~/.git-credentials`. Switch to `credential.helper = /usr/lib/git-core/git-credential-libsecret` (install `git-credential-libsecret` from the AUR if needed).

---

## 🟢 Nice to Have — New Configs to Add

- [ ] **`~/.config/gtk-3.0/settings.ini` and `gtk-4.0/settings.ini`** — back up cursor theme, icon theme, and dark mode preference. A fresh install will look unstyled until this is set.
- [ ] **`~/.config/environment.d/`** — for Wayland/systemd-level env vars (`EDITOR`, `BROWSER`, etc.) that need to be set before the session starts, not just inside zsh.
- [ ] **Update `README.md`** — it still mentions Ubuntu and WSL. Rewrite it to reflect the current Arch-only setup with the new script structure.
- [ ] **Obsidian config** — if you use community plugins, back up `.obsidian/` from your vault so plugin settings and hotkeys survive a reinstall.
- [ ] **`~/.local/bin/` scripts folder** — `scanpdf`, `mailpdf`, and similar functions in `functions.zsh` are substantial enough to live as standalone scripts here, versioned alongside everything else.
Tailscale or Wireguard Setup for syncthing on any network including Uni
symlinks to /usr/local/bin
