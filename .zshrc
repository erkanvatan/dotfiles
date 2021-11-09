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


### Terminal start

# Weather
#if [[ -x $(which ansiweather) ]]; then
#	ansiweather -u metric  -l $LOCATION -s true -w true -h false -p false -d true
#fi

# Quotes
if [[ -x $(which motivate) ]]; then
    motivate
fi

### Source external plugins

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

### Module initialization

eval "$(fasd --init auto)"	# fasd

### WSL2 Config
# Change WSL2 directory colors for readability
#   Change ls colours
export CLICOLOR=1
export LS_COLORS='rs=0:no=00:mi=00:mh=00:ln=01;36:or=01;31:di=01;34:ow=04;01;34:st=34:tw=04;34:pi=01;33:so=01;33:do=01;33:bd=01;33:cd=01;33:su=01;35:sg=01;35:ca=01;35:ex=01;32:'
#   Make cd use the ls colours
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"

# Aliases
alias explorer='/mnt/c/Windows/explorer.exe .'

# Run hwclock at startup to fix clock skew
# sudo hwclock --hctosys

# Activate tab completion
autoload -Uz compinit
compinit
autoload -U bashcompinit
bashcompinit

# Set browser
alias firefox="/mnt/c/Firefox/firefox.exe"

### Program aliases
# translate-shell
alias td='trans :tr'
alias tureng='trans tr:en'

# fzf
alias fzfp="fzf --preview 'batcat --style=numbers --color=always {} | head -500'"

# Make history command show all history
alias history='fc -l 1'

# Alias for config --bare git repository
alias config='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME'

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
alias bat='batcat'

# pip3
alias pip='pip3'

### Script aliases
alias weather='weather.sh'
alias fwhite='format_whitespace.py'

### Reminder/corrector aliases
# alias rm='echo "Use trash instead of rm (use \\\\rm -i if you want to skip this warning.)"'

# Disable autocorrect in zsh  (nyae prompt)
unsetopt correct
unsetopt correctall
DISABLE_CORRECTION="true"

# Overwrite existing files with > and >>.
setopt CLOBBER


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Load nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Load PyEnv
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Set pipx default python interpreter
export PIPX_DEFAULT_PYTHON="$HOME/.pyenv/versions/3.9.0/bin/python"

# Load pipx completions
eval "$(register-python-argcomplete pipx)"


### FUNCTIONS
#   mkdir and cd to that directory
function mkdircd () { mkdir -p "$@" && eval cd "\"\$$#\""; }
