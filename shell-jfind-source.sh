jfind_source() {
    dest=$(~/.config/jfind/jfind-source.sh)
    dest=${${dest//\~/$HOME}//\$HOME/$HOME}
    if [ -d "$dest" ]; then
        cd "$dest";
        [ "$dest" = "$HOME/Downloads" ] && ls -trl || ls
    elif [ -f "$dest" ]; then
        nvim "$dest"
    fi
}

