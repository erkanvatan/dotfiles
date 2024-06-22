" # Import settings shared with Vim
source $HOME/.vimrc

" # Define global Vim variables
let g:python3_host_prog = '/usr/bin/python3'
let g:sql_type_default = 'pgsql'

" Fix 'node not executable' error when running Neovim from GNOME Application Menu
" let g:coc_node_path = '~/.nvm/versions/node/v18.13.0/bin/node'
" let g:node_host_prog = '/usr/bin/node'

let g:omni_sql_no_default_maps = 1 " Disable sql-complete
