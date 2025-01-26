#
# Defines environment variables.
#

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

export BROWSER='firefox'
export EDITOR='nvim'
export VISUAL='nvim'

# fzf
command -v fdfind >/dev/null \
    && export FZF_DEFAULT_COMMAND='fdfind --type f --hidden --follow --exclude "{node_modules,.git}"' \
    && export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--layout=reverse'

# grep
export GREP_COLORS='mt=0;31'

# locales
export LC_ALL="en_US.UTF-8"

# nvm
export NVM_DIR="$HOME/.nvm"

# path
export PATH="$HOME/.dotnet/tools:$HOME/.pyenv/bin:$HOME/.local/bin:$HOME/bin:$HOME/.cargo/bin:$PATH"

# pipx
export PIPX_DEFAULT_PYTHON="$HOME/.pyenv/versions/$(pyenv version-name)/bin/python"
