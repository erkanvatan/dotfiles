#
# Defines environment variables.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

export PATH="$PATH:$HOME/.local/bin:$HOME/bin"

# My environment variables
export LOCATION="***REMOVED***,TR"	# used for ansiweather location
export EDITOR='vim'
# WSL2 only
#export BROWSER='firefox'
export BROWSER="/mnt/c/Firefox/firefox.exe"
#backend for GUI apps
export DISPLAY=`grep -oP "(?<=nameserver ).+" /etc/resolv.conf`:0.0
export LIBGL_ALWAYS_INDIRECT=1

# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fdfind --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# fzf default opts
export FZF_DEFAULT_OPTS='--layout=reverse'

# grep
export GREP_COLORS='0;31'
