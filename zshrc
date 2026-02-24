export EDITOR="nvim"
export VISUAL="nvim"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias pullall='for repo in */; do echo "========== This is $repo ==========" && git -C "$repo" pull; done'
alias statusall='for repo in */; do echo "========== This is $repo ==========" && git -C "$repo" status; done'

alias gvim="neovide"
alias cdD='cd /media/Festplatte/Dokumente/Repos'
alias cdDp='cd /media/Festplatte/Dokumente/Repos&&pullall'
alias cdR='cd ~/Repos&&pullall'
alias py='python3'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# Cowsay

animals=("default"
    "tux"
    "elephant"
    "sheep"
    "cock"
    "fox"
    "gnu"
    "kangaroo"
    "moose"
    "stegosaurus")
random_animal=${animals[$((RANDOM % ${#animals[@]}))]}
if [ "$random_animal" = "" ]; then
    random_animal="default"
fi
phrases=("Are you working?"
    "Die Masterarbeit macht sich nicht von selbst."
    "Bismillah."
    "Wie läuft die Masterarbeit?"
    "Denk an Layla und Lina."
    "Du musst fertig werden."
    "Tawakkal ʿala Allah."
    "al-Ǧidd, al-Ǧidd"
    "Erneuere deine Niyyah."
    "Warum arbeitest du?"
    "Denkst du an die Pomodoro-Technik?"
    "Fleiß wie Imām al-Buḫāriy."
    "Fleiß wie Imām Šuʿba."
    "Mooo"
    "Ummatī, Ummatī."
    "Ummatuka bi Ḥāǧatik."
    "Ya Allah"
    "Ya Rabb al-ʿālamīn."
    "Ya Rabb"
    "Allahumma aʿinnī."
    "Bismillah, Yallah!")
random_phrase=${phrases[$((RANDOM % ${#phrases[@]}))]}
if [ "$random_phrase" = "" ]; then
  random_phrase="Bismillah."
fi
echo "$random_phrase" | cowsay -f "$random_animal"

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

function duse() {  # usage: duse(max-depth, location) def.: 2, .
    if [ "$1" != "" ]; then 
        if [ "$2" != "" ]; then
            du "$2" -h --max-depth="$1" | sort -h
        else
            du . -h --max-depth="$1" | sort -h
        fi
    else
        if [ "$2" != "" ]; then
            du "$2" -h --max-depth=2 | sort -h
        else
            du . -h --max-depth=2 | sort -h
        fi
    fi
}

function gitend() {
    git ca "$1" && git push
}

alias venvh2="source ~/.venv/h2/bin/activate"
alias pomo="rg 'total office time' ~/.config/nvim/lua/plugins.lua "
alias pomobreak="rg -A 10 'local presets' ~/.config/nvim/lua/plugins.lua"

alias connect-mouse='rfkill unblock bluetooth && sudo systemctl start bluetooth && bluetoothctl power on && bluetoothctl connect "$(bluetoothctl devices | grep -i '\''BT4.0+2.4G Mouse'\'' | awk '\''{print $2}'\'')"'
# alias thunderbird="flatpak run org.mozilla.Thunderbird"

alias rsynch2='rsync -avhP --delete  ~/Repos/h2project/ /servers/exp4_all/02_people/Shubbak_Abdulrahman/04-thesis/h2project/'
alias rsyncmaster='rsync -avhP --delete  ~/Repos/Masterthesis/ /servers/exp4_all/02_people/Shubbak_Abdulrahman/04-thesis/Masterthesis/'

alias pycalc='python3 -iq -c "import numpy as np; from numpy import *"'


# Flatpak Thunderbird helper
mailpdf() {
    if [ $# -ne 4 ]; then
        echo "Usage: mailpdf recipient subject body file"
        return 1
    fi

    local to="$1"
    local subject="$2"
    local body="$3"
    local file="$4"

    # Make sure file exists
    if [ ! -f "$file" ]; then
        echo "File not found: $file"
        return 1
    fi

    # Run Thunderbird via Flatpak with proper quoting
    thunderbird -compose \
        "to='$to',subject='$subject',body='$body',attachment='file://$(realpath "$file")'"
}


master() {
    local project_dir="$HOME/Repos/h2project"
    local tex_dir="$HOME/Repos/Masterthesis"
    local venv_dir="$HOME/.venv/h2/"

    if [ "$1" = "tex" ]; then
        cd "$tex_dir" || return

        konsole --new-tab --workdir $tex_dir -e "latexmk -pvc" &

        nvim content/"${2:-02_theorie.tex}"
    else
        cd "$project_dir" || return
        source "$venv_dir/bin/activate"

        konsole &

        nvim simulation
    fi
}

variation() {
    local project="$HOME/Repos/variationalcalculus/lecture"

    cd "$project" || return

    zathura script/deutsch/"${1:-09}"* & 
    konsole --new-tab --workdir "$project" -e "latexmk -pvc" &

    nvim "${2:-./221205.tex}"
}


alias scanimage='scanimage --format=pnm -d "airscan:e0:ET2850" --resolution 300'

scanpdf() {
    filename=$1
    tmpfiles=(); n=2; while true; do
    tmpfile=$(mktemp --suffix=pnm)
    scanimage --format=pnm -d "airscan:e0:ET2850" --resolution 300 > "$tmpfile"
    tmpfiles+=("$tmpfile")
        read "ans?Place page $n on the scanner and press Enter. Type q when finished. "
        [[ "$ans" == "q" ]] && break
        tmpfile=$(mktemp --suffix=pnm)
        scanimage --format=pnm -d "airscan:e0:ET2850" --resolution 300 > "$tmpfile"
        tmpfiles+=("$tmpfile")
        ((n++))
    done; img2pdf "${tmpfiles[@]}" -o "$filename"
    rm -f "${tmpfiles[@]}"
}


alias rg='rg -S'
