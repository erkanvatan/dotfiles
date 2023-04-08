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
alias la="ll -A"
alias ll="ls -lh"

### PROMPT CONFIG
# show full path for current directory
export PS1="\[\033[1;32m\]\u \[\033[31m\]\W $ \[\033[0m\]"

### TERMINAL FIRST OPEN
export SHELL=/bin/bash

### PROGRAM ALIASES
# fzf
alias fzfp="fzf --preview 'batcat --style=numbers --color=always {} | head -500'"

# Make history command show all history
alias history='fc -l 1'

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

# fd-find (fd)
alias fd='fdfind'

# batcat (bat)
alias bat='batcat --theme=TwoDark'

# pip3
alias pip='pip3'

### REMINDER/CORRECTOR ALIASES
# alias rm='echo "Use trash instead of rm (use \\\\rm -i if you want to skip this warning.)"'

### CONFIGS

### FUNCTIONS
# mkdir and cd to that directory
function mkdircd () { mkdir -p "$@" && eval cd "\"\$$#\""; }
