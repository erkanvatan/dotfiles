# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repository is

Personal Linux dotfiles for `erkanvatan`, managed as a **Git bare repository** whose work-tree is
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

## Machine setup and updates (`Taskfile.yml`, go-task)

The closest thing to "build/run" commands in this repo is `Taskfile.yml` at the repo root, run via
the [go-task](https://taskfile.dev) `task` binary (zsh completions for it are already wired up in
`.zshrc`). It replaced the old `apt_install.sh`/`install.sh` pair — the same steps now live under
`.config/dotfiles/taskfiles/*.yml` (`apt`, `appimage`, `lang`, `cli`, `utility`), each included
into the root Taskfile as a namespace (e.g. `task apt:install`, `task lang:update`). Run `task --list`
for the full task list.

- **First time on a machine without `task` yet:** `bash .config/dotfiles/bootstrap.sh`, then run
  `task setup GIT_NAME="Your Name" GIT_EMAIL=you@example.com SSH_KEY_PASSPHRASE=...` — these three
  are required vars on `setup` (and threaded down to the `cli` taskfile's `keygen`/`git-identity`
  tasks); missing any of them fails fast before any install steps run.
- **`task setup`** — fresh machine: apt packages/PPAs/font, the `rootfs/` overlay, language runtimes
  (nvm/node, pyenv/python, pipx), SSH keygen, per-user CLI tools (git identity/signing, Prezto/TPM
  submodules + plugins, `~/programs/{swift-map,core}`, fzf, npm/pipx/cargo apps), AppImageLauncher +
  AppImage manifest, then `task doctor`.
- **`task update`** — the update-only subset of the same steps (no PPA re-adds, no SSH keygen), plus
  updating `task` itself first.
- Package lists live inline as `vars:` in the taskfiles rather than separate files: apt packages/PPAs
  in `apt.yml` (`PACKAGES`/`PPAS`), and npm/pipx/cargo packages in `cli.yml` (`NPM_PKGS`/`PIPX_PKGS`/
  `CARGO_PKGS`) — one entry per line, `#` comments allowed. Add or remove software there rather than
  editing the task logic.
- Distro support is detected from `/etc/os-release` (Ubuntu and Ubuntu-based distros, including Linux
  Mint) rather than passed as an argument.

### AppImages (`.config/dotfiles/taskfiles/appimage.yml`)

AppImage-only GUI apps are declared in a small manifest (`name|owner/repo|asset-glob|optional-bin-symlink`)
at the top of `appimage.yml`. `task appimage:update` uses `scripts/appimage-get` to pull the newest
matching release asset from GitHub into `~/Applications`; [AppImageLauncher](https://github.com/TheAssassin/AppImageLauncher)
(installed via `task appimage:setup` from a GitHub release .deb, since its PPA is deprecated) watches
that folder and adds/updates the application-menu entry. `task appimage:list` shows installed versions.
Before adding an app to the manifest, check its GitHub releases actually ship an `.AppImage` asset —
several commonly-assumed ones (Anki, Telegram Desktop, sqlectron) do not.

There is no offline/no-internet install path anymore — the old `prepare_offline.sh`/`install_offline.sh`
pair was removed along with the rest of `.config/dotfiles/install/` when this moved to the Taskfile.

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

- No need for a .gitignore file as the intended purpose of this repo is to be used as bare repo.
- Never run task commands without asking first as a bug can break a running system.

## Taskfile Development Notes

- Use required Taskfile variables when a user input is needed. Don't take input with bash commands.
- Use "{{.ROOT_DIR}}/scripts/task-note" script when printing important information for the user.
- Always keep list of packages alphabetically sorted such as APT_PKGS, NPM_PKGS, etcPACKAGES.
