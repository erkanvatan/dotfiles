# Enable bash completion in interactive shells
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# Source environment variables
if [ -f $HOME/.zshenv ]; then
    source $HOME/.zshenv
fi

# Change prompt: show full path for current directory
export PS1="\[\033[36m\]\w \[\033[1;32m\]$ \[\033[0m\]"
