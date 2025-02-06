#!/usr/bin/env bash

###
### @brief Make programs usable in a offline PC by copying dependencies into folders
### @date 2024-07-08
###

version="0.0.1"
success=0
failure=1

script_bin=$0
script_path=$(realpath $(dirname $script_bin))
dir_package=$script_path/package

help_menu()
{
    echo "Prepares programs for offline install"
    echo ""
    echo "Usage: $script_bin <function name>"
    echo ""
    echo "Available functions:"
    printf "\tmain     - run all prepare functions\n"
    printf "\tdotfiles - clone dotfiles repo\n"
    printf "\tvim      - prepare Vim and Neovim plugins and CoC extensions\n"
    printf "\ttmux     - prepare tmux plugins\n"
    printf "\ttldr     - prepare tldr cache\n"
    printf "\tprezto   - prepare prezto framework for Zsh\n"
    printf "\tcargo    - prepare cargo binary crates\n"
}

# --------------
# MAIN FUNCTIONS
# --------------
main()
{
    function_wrapper dotfiles && \
    function_wrapper vim && \
    function_wrapper tmux && \
    function_wrapper tldr && \
    function_wrapper prezto && \
    function_wrapper cargo

}

dotfiles()
{
    git clone https://github.com/arensonzz/dotfiles.git
}

vim()
{
    # :PlugClean
    # :PlugInstall
    # :PlugUpdate

    # Vim
    home_get ~/.vim/autoload
    home_get ~/.vim/plugged

    # Neovim
    home_get ~/.config/coc
    home_get ~/.config/nvim/plugged
    home_get ~/.local/share/nvim/site/autoload/plug.vim
}

tmux()
{
    home_get ~/.tmux
}

tldr()
{
    # tldr --update
    home_get ~/.tldr
}

prezto()
{
    # zprezto-update
    home_get ~/.zprezto
    home_get ~/.zprezto-contrib
    home_get ~/.cache/gitstatus
}

cargo()
{
    # cargo install alacritty \
                  # mdbook \
                  # mdbook-callouts \
                  # neocmakelsp
    home_get ~/.cargo/bin
}

# ----------------
# HELPER FUNCTIONS
# ----------------

home_get()
{
    local file_path=$1
    local file_parent_dir=$(echo $(dirname $file_path) | awk 'BEGIN { FS="/"; printf "./" }; { for(i=4; i<=NF; i++) { printf $i"/" } }')
    mkdir -p $file_parent_dir
    cp -r -P $file_path $file_parent_dir
}

function_wrapper()
{
    local call_funcname=$1
    echo "### $call_funcname started... ###"

    local dir_function=$dir_package/$call_funcname
    rm -rf $dir_function
    mkdir -p $dir_function

    pushd $dir_function >/dev/null
    $call_funcname
    popd >/dev/null

    echo "### $call_funcname finished ###"
    echo ""
}

# ----
# MAIN
# ----

if [ ! -z "$1" ]; then
    if [ "$1" != "main" ]; then
        function_wrapper $1
    else
        main
    fi
    echo "### tar package started... ###"
    tar caf arensonz-dotfiles-package-v$version.tar.gz -C $script_path install_offline.sh package
    echo "### tar package finished ###"
    echo ""
else
    help_menu
fi
