alias pa='for repo in */; do echo "========== This is $repo ==========" && git -C "$repo" pull; done'
alias sa='for repo in */; do echo "========== This is $repo ==========" && git -C "$repo" status; done'

# alias gvim="neovide"
alias cdD='cd /media/Festplatte/Dokumente/Repos'
alias cdDp='cd /media/Festplatte/Dokumente/Repos&&pa'
alias cdR='cd ~/Repos&&pa'
alias py='python3'
alias venvh2="source ~/.venv/h2/bin/activate"
alias pomo="rg 'total office time' ~/.config/nvim/lua/plugins.lua "
alias pomobreak="rg -A 10 'local presets' ~/.config/nvim/lua/plugins.lua"

# alias connect-mouse='rfkill unblock bluetooth && sudo systemctl start bluetooth && bluetoothctl power on && bluetoothctl connect "$(bluetoothctl devices | grep -i '\''BT4.0+2.4G Mouse'\'' | awk '\''{print $2}'\'')"'
# alias thunderbird="flatpak run org.mozilla.Thunderbird"

alias rsynch2='rsync -avhP --delete  ~/Repos/h2project/ /servers/exp4_all/02_people/Shubbak_Abdulrahman/04-thesis/h2project/'
alias rsyncmaster='rsync -avhP --delete  ~/Repos/Masterthesis/ /servers/exp4_all/02_people/Shubbak_Abdulrahman/04-thesis/Masterthesis/'

alias pycalc='python3 -iq -c "import numpy as np; from numpy import *"'
alias scanimage='scanimage --format=png -d "airscan:w0:EPSON ET-2850 Series" --resolution 300'
alias rg='rg -S'

alias lt='eza -lob --total-size'
alias ls='eza'
alias ll='eza -lob'


alias linkinpark='vlc -q --qt-start-minimized $HOME/Audio/LinkinPark&'
alias cd=z
