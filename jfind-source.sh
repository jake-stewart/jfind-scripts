#!/bin/bash
set -e

read_sources() {
    sed '/^$/d' ~/.config/jfind/sources
}

jfind_command() {
    ~/.bin/jfind \
        --hints \
        --select-hint \
        --history=~/.cache/jfind-history/sources
}

read_sources | jfind_command
