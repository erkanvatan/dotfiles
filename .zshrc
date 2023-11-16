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
# ENVIRONMENT VARIABLES
################
export BROWSER='firefox'
# FZF
#   set fd as the default source
export FZF_DEFAULT_COMMAND='fdfind --type f --hidden --follow --exclude "{node_modules,.git}"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
#   default options
export FZF_DEFAULT_OPTS='--layout=reverse'

# grep
export GREP_COLORS='0;31'

# locales
export LC_ALL="en_US.UTF-8"

################
# PROGRAM ALIASES
################
# batcat (bat)
alias bat='batcat --theme=TwoDark'

# BindToInterface
alias wlo1_bind="BIND_INTERFACE=wlo1 DNS_OVERRIDE_IP=1.1.1.1 DNS_EXCLUDE=127.0.0.1 LD_PRELOAD=$HOME/programs/BindToInterface/bindToInterface.so"
alias usb0_bind="BIND_INTERFACE=usb0 DNS_OVERRIDE_IP=1.1.1.1 DNS_EXCLUDE=127.0.0.1 LD_PRELOAD=$HOME/programs/BindToInterface/bindToInterface.so"

# config --bare git repository
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

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
alias fzfp="fzf --preview 'batcat --style=numbers --color=always {} | head -500'"

# feh
alias fehzoom='feh --auto-zoom --force-aliasing --geometry 1280x720'

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

# history:  show all history
alias history='fc -l 1'

# ip
alias ip='ip --color=auto'

# neovim
alias vim="stty stop '' -ixoff; nvim" # disable Ctrl + S mapping of the terminal before running nvim
alias nvim="stty stop '' -ixoff; nvim" # disable Ctrl + S mapping of the terminal before running nvim

# npm
#   add fixer/linter dependencies
alias devtools_web_vanilla='pnpm add -D eslint prettier eslint-plugin-prettier eslint-config-prettier stylelint stylelint-config-standard'
alias devtools_web_svelte_eslint='pnpm add -D eslint eslint-plugin-svelte3 eslint-plugin-import typescript @typescript-eslint/parser @typescript-eslint/eslint-plugin @rollup/plugin-typescript @tsconfig/svelte stylelint stylelint-config-recommended-scss stylelint-config-html postcss postcss-html sass prettier prettier-plugin-svelte'
alias devtools_web_svelteserver='pnpm add -D eslint eslint-plugin-prettier eslint-config-prettier typescript @rollup/plugin-typescript @tsconfig/svelte stylelint stylelint-config-recommended-scss stylelint-config-html postcss postcss-html sass prettier prettier-plugin-svelte'

# pip3
alias pip='pip3'

# rsync
alias sync_home="rsync -gloptruch --stats --delete --exclude={'/subfolders/','/Music/','/Downloads/','/Pictures/','/Videos/','/VirtualBox\ VMs/','/.local/','/.cache/','/.cargo/','/.npm/','/.nvm/','/projects/languages/rust/**/target','/projects/languages/latex/**/build','/projects/**/node_modules','/projects/languages/c/**/Debug'} /home/arensonz/ '/media/arensonz/Linux Files/Backups/aren-zenbook'"
alias sync_subfolders="rsync -gloptruch --stats --delete /home/arensonz/subfolders '/media/arensonz/Shared Files/'"
alias sync_music="rsync -gloptruch --stats --delete /home/arensonz/Music '/media/arensonz/Shared Files/'"
alias rsync_restore="rsync -gloptrch --stats"

# translate-shell
alias td='trans :tr'

# yt-dlp
alias yt_dlp_audio='yt-dlp --ignore-errors --output "%(title)s.%(ext)s" --extract-audio --audio-format mp3'

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
# ZSH CONFIGS
################
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

################
# FUNCTIONS
################
# mkdir and cd to that directory
function mkdircd () { mkdir -p "$@" && eval cd "\"\$$#\""; }

################
# MODULE INITIALIZATION
################
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

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

export PNPM_HOME="/home/arensonz/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

# dotnet
export PATH="$HOME/.dotnet/tools:$PATH"

# source cargo for Rust lang
# . "$HOME/.cargo/env"
