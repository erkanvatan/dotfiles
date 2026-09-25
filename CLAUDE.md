# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repository is

Personal Linux dotfiles for `erkanvatan`, managed as a **Git bare repository** whose work-tree is
`$HOME` itself. There is no build step, package.json, or test suite — this is a config/scripts repo,
and the repository root corresponds directly to `$HOME` on the target machine (e.g. `.zshrc` here is
`~/.zshrc` on disk, `.config/nvim/init.vim` here is `~/.config/nvim/init.vim`). Keep that mapping in
mind: paths in scripts/configs are written relative to `$HOME`, not relative to this repo checked out
elsewhere.

Covers: Alacritty, Zsh (Prezto + Powerlevel10k), Tmux (TPM), Neovim/Vim (vim-plug), clangd, Claude Code,
plus Catppuccin/Qogir theming and a handful of custom shell utilities.

## Rules

- Never run `task` commands or `scripts/config-sync` without asking first. Both change the live
  machine, and a bug can break a running system.
- Use Linux (LF) line endings for all files.
- No `.gitignore`. The repo is used as a bare repo over `$HOME`, which hides untracked files instead.
- Taskfiles:
  - When a task needs user input, use a `requires:` var. Never read input with bash (`read` etc.).
  - Print anything the user must see or act on with `"{{.ROOT_DIR}}/scripts/task-note"`.
  - Keep every package list (`APT_PKGS`, `NPM_PKGS`, `PIPX_PKGS`, `CARGO_PKGS`, …) alphabetically sorted.
- Commit with the `git-commit` skill (conventional commits) rather than hand-rolled commit commands.

## Working with this repo

On a real machine the repo is used through the `config` alias defined in `.zshrc`:

```sh
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias config-edit="(export GIT_DIR=$HOME/.dotfiles; export GIT_WORK_TREE=$HOME; $EDITOR)"
```

`config status` only lists *tracked* files (`task utility:bare-install` sets
`status.showUntrackedFiles no`), or it would list all of `$HOME`. A new file therefore does not appear
until `config add`.

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

`Taskfile.yml` at the repo root is the closest thing to "build/run", run with the
[go-task](https://taskfile.dev) `task` binary. The real steps live in `.config/dotfiles/taskfiles/*.yml`
(`apt`, `appimage`, `lang`, `cli`, `theme`, `utility`), each included as a namespace (e.g.
`task apt:install`). `task --list` shows everything.

- **Brand-new machine, no `task` yet:** clone to a throwaway folder, `bash .config/dotfiles/bootstrap.sh`,
  `task utility:bare-install` (turns `$HOME` into the checkout; `REPO` defaults to that clone's origin
  URL), then from `$HOME`:
  `task setup GIT_NAME="Your Name" GIT_EMAIL=you@example.com SSH_KEY_PASSPHRASE=...`.
  All three vars are `requires:`d on `setup` and threaded down to `cli:keygen`/`cli:git-identity`, so a
  missing one fails before anything installs.
- `setup` and `update` both have a precondition that `$HOME/.dotfiles` is a real bare repo, i.e.
  `task utility:bare-install` ran first.
- **`task setup`** — `preflight`, apt packages/PPAs, language runtimes, per-user CLI tools, the Qogir GTK
  theme, AppImageLauncher + AppImages, then `doctor`. That `doctor` has `ignore_error: true`: the login
  shell and the AppImageLauncher daemon only show clean after a log out/in. It ends by printing the new
  SSH public key to add on GitHub as *both* an authentication and a signing key.
- **`task update`** — the repeatable subset (no PPA re-adds, no SSH keygen), plus `submodules`.
- **`task self-update`** — updates `task` itself. Deliberately separate from `update`.
- **`task doctor`** — checks core tool versions, that the login shell is zsh and `appimagelauncherd` is
  running, and lists installed AppImages/npm globals/pipx apps. Exits non-zero if anything is missing.
- **`preflight`** (internal) — reads `/etc/os-release` and only allows Ubuntu and Ubuntu-based distros
  (including Linux Mint). The distro is never passed as an argument.

Behaviour that isn't obvious from task names:

- `apt:install` falls back to one-package-at-a-time if the bulk install fails, so one bad or renamed
  package name doesn't block the rest.
- `lang:update` moves Python to the newest patch inside `PYTHON_SERIES` (major.minor), never to a new
  minor. Bump `PYTHON_SERIES` in `lang.yml` for that.
- Package lists live inline as `vars:` at the top of each taskfile, one entry per line, `#` comments
  allowed: `APT_PKGS`/`PPAS` in `apt.yml`, `NPM_PKGS`/`PIPX_PKGS`/`CARGO_PKGS` in `cli.yml`, `APPS` in
  `appimage.yml`. Add or remove software there rather than editing task logic.

### GTK theme (`.config/dotfiles/taskfiles/theme.yml`)

`task theme:install` shallow-clones [Qogir-theme](https://github.com/vinceliuice/Qogir-theme) into a temp
dir and runs its `install.sh` into `~/.themes` with `--color standard dark --tweaks image square`. That
produces exactly the `Qogir`/`Qogir-Dark` names `scripts/toggle-system-theme` switches between. It needs
`sassc` (and `gtk2-engines-murrine` for GTK2 apps), both in `APT_PKGS`. `theme:update` rebuilds from the
newest upstream commit. Icons are Papirus, not Qogir-icon-theme: `papirus-icon-theme` from the
`ppa:papirus/papirus` PPA, so apt keeps it current.

### AppImages (`.config/dotfiles/taskfiles/appimage.yml`)

AppImage-only apps are declared in the `APPS` manifest (`name|owner/repo|asset-glob|optional-bin-symlink`).
`task appimage:update` uses `scripts/appimage-get` to pull the newest matching GitHub release asset into
`~/Applications`. [AppImageLauncher](https://github.com/TheAssassin/AppImageLauncher) watches that folder
and manages menu entries; `task appimage:setup` installs it from a pinned release .deb (`AIL_VERSION` and
`AIL_DEB` must be bumped together) since its PPA is deprecated.

- **Neovim itself comes from here**, not apt: the `neovim` entry symlinks the AppImage to
  `~/.local/bin/nvim`.
- Before adding an app, check its GitHub releases actually ship an `.AppImage` asset — several commonly
  assumed ones (Anki, Telegram Desktop, sqlectron) do not.

There is no offline install path. The old `.config/dotfiles/install/` scripts were removed when this
moved to the Taskfile.

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

Standalone bash utilities (not sourced by `.zshrc`): `any-term-dropdown`, `appimage-get`, `config-fzf`,
`config-sync`, `print-term-colors`, `setup-ip-forwarding`, `sub-to-utf8`, `task-note`,
`toggle-system-theme`. They're invoked directly (bound to a keyboard shortcut or window-manager action, or
called from a task), not part of any build pipeline.

New scripts copy the existing header: a `# ----------------` block with `@file`, `@author`, `@date`,
`@brief`, and one `@depend` line per external command (package name, e.g. `libnotify-bin`).

## Claude Code config (`.claude/`)

`.claude/` here is `~/.claude/` on the machine. That makes it the **user-level** Claude Code config for
every project, not just this repo — a change here changes every session.

- `settings.json` — empty commit/PR attribution (no co-author trailers), denies `Bash(rm:*)` and
  `Bash(rmdir:*)`, wires up the status line and the hook below. `claudeMdExcludes: ["/home/*/CLAUDE.md"]`
  exists because this file lands at `~/CLAUDE.md`, which would otherwise load in every project under
  `$HOME`.
- `hooks/inject-context.py` — `UserPromptSubmit` hook that injects the global working rules (DRY/YAGNI/
  KISS, halt after plans, `trash` instead of `rm`, `mv -n`). Change those rules there, not in a
  CLAUDE.md.
- `statusline.py` — powerline-style status line in Catppuccin Mocha colours.
- `output-styles/eli5.md` — the ELI5 output style (set as default in `settings.json`).
- `skills/` — `git-commit` and `create-readme`.
