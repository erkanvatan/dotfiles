# **Prepare dotfiles directory**

**1.** git init --bare $HOME/dotfiles     (initialize bare git directory)

**2.** alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME' (add this alias to .bashrc or .zshrc)

**3.** config config --local status.showUntrackedFiles no    (only tracked files are shown in commands)

# **Usage**
* Use “config” alias instead of “git" like we normally do.

**Examples:**

config status

config add ~/.zshrc

config commit -m "Add vimrc"

config add ~/.xvimrc

config commit -m "Add xvimrc"


# **Installing dotfiles to a new system**
* Prepare dotfiles directory as instructed above then pull repo to your computer

config pull origin master
