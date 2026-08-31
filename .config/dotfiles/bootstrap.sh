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

note() {
    printf '\033[1;36m==>\033[0m \033[1m%s\033[0m\n' "$1"
}

if ! command -v curl >/dev/null; then
    echo "W: curl dependency is missing, installing via apt"
    sudo apt-get update -qq
    sudo apt-get install -y curl
fi

mkdir -p "$HOME/.local/bin"
sh -c "$(curl --fail --silent --show-error --location https://taskfile.dev/install.sh)" -- -d -b "$HOME/.local/bin"

echo "task installed to $HOME/.local/bin/task"
if ! command -v task >/dev/null; then
    note "$HOME/.local/bin is not on PATH yet in this shell - run this first:" >&2
    note "    export PATH=\"$HOME/.local/bin:\$PATH\"" >&2
fi
if [[ -d "$HOME/.dotfiles" ]]; then
    note 'Now run: task setup GIT_NAME="Your Name" GIT_EMAIL=you@example.com SSH_KEY_PASSPHRASE=...'
else
    note "Now run: task utility:bare-install"
fi
