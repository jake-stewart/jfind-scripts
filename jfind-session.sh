#!/bin/bash
set -e

read_sessions() {
    sed '/^$/d' ~/.config/jfind/sessions
}

jfind_command() {
    ~/.bin/jfind --hints --select-both --query="$1"
}

read_sessions | sed "s:\\~:$HOME:" | jfind_command
