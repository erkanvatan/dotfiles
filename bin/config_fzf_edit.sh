#!/usr/bin/env bash

# Lists dotfiles tracked in .dotfiles bare repository using FZF
# in multi-select mode. You can select multiple files with <TAB>.
# Selected files are opened in user's preferred editor.

config="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

dotfile=$($config ls-tree --name-only -r --full-name master $HOME | sort | fzf) && $EDITOR $HOME/"$dotfile"
