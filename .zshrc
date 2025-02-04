#
# Executes commands at the start of an interactive session.
#

# ---------------
# .ZSHRC CONTENTS
# ---------------

# 01. _FUNCTIONS_
# 02. _SCRIPT_SOURCE_
# 03. _ALIASES_
# 04. _SETTINGS_
# 05. _PROGRAM_INIT_

# -----------
# _FUNCTIONS_
# -----------

handle_error()
{
    local -r ERR_MSG=${1:-[ERROR] Error occurred, switching to bash}
    echo "$ERR_MSG" \
        && exec /usr/bin/env bash \
        || exit 1
}

# ---------------
# _SCRIPT_SOURCE_
# ---------------

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# ---------
# _ALIASES_
# ---------

alias clip-cmd='xargs echo -n | xclip -sel clip'
alias du-dir='du -sk * .* | sort -n | perl -ne '\''($s,$f)=split(m{\t});for (qw(K M G)) {if($s<1024) {printf("%.1f",$s);print "$_\t$f"; last};$s=$s/1024}'\'
alias fd='fdfind'
alias history='fc -l 1'
alias ip='ip --color=auto'
alias pip='pip3'
alias yt-dlp-audio='yt-dlp --ignore-errors --output "%(title)s.%(ext)s" --extract-audio --audio-format mp3'

# dotfiles bare git repository
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias config-edit="(export GIT_DIR=$HOME/.dotfiles; export GIT_WORK_TREE=$HOME; $EDITOR)"

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

# ls
command -v exa >/dev/null && alias ls='exa -F -ag --group-directories-first'
alias ll='ls -l'
command -v exa >/dev/null && alias lsh='exa -F -g --group-directories-first'
alias llh='lsh -l'

# vim
## disable Ctrl + S mapping of the terminal before running vim/nvim
alias vim="stty stop '' -ixoff; nvim"
alias nvim="stty stop '' -ixoff; nvim"

# ----------
# _SETTINGS_
# ----------

# activate Bash completions
autoload -Uz bashcompinit
bashcompinit

# --------------
# _PROGRAM_INIT_
# --------------

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# p10k
#   To customize prompt, run `p10k configure`
[ -f ~/.p10k.zsh ] && source ~/.p10k.zsh

# nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# pyenv
command -v pyenv >/dev/null \
    && eval "$(pyenv init - zsh)" \
    && eval "$(pyenv virtualenv-init -)"

# pipx
command -v register-python-argcomplete >/dev/null && eval "$(register-python-argcomplete pipx)"
