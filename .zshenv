#
# Defines environment variables.
#

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

# nvm
export NVM_DIR="$HOME/.nvm"

# path
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.pyenv/bin:$HOME/scripts:$PATH"

# pipx
export PIPX_DEFAULT_PYTHON="$HOME/.pyenv/versions/$(pyenv version-name)/bin/python"

# nix
[ -e $HOME/.nix-profile/etc/profile.d/nix.sh ] && source $HOME/.nix-profile/etc/profile.d/nix.sh
