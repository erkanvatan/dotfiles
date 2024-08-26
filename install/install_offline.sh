#!/usr/bin/env bash

###
### @brief Install program dependencies to offline PC by copying dependencies into folders
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
    echo "Installs programs without Internet connection"
    echo ""
    echo "Usage: $script_bin <function name>"
    echo ""
    echo "Available functions:"
    printf "\tmain     - run all install functions\n"
    printf "\tdotfiles - install dotfiles bare repo\n"
    printf "\tvim      - install Vim and Neovim plugins and CoC extensions\n"
    printf "\ttmux     - install tmux plugins\n"
    printf "\ttldr     - install tldr cache\n"
    printf "\tprezto   - install prezto framework for Zsh\n"
    printf "\tcargo    - install cargo binary crates\n"
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

# ----------------
# HELPER FUNCTIONS
# ----------------

home_put()
{
    for entry in $(find . -maxdepth 1 -name "*" -not -path "."); do
        cp -r -P $entry ~
    done
}

function_wrapper()
{
    local call_funcname=$1
    echo "### $call_funcname started... ###"

    local dir_function=$dir_package/$call_funcname

    pushd $dir_function >/dev/null

    home_put

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
else
    help_menu
fi
