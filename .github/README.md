# Dotfiles

All of my Linux config files. Easy installation and maintenance with Git bare repository.

<!-- sudo apt install python3-md-toc -->
<!-- python3 -m md_toc -p -i -s 1 github README.md -->
<!--TOC-->

- [About](#about)
- [Installation](#installation)
- [Usage](#usage)

<!--TOC-->

## About

I use Linux distributions daily for both personal and work related things. Over the years I have customized
Linux CLI tools to my liking. This repository has my config files for the following programs:

- **Zsh** with **Prezto** configuration framework
- **Tmux**
- **Neovim** / **Vim**

## Installation

Git has a feature called "bare repository". You can place `git-dir` (contents of .git) and `work-tree` on different 
paths. I setup a Bare repository in any folder. When I'm working on dotfiles repo I use an alias which sets `--git-dir`
to bare repository and `--work-tree` to my home directory. So I can access my dotfiles repo from any directory without 
the need to `cd` first.

1. Fork the repo.

    1. [Go to fork page.](https://github.com/arensonzz/dotfiles/fork)

    2. Copy HTTPS or SSH clone link of your fork.

2. Prepare dotfiles directory.

    1. Initialize bare Git repository.

        ```sh
        git init --bare $HOME/.dotfiles
        ```

    2. Add an alias to `.bashrc` or `.zshrc` (if you use Zsh as shell).

        ```sh
        alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
        alias config_edit="(export GIT_DIR=$HOME/.dotfiles; export GIT_WORK_TREE=$HOME; nvim)"
        ```
    3. Configure local Git settings for the repository.

        ```sh
        config config --local status.showUntrackedFiles no
        config config --local core.worktree $HOME
        ```
    4. Set your fork as remote repository. I used my repo's HTTPS clone link in this example. 
       You should use the [link](#Fork-the-repo) you copied.

        ```sh
        config remote add origin https://github.com/arensonzz/dotfiles.git
        ```

3. Pull dotfiles from repo

    ```sh
    config pull origin master
    ```
## Usage

Use `config` alias instead of `git` when working with dotfiles repository.

```sh
config status
config add ~/.bashrc
config commit -m "Modify bash config"
config add ~/.zshrc
config commit -m "Modify zsh config"
config push origin master
```

Also you can use the `config_edit` alias which opens up `Neovim` editor with correct Git env variables set so you can
use tools like `vim-fugitive` to stash changes, commit, etc.
