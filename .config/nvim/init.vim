" -----------------
" INIT.VIM CONTENTS
" -----------------

" 01. _EDITOR_CONFIGS_
" 02. _FUNCTIONS_
" 03. _KEYBINDINGS_
" 04. _LATE_IMPORTS_

" ------------------
" # _EDITOR_CONFIGS_
" ------------------

" Set leader keys (must be on top because plugins use it)
let mapleader="\<Space>"
let maplocalleader = ","

" Define global variables
let g:python3_host_prog = '/usr/bin/python3'
let g:sql_type_default = 'pgsql'
let g:omni_sql_no_default_maps = 1

" ## General options
set novisualbell " Disable screen flashes
set encoding=UTF-8 " Set character encoding
set timeoutlen=800 " Shrink the window for time-outable commands
set nofoldenable " Start with all folds open
set mouse=nvchr " Enable mouse for all modes except insert mode
set scrolloff=4 " Set number of screen lines to always keep above and below the cursor
set undofile " Enable undo history
if !isdirectory(stdpath('config') . '/undodir')
    :call mkdir(stdpath('config') . '/undodir')
endif
let &undodir = stdpath('config') . '/undodir' " Select the directory to keep undofiles
set splitright " Open vertical splits to right
set splitbelow " Open horizontal splits to below
set conceallevel=0 " Do not conceal text (e.g. Neorg symbols)
set ignorecase " By default ignore case when searching
set smartcase " If intentionally uppercase letters are used in search then override ignorecase
set hlsearch " Keep search highlight
set list " Show whitespace characters
set showcmd " show keypresses in status line

" ## Colors
set termguicolors " enable true-color support
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum" " set foreground color
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum" " set background color
set background=dark

" ## Line numbers
set relativenumber
set number
set nocursorline
set nocursorcolumn

" ## Whitespace settings
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

" ## Visual settings
set textwidth=120
set showtabline=2 " Always show tab line

" ## Configs recommended by CoC
set hidden
set updatetime=300
set nobackup " Disable backup files
set nowritebackup " Disable backup files
set shortmess+=c " Disable hit ENTER prompts for completion
set signcolumn=yes " Always show sign column, otherwise it will shift text

" ## Commands
command! V e $MYVIMRC | cd %:h

" -------------
" # _FUNCTIONS_
" -------------

" _ToggleBackground_
" _TermForceCloseAll_

" ---------------------
" ## _ToggleBackground_
" ---------------------

function! ToggleBackground()
    if &background =~? 'dark'
        echo 'Changing to light theme...'
        echo ''

        colorscheme catppuccin
        let g:lightline.colorscheme = 'catppuccin'
        let g:lightline#colorscheme#catppuccin#palette = {'inactive': {'right': [['#bcc0cc', '#eff1f5', 146, 231], ['#9ca0b0', '#eff1f5', 145, 231]], 'middle': [['#bcc0cc', '#eff1f5', 146, 231]], 'left': [['#1e66f5', '#eff1f5', 27, 231], ['#9ca0b0', '#eff1f5', 145, 231]]}, 'replace': {'left': [['e6e9ef', '#d20f39', 189, 161], ['#1e66f5', '#eff1f5', 27, 231]]}, 'normal': {'right': [['#9ca0b0', '#eff1f5', 145, 231], ['#1e66f5', '#ccd0da', 27, 188]], 'middle': [['#1e66f5', '#e6e9ef', 27, 189]], 'warning': [['#e6e9ef', '#df8e1d', 189, 172]], 'left': [['#e6e9ef', '#1e66f5', 189, 27], ['#1e66f5', '#eff1f5', 27, 231]], 'error': [['#e6e9ef', '#d20f39', 189, 161]]}, 'tabline': {'right': [['#bcc0cc', '#eff1f5', 146, 231], ['#9ca0b0', '#eff1f5', 145, 231]], 'middle': [['#bcc0cc', '#eff1f5', 146, 231]], 'left': [['#9ca0b0', '#eff1f5', 145, 231], ['#9ca0b0', '#eff1f5', 145, 231]], 'tabsel': [['#1e66f5', '#bcc0cc', 27, 146], ['#9ca0b0', '#eff1f5', 145, 231]]}, 'visual': {'left': [['#e6e9ef', '#8839ef', 189, 99], ['1e66f5', '#eff1f5', 27, 231]]}, 'insert': {'left': [['#e6e9ef', '#179299', 189, 30], ['#1e66f5', '#eff1f5', 27, 231]]}}

        set background=light
    else
        echo 'Changing to dark theme...'
        echo ''

        colorscheme catppuccin
        let g:lightline.colorscheme = 'catppuccin'
        let g:lightline#colorscheme#catppuccin#palette = {'inactive': {'right': [['#45475a', '#1e1e2e', 59, 16], ['#6c7086', '#1e1e2e', 60, 16]], 'middle': [['#45475a', '#1e1e2e', 59, 16]], 'left': [['#89b4fa', '#1e1e2e', 111, 16], ['#6c7086', '#1e1e2e', 60, 16]]}, 'replace': {'left': [['#181825', '#f38ba8', 16, 211], ['#89b4fa', '#1e1e2e', 111, 16]]}, 'normal': {'right': [['#6c7086', '#1e1e2e', 60, 16], ['#89b4fa', '#313244', 111, 59]], 'middle': [['#89b4fa', '#181825', 111, 16]], 'warning': [['#181825', '#f9e2af', 16, 223]], 'left': [['#181825', '#89b4fa', 16, 111], ['#89b4fa', '#1e1e2e', 111, 16]], 'error': [['#181825', '#f38ba8', 16, 211]]}, 'tabline': {'right': [['#45475a', '#1e1e2e', 59, 16], ['#6c7086', '#1e1e2e', 60, 16]], 'middle': [['#45475a', '#1e1e2e', 59, 16]], 'left': [['#6c7086', '#1e1e2e', 60, 16], ['#6c7086', '#1e1e2e', 60, 16]], 'tabsel': [['#89b4fa', '#45475a', 111, 59], ['#6c7086', '#1e1e2e', 60, 16]]}, 'visual': {'left': [['#181825', '#cba6f7', 16, 183], ['#89b4fa', '#1e1e2e', 111, 16]]}, 'insert': {'left': [['#181825', '#94e2d5', 16, 116], ['#89b4fa', '#1e1e2e', 111, 16]]}}

        set background=dark
    endif

    try
        call lightline#init()
        call lightline#colorscheme()
        call lightline#update()
    catch
    endtry
endfunction

command! ToggleBackground call ToggleBackground()

" ----------------------
" ## _TermForceCloseAll_
" ----------------------
" https://www.reddit.com/r/vim/comments/fwedfx/comment/fmnwar1

function! s:TermForceCloseAll() abort
    let term_bufs = filter(range(1, bufnr('$')), 'getbufvar(v:val, "&buftype") == "terminal"')
    for t in term_bufs
        execute 'bd! ' t
    endfor
endfunction

" ---------------
" # _KEYBINDINGS_
" ---------------

" Source $MYVIMRC
nnoremap <leader>ss :source $MYVIMRC<CR>

" Quit without saving
nnoremap qq :q<CR>

" Quit after saving
nnoremap qw :wq<CR>

" Save with Ctrl + S
noremap <C-s> :w<CR>
inoremap <C-s> <ESC>:w<CR>a

" Copy-paste bindings for system clipboard (+)
nnoremap <Leader>yy "+y
vnoremap <Leader>yy "+y

nnoremap <Leader>pp "+p
vnoremap <Leader>pp "+p

" Quickly insert an empty new line without entering insert mode
nnoremap <Leader>o o<Esc>k
nnoremap <Leader>O O<Esc>j

" Change vim window focus
map <C-h> <C-w>h
map <C-l> <C-w>l
map <C-j> <C-w>j
map <C-k> <C-w>k

" Move between tabs
nnoremap <silent> <C-M-l> :tabn<CR>
nnoremap <silent> <C-M-h> :tabp<CR>

" Resize vim windows
nnoremap <silent> <C-Down> :resize -2<CR>
nnoremap <silent> <C-Up> :resize +2<CR>
nnoremap <silent> <C-Left> :vertical resize -2<CR>
nnoremap <silent> <C-Right> :vertical resize +2<CR>

" Zoom into one pane
nnoremap <silent> <Leader>z :tabnew %<CR>

" 'cd' towards the directory in which the current file is edited
nnoremap <Leader>cd :cd %:h<CR>

" See changes before saving file
nnoremap <Leader>df :w !diff % -<CR>

" Better multiple lines tabbing with < and >
vnoremap < <gv
vnoremap > >gv

" See buffers
nnoremap <Leader>fb :Buffers!<CR>

" Move in quickfix list (copen)
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>
" Move in location list (lopen)
nnoremap <silent> [l :lprevious<CR>
nnoremap <silent> ]l :lnext<CR>

" Clear highlighting of 'hlsearch' and call :diffupdate
nnoremap <silent> <leader>h :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><leader>h

" Toggle background theme between light and dark
nnoremap <M-t> :ToggleBackground<CR>

" Auto-indent whole file
nnoremap <silent> <localleader>== gg=G<C-o>

" ----------------
" # _LATE_IMPORTS_
" ----------------

execute 'source ' . stdpath('config') . '/plugins.vim'

" ## Import settings not tracked by Git
if !empty(glob(stdpath('config') . '/gitignore.vim'))
    source stdpath('config') . '/gitignore.vim'
endif

" ## Autocommands

augroup lang_indentation_by_filetype
    autocmd!
    autocmd Filetype astro,css,scss,javascript,typescript,html,json,xml,norg,cmake,mdx,jsx
        \ setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd Filetype meson,dts
        \ setlocal tabstop=4 shiftwidth=4 softtabstop=4
    autocmd BufRead,BufNewFile *.html,*.mdx setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
augroup END

augroup editor_configs_vim_options
    autocmd!
    " Do not continue newlines with comment character
    autocmd FileType * set formatoptions-=cro

    " Set the filetype based on the file extension, overriding any
    " 'filetype' that has already been set
    autocmd BufRead,BufNewFile *.launch set filetype=xml

    " Set which files will use highlight from start of file (fix for Javascript
    " inside HTML syntax)
    autocmd BufRead,BufNewFile *.html syntax sync fromstart

    autocmd FileType dts,kconfig setlocal noexpandtab
    autocmd BufEnter,BufWinEnter * if &textwidth > 0 | let &l:colorcolumn = &textwidth | else | setlocal colorcolumn= | endif
augroup END

" ## Set colorscheme and trigger highlight groups defined with `autocmd ColorScheme`
"    (must be on the bottom to trigger autocmds)
colorscheme catppuccin
let g:lightline.colorscheme = 'catppuccin'
let g:lightline#colorscheme#catppuccin#palette = {'inactive': {'right': [['#45475a', '#1e1e2e', 59, 16], ['#6c7086', '#1e1e2e', 60, 16]], 'middle': [['#45475a', '#1e1e2e', 59, 16]], 'left': [['#89b4fa', '#1e1e2e', 111, 16], ['#6c7086', '#1e1e2e', 60, 16]]}, 'replace': {'left': [['#181825', '#f38ba8', 16, 211], ['#89b4fa', '#1e1e2e', 111, 16]]}, 'normal': {'right': [['#6c7086', '#1e1e2e', 60, 16], ['#89b4fa', '#313244', 111, 59]], 'middle': [['#89b4fa', '#181825', 111, 16]], 'warning': [['#181825', '#f9e2af', 16, 223]], 'left': [['#181825', '#89b4fa', 16, 111], ['#89b4fa', '#1e1e2e', 111, 16]], 'error': [['#181825', '#f38ba8', 16, 211]]}, 'tabline': {'right': [['#45475a', '#1e1e2e', 59, 16], ['#6c7086', '#1e1e2e', 60, 16]], 'middle': [['#45475a', '#1e1e2e', 59, 16]], 'left': [['#6c7086', '#1e1e2e', 60, 16], ['#6c7086', '#1e1e2e', 60, 16]], 'tabsel': [['#89b4fa', '#45475a', 111, 59], ['#6c7086', '#1e1e2e', 60, 16]]}, 'visual': {'left': [['#181825', '#cba6f7', 16, 183], ['#89b4fa', '#1e1e2e', 111, 16]]}, 'insert': {'left': [['#181825', '#94e2d5', 16, 116], ['#89b4fa', '#1e1e2e', 111, 16]]}}
