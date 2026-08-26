#!/usr/bin/env bash
# ----------------
# @file bootstrap.sh
# @author arensonz
# @date 2026-08-25
# @brief One-time entry point for a machine that doesn't have `task` (go-task)
#        yet. Installs it into ~/.local/bin, which is already first on $PATH
#        (see .zshenv). Everything after this is driven by Taskfile.yml at
#        the repo root - run `task --list` to see what's available.
#
#        usage: bash .config/dotfiles/bootstrap.sh
# ----------------

set -e

if ! command -v curl >/dev/null; then
    echo "# INSTALLING CURL #"
    sudo apt-get update -qq
    sudo apt-get install -y curl
fi

mkdir -p "$HOME/.local/bin"
sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b "$HOME/.local/bin"

echo
echo "> task installed to $HOME/.local/bin/task <"
if [[ -d "$HOME/.dotfiles" ]]; then
    if [[ ! -f "$HOME/.config/dotfiles/.env" ]]; then
        echo "W: $HOME/.config/dotfiles/.env is missing - copy .env.example and fill in values first:" >&2
        echo "     cp $HOME/.config/dotfiles/.env.example $HOME/.config/dotfiles/.env" >&2
    fi
    echo "Now run: task setup"
else
    echo "Now run: task utility:bare-install REPO=<your fork's clone URL>"
fi
