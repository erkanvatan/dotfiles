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

. "$HOME/.zprezto/external-modules/k/k.sh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

### Module initialization

eval "$(fasd --init auto)"	# fasd


### Program aliases
# python3
alias python='python3'

# k plugin
alias l='k -h'

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
alias gc='git commit'
alias gl='git log --oneline'
alias ga='git add'

# neovim
alias vim="stty stop '' -ixoff; nvim" # disable Ctrl + S mapping of the terminal before running nvim

# fd-find (fd)
alias fd='fdfind'

# batcat (bat)
alias bat='batcat'

### Script aliases
alias weather='weather.sh'

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
