# **Fork the repo**
**1.** [Go to fork page.](https://github.com/arensonzz/dotfiles/fork)

**2.** Copy HTTPS or SSH clone link of your fork.

# **Prepare dotfiles directory**

**1.** Initialize bare git directory.

```sh
git init --bare $HOME/.dotfiles
```

**2.** Add alias to .bashrc or .zshrc (if you use ZSH as shell) to be able to refer the repo by `config`.

```sh
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```
**3.** Set git to show only tracked files in commands.

```sh
config config --local status.showUntrackedFiles no
```
**4.** Set your fork as remote repo. I used my repo's HTTPS clone link in this example. You should use the [link](#Fork-the-repo) you copied.

```sh
config remote add origin https://github.com/arensonzz/dotfiles.git

```

# **Pull dotfiles from repo**
```sh
config pull origin master
```
# **Usage**
Use `config` alias instead of `git` like we normally do.

### **Examples**
```sh
config status
config add ~/.tldr
config commit -m "Add tldr config"
config add ~/.fzf
config commit -m "Add fzf config"
config push origin master
```
