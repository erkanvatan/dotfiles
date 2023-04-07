set shell=$SHELL
set encoding=UTF-8
set t_Co=256                         " Enable 256 colors
set termguicolors                    " Enable GUI colors for the terminal to get truecolor

" Importing other configs
source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/lightline.vim
source $HOME/.config/nvim/bindings.vim
source $HOME/.config/nvim/functions.vim
source $HOME/.config/nvim/mydadbods.vim

" Colors
syntax on   " Enable syntax highlighting
set t_8f=^[[38;2;%lu;%lu;%lum        " set foreground color
set t_8b=^[[48;2;%lu;%lu;%lum        " set background color

set background=dark   " for the dark version of the theme
colorscheme dracula
let g:lightline.colorscheme = 'dracula'
 " call ChangeBackground()

" Recommended by CoC
set hidden
set updatetime=300
set nobackup    " Disables backup files
set nowritebackup   " Disables backup files
set cmdheight=1 " height of command-line at the bottom
set shortmess+=c
set signcolumn=yes "always show sign column, otherwise it will shift text

set showtabline=2

" set manual folding for functions, conditions etc.
" set foldmethod=manual
set nofoldenable

" Show line numbers
set relativenumber
set nocursorline
set nocursorcolumn

 "set python3 path
let g:python3_host_prog='~/.pyenv/versions/3.10.2/bin/python3.10'


" set default sql syntax
let g:sql_type_default = 'pgsql'
" let g:sql_type_default = 'mysql'

set ignorecase
set smartcase
set mouse=nvchr
set scrolloff=4 " number of screen lines to always keep above and below the cursor

set undofile
set undodir=~/.config/nvim/undodir

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

" Disable sql-complete
let g:omni_sql_no_default_maps = 1

" Language-specific
augroup langindentation
    autocmd!
    autocmd Filetype css setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
    autocmd Filetype scss setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
    autocmd Filetype javascript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
    autocmd Filetype typescript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
    autocmd Filetype html setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
    autocmd BufRead,BufNewFile *.html setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
    autocmd Filetype json setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
    autocmd Filetype xml setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
    autocmd Filetype norg setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
augroup END


" Set long line length marker
highlight OverLength ctermbg=red ctermfg=white guibg=#592929

fun! LongLineHighlightOn(length)
    if !exists("w:llh")
        let w:llh = matchadd("OverLength", '\%' . (a:length + 1) . 'v.*')
    endif
endfunction

augroup longlinehighlight
    autocmd!
    autocmd BufWinEnter *.css,*.scss call LongLineHighlightOn(90)
    autocmd BufWinEnter * call LongLineHighlightOn(120) " every other file
augroup END

augroup breaklonglines
    autocmd!
    autocmd FileType * setlocal tw=120
augroup END
augroup autobreaklonglines
    autocmd!
    autocmd FileType norg setlocal fo+=t
augroup END

" Set the filetype based on the file's extension, overriding any
" 'filetype' that has already been set
" autocmd BufRead,BufNewFile *.html set filetype=html.jinja.javascript
" Set which files will use highlight from start of file (fix for Javascript
" inside HTML syntax)
autocmd BufRead,BufNewFile *.html syntax sync fromstart
