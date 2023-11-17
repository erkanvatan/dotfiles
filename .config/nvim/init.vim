" Set Vim options
set termguicolors " Enable GUI colors for the terminal to get truecolor
" set t_Co=256 " Enable 256 colors
" set t_8f=^[[38;2;%lu;%lu;%lum " set foreground color
" set t_8b=^[[48;2;%lu;%lu;%lum " set background color
set shell=$SHELL " Set shell to use for ! commands
set encoding=UTF-8 " Set character encoding
set timeoutlen=800 " Shrink the window for time-outable commands
set showtabline=2 " Always show tab line
set nofoldenable " Start with all folds open
set mouse=nvchr " Enable mouse for all modes except insert mode
set scrolloff=4 " Set number of screen lines to always keep above and below the cursor
set undofile " Enable undo history
set undodir=~/.config/nvim/undodir " Select the directory to keep undofiles
set splitright " Open vertical splits to right
set splitbelow " Open horizontal splits to below
set conceallevel=0 " Do not conceal text (e.g. Neorg symbols)
set ignorecase " By default ignore case when searching
set smartcase " If intentionally uppercase letters are used in search then override ignorecase

" Define global Vim variables
let g:python3_host_prog = '/usr/bin/python3'
let g:sql_type_default = 'pgsql'
" Fix 'node not executable' error when running Neovim from GNOME Application Menu
" let g:coc_node_path = '~/.nvm/versions/node/v18.13.0/bin/node'
let g:omni_sql_no_default_maps = 1 " Disable sql-complete

" Import other config files
source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/lightline.vim
source $HOME/.config/nvim/bindings.vim
source $HOME/.config/nvim/functions.vim
source $HOME/.config/nvim/mydadbods.vim
if !empty(glob("$HOME/.config/nvim/gitignore.vim"))
    source $HOME/.config/nvim/gitignore.vim
endif

" Colors
syntax on " Enable syntax highlighting

"   Set initial theme colors
set background=dark
colorscheme dracula
let g:lightline.colorscheme = 'dracula'

"   Set long line length marker colors
augroup set_longlinehighlight_by_extension
    autocmd!
    autocmd BufWinEnter *.css,*.scss call LongLineHighlightOn(90)
    autocmd BufWinEnter * if &ft != 'floaterm' && &ft != 'fzf' | call LongLineHighlightOn(120) | endif " every other file
augroup END

" Configs recommended by CoC
set hidden
set updatetime=300
set nobackup " Disables backup files
set nowritebackup " Disables backup files
set cmdheight=1 " height of command-line at the bottom
set shortmess+=c
set signcolumn=yes "always show sign column, otherwise it will shift text

" Line numbers
set relativenumber
set number
set nocursorline
set nocursorcolumn

" Whitespace configs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set smartindent
"   Set language-specific indentation
augroup lang_indentation_by_filetype
    autocmd!
    autocmd Filetype css,scss,javascript,typescript,html,json,xml,norg,cmake
        \ setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd BufRead,BufNewFile *.html setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
augroup END

" Line breaks
augroup long_line_break_settings
    autocmd!
    autocmd FileType * setlocal textwidth=120
augroup END

augroup auto_long_line_break_by_filetype
    autocmd!
    autocmd FileType norg setlocal fo+=t
augroup END

" Set the filetype based on the file's extension, overriding any
" 'filetype' that has already been set
augroup set_filetype_by_extension
    autocmd!
    autocmd BufRead,BufNewFile *.html set filetype=html.javascript.jinja
    autocmd BufNewFile,BufRead *.launch set filetype=xml
augroup END

augroup partial_syntax_by_extension
    autocmd!
    autocmd BufRead,BufNewFile *.html call SyntaxRange#Include('{%', '%}', 'jinja') |
        \ call SyntaxRange#Include('{{', '}}', 'jinja')
augroup END

" Set which files will use highlight from start of file (fix for Javascript
" inside HTML syntax)
augroup highlight_from_start
    autocmd!
    autocmd BufRead,BufNewFile *.html syntax sync fromstart
augroup END
