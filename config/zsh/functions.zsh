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

        nvim bessy/phexphem.py
    fi
}

variation() {
    local project="$HOME/Repos/variationalcalculus/lecture"

    cd "$project" || return

    zathura script/deutsch/"${1:-09}"* & 
    konsole --new-tab --workdir "$project" -e "latexmk -pvc" &

    nvim "${2:-./221205.tex}"
}

scanpdf() {  
    filename=$1
    if ls "$1" &> /dev/null; then 
        read "over?Warning! "$1" already exists. Overwrite? (y/n)" 
        if ! [[ "$over" == "y" ]]; then
            return 1
        fi
    fi

    read "ans?Do you want [c]olour or [g]ray? "
    if [[ "$ans" == "c" ]]; then
        mode="color"
    else
        mode="gray"
    fi
    tmppdf=$(mktemp --suffix=pdf)
    tmpfiles=(); n=2; while true; do
    tmpfile=$(mktemp --suffix=pnm)
    scanimage --mode="$mode" --format=pnm -d "airscan:w0:EPSON ET-2850 Series" --resolution 150 > "$tmpfile"
    tmpfiles+=("$tmpfile")
        read "ans?Place page $n on the scanner and press Enter. Type q when finished. "
        [[ "$ans" == "q" ]] && break
        tmpfile=$(mktemp --suffix=pnm)
        scanimage --mode="$mode" --format=pnm -d "airscan:w0:EPSON ET-2850 Series" --resolution 150 > "$tmpfile"
        tmpfiles+=("$tmpfile")
        ((n++))
    done; img2pdf -s 300dpi -o "$tmppdf" "${tmpfiles[@]}" 
    rm -f "${tmpfiles[@]}"
    echo "The file has size: $(/usr/bin/ls -sh $tmppdf)"
    read "ans?Do you want to [c]ompress the pdf or [n]ot (recommended for text on screen, not for printing or for pictures)? "
    if [[ "$ans" == "c" ]] ; then
        gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.5 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile="$filename" "$tmppdf"
    else
        mv "$tmppdf" "$filename"
        rm -f "$tmppdf"
    fi

}


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

nvim_now(){
    nvim "$(date +%F_%H-%M-%S)".md
}

masterbericht() {
  local file="${1:-$HOME/Obsidian/Notizen/Masterarbeit Status.md}"
  local first_hash=$(git log --since="3 week ago" --reverse --format="%H" | head -1)
  git diff "$first_hash" > /tmp/_diff
  #awk '/^### Code$/ { print; while ((getline line < "/tmp/_diff") > 0) print line; next } 1' "$file" > /tmp/_weeks_code && mv /tmp/_weeks_code "$file"
  awk '/^### Code$/ && !done { print; print "\`\`\`diff"; while ((getline line < "/tmp/_diff") > 0) print line; print "\`\`\`"; done=1; next } 1' "$file" > /tmp/_weeks_code && mv /tmp/_weeks_code "$file"
  pandoc -o $HOME/Repos/Masterthesis/Bericht.pdf "$file" --pdf-engine=lualatex -V mainfont="DejaVu Sans"    
}


