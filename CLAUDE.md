# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repository is

Personal Linux dotfiles for `erkanvatan`, managed as a **Git bare repository** whose work-tree is
`$HOME` itself. There is no build step, package.json, or test suite — this is a config/scripts repo,
and the repository root corresponds directly to `$HOME` on the target machine (e.g. `.zshrc` here is
`~/.zshrc` on disk, `.config/nvim/init.vim` here is `~/.config/nvim/init.vim`). Keep that mapping in
mind: paths in scripts/configs are written relative to `$HOME`, not relative to this repo checked out
elsewhere.

Covers: Alacritty, Zsh (Prezto + Powerlevel10k), Tmux (TPM), Neovim/Vim (vim-plug), plus Catppuccin/Qogir
theming and a handful of custom shell utilities.

## Working with this repo

On a real machine the repo is used through the `config` alias defined in `.zshrc`:

```sh
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias config-edit="(export GIT_DIR=$HOME/.dotfiles; export GIT_WORK_TREE=$HOME; $EDITOR)"
```

`config status` only lists *tracked* files — untracked ones are hidden, or it would list all of `$HOME`.
A new file therefore does not appear until `config add`.

A normal clone elsewhere (e.g. `~/projects/personal/dotfiles`) works fine for editing, but edits there
are not live. To test them against the real `$HOME` work-tree, run `scripts/config-sync` **from the root
of that checkout**: it rsyncs the checkout into `$HOME` (previewing and confirming the first sync), then
re-syncs on every file change until Ctrl+C. It skips `.git` and every submodule path. It needs `rsync`
and `entr`.

Submodules are used for third-party frameworks rather than vendoring them: `.zprezto`,
`.zprezto-contrib/{zsh-z,zsh-you-should-use,zsh-bat,fzf-tab}`, `.tmux/plugins/tpm`, `.fzf`,
`programs/swift-map`, `programs/wmutils-core`. After cloning/pulling they need
`git submodule update --init --remote --recursive` (wrapped as the internal `submodules` task).

## Machine setup and updates (`Taskfile.yml`, go-task)

The closest thing to "build/run" commands is `Taskfile.yml` at the repo root, run via the
[go-task](https://taskfile.dev) `task` binary (zsh completions are wired up in `.zshrc`). The real steps
live under `.config/dotfiles/taskfiles/*.yml` (`apt`, `appimage`, `lang`, `cli`, `theme`, `utility`), each
included into the root Taskfile as a namespace (e.g. `task apt:install`, `task lang:update`). Run
`task --list` for the full list.

- **Brand-new machine, no `task` yet:** clone to a throwaway folder, `bash .config/dotfiles/bootstrap.sh`,
  `task utility:bare-install` (turns `$HOME` into the checkout; `REPO` defaults to that clone's own
  origin URL), then from `$HOME`:
  `task setup GIT_NAME="Your Name" GIT_EMAIL=you@example.com SSH_KEY_PASSPHRASE=...`.
  Those three vars are `requires:`d on `setup` and threaded down to `cli:keygen`/`cli:git-identity`;
  missing any of them fails fast before any install step runs.
- Both `setup` and `update` have a **precondition** that `$HOME/.dotfiles` is a real bare repo — i.e.
  `task utility:bare-install` must have happened first — and say so in the failure message.
- **`task setup`** — fresh machine: `preflight` (distro check + sudo prime), apt packages/PPAs,
  language runtimes, per-user CLI tools, the Qogir GTK theme, AppImageLauncher + AppImages, then
  `doctor`. That closing `doctor` runs with `ignore_error: true`: on a brand-new machine the shell and
  the AppImageLauncher daemon can't show clean until you log out and back in, so `setup` prints that
  note and leaves the real check for after. It also prints the new SSH public key to register with
  GitHub as *both* an authentication and a signing key.
- **`task update`** — the update-only subset (no PPA re-adds, no SSH keygen), plus `submodules`.
  `apt:install`'s bulk install falls back to installing packages one at a time if the bulk call fails,
  so one bad/renamed package name doesn't block the rest. `lang:update` advances Python to the newest
  patch inside its current major.minor series (`PYTHON_SERIES`), not just pyenv/node/pipx/go themselves.
- **`task self-update`** updates `task` itself — deliberately separate and manual.
- **`task doctor`** prints versions of task/nvm/node/pyenv/python/pipx/go, checks the login shell is zsh
  and `appimagelauncherd` is running, then lists AppImages, npm globals and pipx packages. It exits
  non-zero if anything is missing.
- Package lists live inline as `vars:` at the top of each taskfile, not in separate files: apt packages
  and PPAs in `apt.yml` (`APT_PKGS`/`PPAS`), npm/pipx/cargo packages in `cli.yml`
  (`NPM_PKGS`/`PIPX_PKGS`/`CARGO_PKGS`), the pyenv series (`PYTHON_SERIES`) in `lang.yml` — one entry
  per line, `#` comments allowed. Add or remove software there rather than editing task logic.
- Distro support is detected from `/etc/os-release` by the `preflight` task (Ubuntu and Ubuntu-based,
  including Linux Mint) rather than passed as an argument.

### GTK theme (`.config/dotfiles/taskfiles/theme.yml`)

`task theme:install` clones [Qogir-theme](https://github.com/vinceliuice/Qogir-theme) shallowly into a
temp dir and runs its `install.sh` into `~/.themes` with `--color standard dark --tweaks image square`,
producing exactly the `Qogir`/`Qogir-Dark` names `scripts/toggle-system-theme` switches between. It needs
`sassc` (and `gtk2-engines-murrine` for GTK2 apps), both in `APT_PKGS`. `theme:update` rebuilds from the
newest upstream commit; `theme:list` shows what's in `~/.themes`. Icons come from Papirus instead
of Qogir-icon-theme: `papirus-icon-theme` in `APT_PKGS`, from the `ppa:papirus/papirus` PPA in
`PPAS`, so apt keeps it current.

### AppImages (`.config/dotfiles/taskfiles/appimage.yml`)

AppImage-only GUI apps are declared in a small manifest (`name|owner/repo|asset-glob|optional-bin-symlink`)
in that file's `APPS` var. `task appimage:update` uses `scripts/appimage-get` to pull the newest matching
release asset from GitHub into `~/Applications`; [AppImageLauncher](https://github.com/TheAssassin/AppImageLauncher)
(installed by `task appimage:setup` from a pinned GitHub release .deb, since its PPA is deprecated)
watches that folder and adds/updates the menu entry. `task appimage:list` shows installed versions.
Before adding an app, check its GitHub releases actually ship an `.AppImage` asset — several commonly
assumed ones (Anki, Telegram Desktop, sqlectron) do not.

There is no offline/no-internet install path — the old `prepare_offline.sh`/`install_offline.sh` pair
was removed along with the rest of `.config/dotfiles/install/` when this moved to the Taskfile.

## Shell and editor config structure

`.zshrc` and `.config/nvim/init.vim` are both organized under explicit numbered section banners
(`_FUNCTIONS_`, `_SCRIPT_SOURCE_`, `_ALIASES_`, `_SETTINGS_`, `_PROGRAM_INIT_` for zsh;
`_EDITOR_CONFIGS_`, `_FUNCTIONS_`, `_KEYBINDINGS_`, `_LATE_IMPORTS_` for nvim), each file opening with a
table-of-contents block listing them. When editing, put new lines under the matching existing section
rather than appending ad hoc — these files are hand-curated and the banners are the intended navigation aid.

Neovim plugins are declared separately in `.config/nvim/plugins.vim` (vim-plug), loaded from `init.vim`;
language snippets live under `.config/nvim/UltiSnips/*.snippets` (one file per filetype). Theme switching
is shared across programs: `init.vim`'s `_ToggleBackground_`/`_LightlinePalette_` functions flip Catppuccin
flavour inside Neovim, while `scripts/toggle-system-theme` flips the Qogir GTK theme and the Papirus
icon theme system-wide.

## Custom scripts (`scripts/`)

Standalone bash utilities (not sourced by `.zshrc`), each with a `@file`/`@author`/`@date`/`@brief` header
and `@depend` lines for external commands: `any-term-dropdown`, `appimage-get`, `config-fzf`,
`config-sync`, `print-term-colors`, `setup-ip-forwarding`, `sub-to-utf8`, `task-note`,
`toggle-system-theme`. They're invoked directly (bound to a keyboard shortcut or window-manager action, or
called from a task), not part of any build pipeline. Follow that header style for new scripts.

## Claude Code config in this repo (`.claude/`)

`.claude/settings.json` is itself tracked here: it denies `Bash(rm:*)`/`Bash(rmdir:*)`, sets an empty
commit/PR attribution, and runs `~/.claude/hooks/inject-context.py` on every prompt submit. Two repo-local
skills live in `.claude/skills/`: `git-commit` (conventional-commit staging and message generation) and
`create-readme`. Prefer the `git-commit` skill over hand-rolled commit commands.

## Development Notes

- Use Linux line-endings for all files.
- No need for a .gitignore file as the intended purpose of this repo is to be used as bare repo.
- Never run task commands without asking first as a bug can break a running system.

## Taskfile Development Notes

- Use required Taskfile variables when a user input is needed. Don't take input with bash commands.
- Use "{{.ROOT_DIR}}/scripts/task-note" script when printing important information for the user.
- Always keep list of packages alphabetically sorted such as APT_PKGS, NPM_PKGS, etc.
