#!/usr/bin/env bash

# Lists modified dotfiles in the .dotfiles bare repository using FZF
# in multi-select mode. You can select multiple files with <TAB>.
# Selected files are stashed.
#
# This script is a solution to shell not providing autocomplete for
# file names in bare repositories issue.

dot_dir="$HOME/.dotfiles"
config="/usr/bin/git --git-dir=$dot_dir --work-tree=$HOME"

pushd $HOME >/dev/null
dotfile=$($config diff --name-only | sort | fzf -m) && $config add $dotfile
popd >/dev/null
