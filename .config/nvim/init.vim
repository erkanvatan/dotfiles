
" -----------------
" INIT.VIM CONTENTS
" -----------------

" 01. _EDITOR_CONFIGS_
" 02. _PLUGINS_
" 03. _PLUGIN_SETTINGS_
" 04. _FUNCTIONS_
" 05. _KEYBINDINGS_


" ------------------
" # _EDITOR_CONFIGS_
" ------------------

" ## Import settings shared with Vim
source $HOME/.vimrc

" ## Import other config files
source $HOME/.config/nvim/bindings.vim
source $HOME/.config/nvim/mydadbods.vim

" ## Define global Vim variables
let g:python3_host_prog = '/usr/bin/python3'
let g:sql_type_default = 'pgsql'
" Fix 'node not executable' error when running Neovim from GNOME Application Menu
" let g:coc_node_path = '~/.nvm/versions/node/v18.13.0/bin/node'
let g:omni_sql_no_default_maps = 1 " Disable sql-complete

