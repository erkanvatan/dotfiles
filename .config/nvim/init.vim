set shell=$SHELL
set encoding=UTF-8

" Importing other configs
source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/lightline.vim
source $HOME/.config/nvim/bindings.vim

" Colors
syntax on   " Enable syntax highlighting
set termguicolors
"let g:dracula_colorterm = 0
"colorscheme dracula
let g:gruvbox_colorterm = 0
colorscheme gruvbox

set hidden
set showtabline=2

" Python paths, for some stuff
let g:python3_host_prog='/usr/bin/python'
let g:python_host_prog='/usr/bin/python2'

" Show line numbers and make current line bold
" Don't wrap lines
set number
set cursorline
highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
highlight CursorLineNR cterm=bold
set nowrap

set ignorecase
set smartcase
set mouse=a

set nobackup    " Disables backup files - recommanded by Coc
set nowritebackup   " Disables backup files - recommanded by Coc
set undofile
set undodir=~/.config/nvim/undodir

set clipboard=unnamedplus   " Connect vim clipboard with the system clipboard
set inccommand=nosplit
set splitright
set splitbelow

set conceallevel=0

" Whitespace configs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set smartindent





" Language-specific
"augroup langindentation
"	autocmd Filetype go setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
"	autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
"	autocmd Filetype css setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
"	autocmd Filetype scss setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
"	autocmd Filetype javascript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
"	autocmd Filetype html setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
"	autocmd Filetype htmldjango setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
"	autocmd Filetype handlebars setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
"	autocmd Filetype ember setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
"	autocmd Filetype json setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
"	autocmd Filetype yaml setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
"	autocmd Filetype xml setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
"	autocmd Filetype lua setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
"augroup END

