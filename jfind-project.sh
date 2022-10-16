#!/bin/bash
set -e

match_project() {
    cwd=$(/bin/pwd -P)
    sed '/^$/d' ~/.config/jfind/projects | while read line 
    do
        if [[ "$cwd" == "$line"* ]]; then
            echo "$line"
            break;
        fi
    done
}

list_files() {
    exclude=(
        ".git"
        ".idea"
        ".vscode"
        ".sass-cache"
        ".class"
        "__pycache__"
        "node_modules"
        "target"
        "build"
        "tmp"
        "assets"
        "dist"
        "public"
    )
    exclude_str=$(printf ",%s" "${exclude[@]}")
    exclude_str=${exclude_str:1}
    fd -a -E "*.iml" --type f --base-directory "$1" --exclude="{$exclude_str}"
}

format_files() {
    awk '{
        split($0, path_parts, "/");
        num_parts = length(path_parts);
        first = num_parts == 1 ? "" : path_parts[num_parts - 1] "/";
        second = path_parts[length(path_parts)];
        print first second;
        print $0;
    }'
}


jfind_command() {
    jfind \
        --hints \
        --select-hint \
        --history="~/.cache/jfind-history/projects/$1"
}

project_root=$(match_project)
[ -z "$project_root" ] && exit 1

project_root=${project_root//\~/$HOME}
project_root=${project_root//\$HOME/$HOME}

list_files "$project_root" | format_files | jfind_command "$project_root" > ~/.cache/jfind_out
