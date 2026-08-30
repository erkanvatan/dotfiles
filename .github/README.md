# Dotfiles

All of my Linux config files. Easy installation and maintenance with Git bare repository.

- [About](#about)
- [Themes](#themes)
- [Installation](#installation)
- [Usage](#usage)

## About

I use Linux distributions daily for both personal and work related things. Over the years I have customized
Linux CLI tools to my liking. This repository has my config files for the following programs:

- **Alacritty**
- **Zsh** with Prezto configuration framework and Powerlevel10k prompt
- **Tmux** with TPM plugin manager
- **Neovim** / **Vim** with vim-plug plugin manager

## Themes

- [Catppuccin](https://catppuccin.com/): Alacritty, Tmux, Neovim
- [Qogir](https://github.com/vinceliuice/Qogir-theme.git): GTK desktop environment
- [Qogir Icon](https://github.com/vinceliuice/Qogir-icon-theme.git): Desktop environment icons

## Installation

This repo is a Git ["bare repository"](https://www.atlassian.com/git/tutorials/dotfiles): the Git data
(`--git-dir`) lives separately from the checked-out files (`--work-tree`), and `--work-tree` is set to
`$HOME`. This lets the dotfiles live directly at their real paths (e.g. `~/.zshrc`) without a symlink
farm, and lets you manage them with the `config` alias (see [Usage](#usage)) from anywhere.

1. Fork the repo, then copy your fork's clone URL (HTTPS or SSH).

2. Clone your fork into a throwaway folder and install `task` (go-task) from it.

   ```sh
   git clone <your-fork-clone-url> /tmp/dotfiles-setup
   cd /tmp/dotfiles-setup
   bash .config/dotfiles/bootstrap.sh
   ```

3. Turn `$HOME` into the bare-repo checkout and pull everything down.

   ```sh
   task utility:bare-install REPO=<your-fork-clone-url>
   rm -rf /tmp/dotfiles-setup
   ```

4. Provision the machine.

   ```sh
   cd "$HOME"
   cp .config/dotfiles/.env.example .config/dotfiles/.env   # fill in values
   task setup
   ```

   Later, `task update` brings the machine up to date (apt packages, language runtimes, AppImages,
   etc.). Run `task --list` to see every available task.

## Usage

Use the `config` alias instead of `git` while working with your dotfiles:

```sh
config status
config add ~/.zshrc
config commit -m "Modify zsh config"
config push origin master
```

Two helper tools build on top of that alias:

- **`config-edit`** — opens Neovim with the right Git env vars set, so plugins like `vim-fugitive`
  work against the dotfiles repo instead of your current directory's repo.
- **`config-fzf`** — an `fzf` picker over files tracked in the dotfiles repo. Pipe its output into
  other commands, e.g. open the files you pick in Neovim:

  ```sh
  nvim -O $(config-fzf)
  ```
