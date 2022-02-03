# enable bash completion in interactive shells
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

alias usage='du -sk * | sort -n | perl -ne '\''($s,$f)=split(m{\t});for (qw(K M G)) {if($s<1024) {printf("%.1f",$s);print "$_\t$f"; last};$s=$s/1024}'\'
alias ls="ls --color"

### PROMPT CONFIG
# show full path for current directory
export PS1="\[\033[1;32m\]\u \[\033[31m\]\W $ \[\033[0m\]"

### TERMINAL FIRST OPEN

### WSL2 CONFIG
# Change WSL2 directory colors for readability
#   Change ls colours
export CLICOLOR=1
export LS_COLORS='rs=0:no=00:mi=00:mh=00:ln=01;36:or=01;31:di=01;34:ow=04;01;34:st=34:tw=04;34:pi=01;33:so=01;33:do=01;33:bd=01;33:cd=01;33:su=01;35:sg=01;35:ca=01;35:ex=01;32:'

# Aliases
alias explorer='/mnt/c/Windows/explorer.exe .'

# Set browser
alias firefox="/mnt/c/Firefox/firefox.exe"

### PROGRAM ALIASES
# translate-shell
alias td='trans :tr'
alias tureng='trans tr:en'

# fzf
alias fzfp="fzf --preview 'batcat --style=numbers --color=always {} | head -500'"

# Make history command show all history
alias history='fc -l 1'

# config --bare git repository
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
alias bat='batcat --theme=TwoDark'

# pip3
alias pip='pip3'

### SCRIPT ALIASES
alias weather='weather.sh'
alias fwhite='format_whitespace.py'

### REMINDER/CORRECTOR ALIASES
# alias rm='echo "Use trash instead of rm (use \\\\rm -i if you want to skip this warning.)"'

### CONFIGS

### FUNCTIONS
# mkdir and cd to that directory
function mkdircd () { mkdir -p "$@" && eval cd "\"\$$#\""; }

### MODULE INITIALIZATION
# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# PyEnv
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# pipx
#   Set pipx default python interpreter
export PIPX_DEFAULT_PYTHON="$HOME/.pyenv/versions/3.9.0/bin/python"
#   Load pipx completions
eval "$(register-python-argcomplete pipx)"
