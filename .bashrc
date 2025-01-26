if [ -f $HOME/.zshenv ]; then
    source $HOME/.zshenv
fi

# prompt: show full path for current directory
export PS1="\[\033[36m\]\w \[\033[1;32m\]$ \[\033[0m\]"
