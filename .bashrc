# enable bash completion in interactive shells
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

################
# ENVIRONMENT VARIABLES
################
export BROWSER='firefox'
export EDITOR='nvim'
# FZF
#   set fd as the default source
export FZF_DEFAULT_COMMAND='fdfind --type f --hidden --follow --exclude "{node_modules,.git}"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
#   default options
export FZF_DEFAULT_OPTS='--layout=reverse'
# grep
export GREP_COLORS='0;31'
export LESS='-F -g -i -M -R -S -w -X -z-4'
export LC_ALL='en_US.UTF-8'
# prompt: show full path for current directory
export PS1="\[\033[1;32m\]\u \[\033[31m\]\W $ \[\033[0m\]"
export PAGER='less'
export SHELL='/bin/bash'
export VISUAL='nvim'

################
# PROGRAM ALIASES
################
# batcat (bat)
alias bat='batcat --theme=TwoDark'

# config --bare git repository
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# du
alias usage='du -sk * | sort -n | perl -ne '\''($s,$f)=split(m{\t});for (qw(K M G)) {if($s<1024) {printf("%.1f",$s);print "$_\t$f"; last};$s=$s/1024}'\'

# fd-find (fd)
alias fd='fdfind'

# fzf
alias fzfp='fzf --preview "batcat --style=numbers --color=always {} | head -500"'

# git
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

# history: show all history
alias history='fc -l 1'

# ip
alias ip='ip --color=auto'

# ls
alias ls='ls --color'
alias la='ll -A'
alias ll='ls -lh'

# neovim
alias vim="stty stop '' -ixoff; nvim" # disable Ctrl + S mapping of the terminal before running nvim
alias nvim="stty stop '' -ixoff; nvim" # disable Ctrl + S mapping of the terminal before running nvim

# pip3
alias pip='pip3'

################
# SCRIPT ALIASES
################
alias fwhite='format_whitespace.py'
alias dotfile_add='dotfile_add.sh'
alias dotfile_edit='dotfile_edit.sh'

################
# REMINDER ALIASES
################
# alias rm='echo "Use trash instead of rm (use \\\\rm -i if you want to skip this warning.)"'

################
# BASH CONFIGS
################

################
# FUNCTIONS
################
# mkdir and cd to that directory
function mkdircd () { mkdir -p "$@" && eval cd "\"\$$#\""; }
