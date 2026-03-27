#!/usr/bin/env bash

if ask_yes_no "Do you want to manage SDDM on a user-preference base?"; then
    sudo cp $dotdir/sddm/preferred.desktop /usr/share/wayland-sessions/preferred.desktop
    sudo cp $dotdir/sddm/launch_preferred_session /usr/local/bin/launch_preferred_session
fi

echo "Symlinks created!"

# configure p10k
if ask_yes_no "open new konsole to run p10k configuration wizard?"; then
    konsole --nofork &
fi

echo "==> Setup complete"
if ask_yes_no "Do you want to reboot now?"; then
    reboot 
fi
