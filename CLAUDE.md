# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repository is

Personal Linux dotfiles for `arensonzz`, managed as a **Git bare repository** whose work-tree is
`$HOME` itself. There is no build step, package.json, or test suite — this is a config/scripts repo,
and the repository root corresponds directly to `$HOME` on the target machine (e.g. `.zshrc` here is
`~/.zshrc` on disk, `.config/nvim/init.vim` here is `~/.config/nvim/init.vim`, etc.). Keep that mapping
in mind: paths in scripts/configs are written relative to `$HOME`, not relative to this repo checked
out elsewhere.

Covers: Alacritty, Zsh (Prezto + Powerlevel10k), Tmux (TPM), Neovim/Vim (vim-plug), plus Catppuccin/Qogir
theming and a handful of custom shell utilities.

## Working with this repo

Because it's a bare repo overlaid on `$HOME`, a normal `git` clone/checkout of it elsewhere works fine
for editing, but the *intended* usage on a real machine is via the `config` alias defined in `.zshrc`:

```sh
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias config-edit="(export GIT_DIR=$HOME/.dotfiles; export GIT_WORK_TREE=$HOME; $EDITOR)"
```

Submodules are used for third-party plugin frameworks rather than vendoring them:
`.zprezto`, `.zprezto-contrib/{zsh-z,zsh-you-should-use,zsh-bat,fzf-tab}`, `.tmux/plugins/tpm`,
`programs/swift-map`. After cloning/pulling, submodules need `git submodule update --init --remote --recursive`.

## Machine setup scripts (`.config/dotfiles/install/`)

These are the closest thing to "build/run" commands in this repo — they provision a fresh Ubuntu machine:

- `apt_install.sh <distro> <email>` — run with `sudo`; installs apt packages, PPAs, and fonts (MesloLGS NF).
- `install.sh <distro> <email>` — run **without** sudo; clones Prezto/TPM/swift-map, installs nvim/nvm/pyenv/pipx/fzf/cargo tools, sets up SSH keys. Only `UBUNTU` is a supported `$1`.
- `prepare_offline.sh` / `install_offline.sh` — package up (`prepare_offline.sh main`) and later restore (`install_offline.sh main`) plugin/cache directories (vim/nvim plugins+CoC, tmux plugins, tldr cache, prezto, cargo bins) for machines without internet access. Each supports being called with a single sub-function name (`dotfiles`, `vim`, `tmux`, `tldr`, `prezto`, `cargo`) instead of `main`.

`.config/dotfiles/rootfs/` is a literal filesystem overlay (e.g. `etc/lightdm/...`, `usr/share/backgrounds/...`)
meant to be copied to `/` on the target system, not sourced by anything automatically.

## Shell config structure

`.zshrc` and `.config/nvim/init.vim` are both organized under explicit numbered section banners
(`_FUNCTIONS_`, `_SCRIPT_SOURCE_`, `_ALIASES_`, `_SETTINGS_`, `_PROGRAM_INIT_` for zsh;
`_EDITOR_CONFIGS_`, `_FUNCTIONS_`, `_KEYBINDINGS_`, `_LATE_IMPORTS_` for nvim). When editing, keep new
lines under the matching existing section rather than appending ad hoc — these files are hand-curated
and the section banners are the intended navigation aid.

Neovim plugins are declared separately in `.config/nvim/plugins.vim` (vim-plug), loaded from `init.vim`;
language snippets live under `.config/nvim/UltiSnips/*.snippets` (one file per filetype).

## Custom scripts (`scripts/`)

Standalone bash utilities (not sourced by `.zshrc`), each with a `@file`/`@author`/`@date` header:
`any-term-dropdown`, `config-fzf` (fzf picker over dotfiles-tracked files, paired with the `config-edit`
alias), `launch-alacritty-vm`, `launch-swift-map`, `print-term-colors`, `setup-ip-forwarding`,
`toggle-system-theme`. They're invoked directly (e.g. bound to a keyboard shortcut or window manager
action), not part of any install/build pipeline.

## Development Notes

-
