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


# Change path
export PATH="$PATH:$HOME/.local/bin:$HOME/bin"

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
alias fwhite='format_whitespace.py'

### REMINDER/CORRECTOR ALIASES
# alias rm='echo "Use trash instead of rm (use \\\\rm -i if you want to skip this warning.)"'

### CONFIGS

### FUNCTIONS
# mkdir and cd to that directory
function mkdircd () { mkdir -p "$@" && eval cd "\"\$$#\""; }
