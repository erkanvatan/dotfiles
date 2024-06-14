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
export EDITOR='vim'
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
export VISUAL='vim'

################
# PROGRAM ALIASES
################
# batcat (bat)
alias bat='batcat --theme=TwoDark'

# config --bare git repository for dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias config_edit="(export GIT_DIR=$HOME/.dotfiles; export GIT_WORK_TREE=$HOME; $EDITOR)"
alias config_fzf_add='dotfile_add.sh'
alias config_fzf_edit='dotfile_edit.sh'

# docker
alias dc='docker container'
alias dcls='docker container ls'
alias dcst='docker container start'
alias dcsp='docker container stop'
alias dcrm='docker container rm'
alias dco='docker compose'
alias dcou='docker compose up'
alias dcod='docker compose down'
alias dcol='docker compose logs'
alias de='docker exec'
alias deit='docker exec -it'
alias di='docker image'
alias dils='docker image ls'

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
alias gll='git log'
alias glg='git log --oneline --all --decorate --graph'
alias ga='git add'
alias gb='git branch'
alias gpl='git pull'
alias gph='git push'
alias gccount='echo "Commit count: " && git shortlog -s | awk '"'"'{ s += $1 } END { print s }'"'"''

# history: show all history
alias history='fc -l 1'

# ip
alias ip='ip --color=auto'

# ls
alias ls='exa -Fag --group-directories-first'
alias ll='ls -l'
alias lsh='exa -Fg --group-directories-first'
alias llh='lsh -l'
alias picocom='picocom -b 115200 -f n -y n -d 8 -p 1 -e q /dev/ttyUSB0'
alias clip_cmd='xargs echo -n | xclip -sel clip'

# neovim
#   disable Ctrl + S mapping of the terminal before running nvim
alias vim="stty stop '' -ixoff; nvim"
alias nvim="stty stop '' -ixoff; nvim"

# pip3
alias pip='pip3'

################
# SCRIPT ALIASES
################
alias fwhite='format_whitespace.py'

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
