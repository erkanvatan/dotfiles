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
export PATH="$PATH:$HOME/.cargo/bin"

# source cargo for Rust lang
# . "$HOME/.cargo/env"

### ENVIRONMENT VARIABLES
export EDITOR='vim'
export BROWSER='firefox'

# WSL2 only
# export BROWSER="/mnt/c/Firefox/firefox.exe"
#   Set backend for GUI apps
# export DISPLAY=`grep -oP "(?<=nameserver ).+" /etc/resolv.conf`:0.0
# export LIBGL_ALWAYS_INDIRECT=1
#   easy access to Windows desktop
# export DESKTOP='/mnt/c/Users/arensonz/Desktop'

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
