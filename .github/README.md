# Dotfiles

All of my Linux config files. Easy installation and maintenance with Git bare repository.

<!-- sudo apt install python3-md-toc -->
<!-- python3 -m md_toc -p -i -s 1 github README.md -->
<!--TOC-->

- [About](#about)
- [Themes](#themes)
- [Installation](#installation)
- [Usage](#usage)

<!--TOC-->

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

Git has a feature called "bare repository". You can place `git-dir` (contents of .git) and `work-tree` on different 
paths. I setup a Bare repository in any folder. When I'm working on my dotfiles repo I use an alias which sets 
`--git-dir` to the bare repository and `--work-tree` to my home directory. 
So I can access my dotfiles repo from any directory without the need to `cd` first.

1. Fork the repo.

    1. [Go to fork page.](https://github.com/erkanvatan/dotfiles/fork)

    2. Copy HTTPS or SSH clone link of your fork.

2. Clone your fork into a throwaway folder and install `task` (go-task) from it.

   ```sh
   git clone <your-fork-clone-url> /tmp/dotfiles-setup
   cd /tmp/dotfiles-setup
   bash .config/dotfiles/bootstrap.sh
   ```

3. Turn `$HOME` into the bare-repo checkout and pull everything down. This one task
   replaces the old manual `git init --bare` / alias / `config` / `remote add` / `pull` /
   `submodule` dance - the `config` alias itself comes from `.zshrc`, which this pulls in.

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

   Once set up, `task update` brings the machine up to date later (apt packages, language
   runtimes, AppImages, etc.). Run `task --list` to see every available task.

## Usage

1. Use `config` alias instead of `git` while working with your dotfiles.

   ```sh
   config status
   config add ~/.bashrc
   config commit -m "Modify bash config"
   config add ~/.zshrc
   config commit -m "Modify zsh config"
   config push origin master
   ```

2. You can use the `config-edit` alias which opens up `Neovim` editor with correct Git env variables set so you can
   use tools like `vim-fugitive` to stash changes, commit, etc.

3. There is also `config-fzf` script which passes file paths in dotfiles as input to `fzf`. So you can list files,
   select one or more file and use returned file list with other programs.

   ```sh
   nvim -O $(config-edit)
   ```
