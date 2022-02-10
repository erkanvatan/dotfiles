# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

################
# TERMINAL START
################

### WSL2 CONFIG
# Change WSL2 directory colors for readability
#   Change ls colours
# export CLICOLOR=1
# export LS_COLORS='rs=0:no=00:mi=00:mh=00:ln=01;36:or=01;31:di=01;34:ow=04;01;34:st=34:tw=04;34:pi=01;33:so=01;33:do=01;33:bd=01;33:cd=01;33:su=01;35:sg=01;35:ca=01;35:ex=01;32:'
#   Make cd use the ls colours
# zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"

# Aliases
# alias explorer='/mnt/c/Windows/explorer.exe .'

# Set browser
# alias firefox="/mnt/c/Firefox/firefox.exe"

### PROGRAM ALIASES
# translate-shell
alias td='trans :tr'
alias tureng='trans tr:en'

# fzf
alias fzfp="fzf --preview 'batcat --style=numbers --color=always {} | head -500'"

# Make history command show all history
alias history='fc -l 1'

# config --bare git repository
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# Git aliases
alias gs='git status'
alias gsh='git stash'
alias gc='git commit'
alias gm='git merge'
alias gd='git diff'
alias gco='git checkout'
alias gl='git log --oneline'
alias glg='git log --oneline --all --decorate --graph'
alias ga='git add'
alias gb='git branch'
alias gpl='git pull'
alias gph='git push'

# neovim
alias vim="stty stop '' -ixoff; nvim" # disable Ctrl + S mapping of the terminal before running nvim
alias nvim="stty stop '' -ixoff; nvim" # disable Ctrl + S mapping of the terminal before running nvim

# fd-find (fd)
alias fd='fdfind'

# batcat (bat)
alias bat='batcat --theme=TwoDark'

# pip3
alias pip='pip3'

### SCRIPT ALIASES
alias fwhite='format_whitespace.py'

### REMINDER/CORRECTOR ALIASES
# alias rm='echo "Use trash instead of rm (use \\\\rm -i if you want to skip this warning.)"'

### CONFIGS
# Activate tab completion
autoload -Uz compinit
compinit
autoload -U bashcompinit
bashcompinit

# Disable autocorrect in zsh  (nyae prompt)
unsetopt correct
unsetopt correctall
DISABLE_CORRECTION="true"

# Overwrite existing files with > and >>.
setopt CLOBBER

### FUNCTIONS
# mkdir and cd to that directory
function mkdircd () { mkdir -p "$@" && eval cd "\"\$$#\""; }

### MODULE INITIALIZATION
# fasd
eval "$(fasd --init auto)"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# p10k
#   To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
#   bash completion
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# PyEnv
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# initialize pipx
#   Set pipx default python interpreter
export PIPX_DEFAULT_PYTHON="$HOME/.pyenv/versions/$(pyenv version-name)/bin/python"
#   Load pipx completions
eval "$(register-python-argcomplete pipx)"
