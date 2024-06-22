" --------------
" VIMRC CONTENTS
" --------------

" 01. _EDITOR_CONFIGS_
" 02. _PLUGINS_
" 03. _PLUGIN_SETTINGS_
" 04. _FUNCTIONS_
" 05. _KEYBINDINGS_
" 06. _LATE_IMPORTS_

" ------------------
" # _EDITOR_CONFIGS_
" ------------------

" Set leader keys (must be on top because plugins use it)
let mapleader="\<Space>"
let maplocalleader = "\<CR>"

" ## Set .config dir to use based on editor (vim vs nvim)
if !has('nvim')
    let s:config_dir = $HOME . "/.vim"
else
    let s:config_dir = $HOME . "/.config/nvim"
endif

" ## General options
set novisualbell " Disable screen flashes
set encoding=UTF-8 " Set character encoding
set timeoutlen=800 " Shrink the window for time-outable commands
set nofoldenable " Start with all folds open
set mouse=nvchr " Enable mouse for all modes except insert mode
set scrolloff=4 " Set number of screen lines to always keep above and below the cursor
set undofile " Enable undo history
if !isdirectory(s:config_dir . "/undodir")
    :call mkdir(s:config_dir . "/undodir")
endif
let &undodir = s:config_dir . "/undodir" " Select the directory to keep undofiles
set splitright " Open vertical splits to right
set splitbelow " Open horizontal splits to below
set conceallevel=0 " Do not conceal text (e.g. Neorg symbols)
set ignorecase " By default ignore case when searching
set smartcase " If intentionally uppercase letters are used in search then override ignorecase
set hlsearch " Keep search highlight
set list " Show whitespace characters
set showcmd " show keypresses in status line

augroup editor_configs_vim_options
    autocmd!
    " Do not continue newlines with comment character
    autocmd FileType * set formatoptions-=cro

    " Set width to break lines
    autocmd FileType * setlocal textwidth=120

    " Set in which file types should lines auto break
    autocmd FileType norg setlocal fo+=t
    autocmd FileType toml setlocal fo-=t

    " Set the filetype based on the file extension, overriding any
    " 'filetype' that has already been set
    autocmd BufRead,BufNewFile *.html set filetype=html.javascript.jinja
    autocmd BufRead,BufNewFile *.launch set filetype=xml

    " Set partial syntax by file extension
    autocmd BufRead,BufNewFile *.html call SyntaxRange#Include('{%', '%}', 'jinja') |
        \ call SyntaxRange#Include('{{', '}}', 'jinja')

    " Set which files will use highlight from start of file (fix for Javascript
    " inside HTML syntax)
    autocmd BufRead,BufNewFile *.html syntax sync fromstart

augroup END

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

" ### Set language-specific indendation
augroup lang_indentation_by_filetype
    autocmd!
    autocmd Filetype css,scss,javascript,typescript,html,json,xml,norg,cmake
        \ setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd Filetype meson
        \ setlocal tabstop=4 shiftwidth=4 softtabstop=4
    autocmd BufRead,BufNewFile *.html setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
augroup END

" ## Visual settings
set showtabline=2 " Always show tab line

" ## Configs recommended by CoC
set hidden
set updatetime=300
set nobackup " Disable backup files
set nowritebackup " Disable backup files
set shortmess+=c " Disable hit ENTER prompts for completion
set signcolumn=yes " Always show sign column, otherwise it will shift text

" -----------
" # _PLUGINS_
" -----------

" 1. Download plug.vim and put it in ~/.vim/autoload
"   curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" 2. Download plugins with :PlugInstall
" 3. Downloaded plugins are located in ~/.vim/plugged

if !has('nvim')
    " If plugin manager vim-plug isn't installed, install it automatically
    if empty(glob('~/.vim/autoload/plug.vim'))
        echo "Downloading junegunn/vim-plug to manage plugins..."
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif

    call plug#begin('~/.vim/plugged')

    " ## Plugins shared with Neovim
    Plug 'tpope/vim-sensible'
    Plug '907th/vim-auto-save'
    Plug 'mhinz/vim-startify' " change default vim starting screen
    Plug 'tpope/vim-surround' " change surroundings, :h surround
    Plug 'preservim/nerdcommenter' " comment/uncomment lines
    Plug 'jiangmiao/auto-pairs' " automatically add matching pairs for quotes, brackets, etc.
    Plug 'voldikss/vim-floaterm' " floating terminal
    Plug 'alvan/vim-closetag'  " auto close HTML tags
    Plug 'michaeljsmith/vim-indent-object' " adds an object to select everything at an indent level
    Plug 'zef/vim-cycle' " ability to cycle through some group of words, easy edit
    Plug 'lambdalisue/suda.vim' " suport for sudo in neovim
    Plug 'itchyny/lightline.vim' " configurable statusline/tabline
    Plug 'ryanoasis/vim-devicons' " lightline icons
    Plug 'dracula/vim', { 'as': 'dracula' }
    Plug 'tinted-theming/base16-vim' " color theme, https://tinted-theming.github.io/base16-gallery/
    Plug 'vim-python/python-syntax', { 'for': 'python' } " python syntax highlight
    Plug 'plasticboy/vim-markdown', { 'for': ['markdown', 'md'] } " markdown syntax highlight
    Plug 'tpope/vim-fugitive'
    Plug 'cdelledonne/vim-cmake'
    Plug 'ntpeters/vim-better-whitespace'
    Plug 'igankevich/mesonic' " meson build system integration
    Plug 'mbbill/undotree' " the undo history visualizer for VIM
    Plug 'tpope/vim-repeat' " enable repeating supported plugin maps with "."

    " ## Vim only plugins
    Plug 'tpope/vim-vinegar'

    call plug#end()

    " NOTE: Setting colorscheme resets highlight settings, this line must be on top of other settings
    colorscheme dracula
else
    " Source Neovim plugins
    source $HOME/.config/nvim/plugins.vim
endif

" -------------------
" # _PLUGIN_SETTINGS_
" -------------------

" 01. _vim_auto_save_
" 02. _vim_startify_
" 03. _vim_surround_
" 04. _nerdcommenter_
" 05. _auto_pairs_
" 06. _vim_floaterm_
" 07. _vim_closetag_
" 08. _vim_indent_object_
" 09. _vim_cycle_
" 10. _suda_vim_
" 11. _lightline_vim_
" 12. _vim_devicons_
" 13. _dracula_
" 14. _python_syntax_
" 15. _vim_markdown_
" 16. _vim_fugitive_
" 17. _vim_cmake_
" 18. _vim_vinegar_
" 19. _vim_sensible_
" 20. _vim_better_whitespace_
" 21. _undotree_


" ------------------
" ## _vim_auto_save_
" ------------------

" ### Settings
let g:auto_save_silent = 1  " do not display the auto-save notification
let g:auto_save = 0 " auto-save off by default
let g:auto_save_events = ["InsertLeave", "TextChanged"] " set events to trigger auto-save

" ### Keybindings
noremap <M-s> :AutoSaveToggle<CR>
inoremap <M-s> <ESC>:AutoSaveToggle<CR>a

" -----------------
" ## _vim_startify_
" -----------------

" ### Settings
let g:startify_session_dir = s:config_dir . '/session'
let g:startify_session_persistence = 1

" -----------------
" ## _vim_surround_
" -----------------

" ### Keybindings
" Works with parentheses(), brackets [], quotes (double or single), XML tags <q> </q>  and more
" NOTE: Use vS) instead of vS( to surround without space
" Example:
" cs'<q>     : To change 'Hello' to <q>Hello</q>
" ds'        : To remove delimiters from 'Hello'
" dst        : To remove the surrounding tag
" cst<p>     : To change the surrounding tag to <p>
" vS         : In visual mode, S surrounds the selected (vSt for tag)

" ------------------
" ## _nerdcommenter_
" ------------------

" ### Settings
" Add spaces after comment delimiters by default
let g:NERDCreateDefaultMappings = 0
let g:NERDSpaceDelims = 1
augroup nerdcommenter_group
    autocmd!
    autocmd FileType python let g:NERDDefaultAlign = 'left'
augroup END

" ### Keybindings
" [count]<leader>cc          : make lines commented
" [count]<leader>c<space>    : toggle line's comment status (commented/uncommented)
map <leader>cc <plug>NERDCommenterComment
map <leader>cu <plug>NERDCommenterUncomment
map <leader>ct <plug>NERDCommenterToggle
map <leader>cm <plug>NERDCommenterMinimal

" ---------------
" ## _auto_pairs_
" ---------------

" ### Settings
augroup auto_pairs_group
    autocmd!
    autocmd FileType norg let g:AutoPairsMapSpace = 0
augroup END
" fix coc-snippets inserting newline when selecting a snippet with enter
let g:AutoPairsMapCR = 0

" ### Keybindings
" <M-p> : Toggle auto-pairs
" <M-e> : Insert () or {} or [] before something then hit <M-e> to fast wrap
" <M-n> : Jump to next closed pair
" Use Ctrl-V) to insert paren without trigerring plugin
" Use x or DEL to delete the character inserted by the plugin

" -----------------
" ## _vim_floaterm_
" -----------------

" ### Settings
" Go back to the NORMAL mode using <C-\><C-N>
let g:floaterm_gitcommit='floaterm'
let g:floaterm_width=0.9
let g:floaterm_height=0.9
let g:floaterm_autoclose=2

" ### Keybindings
let g:floaterm_keymap_toggle = '<C-f>'

" -----------------
" ## _vim_closetag_
" -----------------

" ### Settings
" These are the file types where this plugin is enabled.
let g:closetag_filetypes = 'html,xhtml,phtml,xml'
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.xml'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'

" ### Keybindings
" Shortcut for closing tags, default is '>'
let g:closetag_shortcut = '>'

" ----------------------
" ## _vim_indent_object_
" ----------------------

" ### Keybindings
" Defines two new text objects to select only current indentation level
" <count>ai 	An Indentation level and line above.
" <count>ii 	Inner Indentation level (no line above).
" <count>aI 	An Indentation level and lines above/below.

" --------------
" ## _vim_cycle_
" --------------

" ### Settings
augroup vim_cycle_group
    autocmd!
    autocmd FileType python call AddCycleGroup('python', ['True', 'False'])
augroup END

" ### Keybindings
" Move cursor on a word and hit <C-A> or <C-X> to toggle between pair of
"   words or even increment-decrement a number

" -------------
" ## _suda_vim_
" -------------

" ------------------
" ## _lightline_vim_
" ------------------

" ### Settings
function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

function! GitStatus() abort
    return get(g:, 'coc_git_status', '')
endfunction

function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:p:.') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunction

let g:lightline = {
      \ 'colorscheme': 'dracula',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste', 'readonly' ],
      \             [ 'gitbranch', 'filename' ],
      \             [ 'cocstatus' ] ],
      \   'right': [['percent', 'lineinfo'],
      \             [ 'filetype', 'fileencoding' ],
      \             [ 'currentfunction', 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ]]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'gitbranch': 'GitStatus',
      \   'currentfunction': 'CocCurrentFunction',
      \   'filename': 'LightlineFilename',
      \ },
      \ 'component_expand': {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_infos': 'lightline#ale#infos',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ },
      \ 'component_type': {
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \ }
      \ }
" -----------------
" ## _vim_devicons_
" -----------------

" ------------
" ## _dracula_
" ------------

" ------------------
" ## _python_syntax_
" ------------------

" ### Settings
let g:python_highlight_all = 1

" -----------------
" ## _vim_markdown_
" -----------------

" ### Settings
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" -----------------
" ## _vim_fugitive_
" -----------------

" ### Keybindings
"   Enter :Git and then do g? to checkout all hotkeys
"   After :Git use cc to enter commit buffer
"   to add the file under cursor to .gitignore use {anynumber}gI
"   git status
nnoremap <leader>gs :G<CR>
"   solving merge conflicts
nnoremap <leader>gj :diffget //3<CR>
nnoremap <leader>gf :diffget //2<CR>

" --------------
" ## _vim_cmake_
" --------------

" ### Settings
let g:cmake_link_compile_commands = 1
let g:cmake_root_markers = ['.git', '.svn']
" let g:cmake_build_options = []
let g:cmake_generate_options = ["-D CMAKE_C_COMPILER=/usr/bin/gcc-12", "-D CMAKE_CXX_COMPILER=/usr/bin/g++-12"]

augroup vim_cmake_group
    " autoclose vim-cmake window after successfull build
    autocmd! User CMakeBuildSucceeded CMakeClose
augroup END

" ### Keybindings
nnoremap <leader>cg :CMakeGenerate<CR>
nnoremap <leader>cb :CMakeBuild<CR>
nnoremap <leader>co :CMakeOpen<CR>

" ----------------
" ## _vim_vinegar_
" ----------------

" -----------------
" ## _vim_sensible_
" -----------------

" -----------------------
" _vim_better_whitespace_
" -----------------------

" ### Settings
let g:better_whitespace_enabled=1
highlight ExtraWhitespace ctermbg=LightRed ctermfg=black guibg='#FFB86C' guifg=black

" ----------
" _undotree_
" ----------

" ### Keybindings
nnoremap <silent> <M-u> :UndotreeToggle<CR>

" -------------
" # _FUNCTIONS_
" -------------

" 01. _LongLineHighlightOn_
" 02. _ToggleBackground_
" 03. _TermForceCloseAll_

" ------------------------
" ## _LongLineHighlightOn_
" ------------------------
" https://gist.github.com/fgarcia/9704429#file-long_lines-vim
" https://stackoverflow.com/q/395114

function! LongLineHighlightOn()
    if exists("w:llh")
        call matchdelete(w:llh)
    endif

    highlight OverLength ctermbg=LightBlue ctermfg=black guibg=LightBlue guifg=black
    if &ft ==? 'css' || &ft ==? 'scss'
        let l:length = 90
        let w:llh = matchadd("OverLength", '\%' . (l:length + 1) . 'v')
    elseif &ft != 'floaterm' && &ft != 'fzf'
        let l:length = 120
        let w:llh = matchadd("OverLength", '\%' . (l:length + 1) . 'v')
    endif
endfunction

"   Set long line length marker colors
augroup set_long_line_highlight
    autocmd!
    autocmd FileType * call LongLineHighlightOn()
augroup END

" ---------------------
" ## _ToggleBackground_
" ---------------------

function! ToggleBackground()
    if &background =~? 'dark'
        echo "Changing to light theme"
        set background=light  " for the light version of the theme
        " colorscheme base16-gruvbox-light-hard
        " let g:lightline.colorscheme = 'Tomorrow'
        " colorscheme base16-catppuccin-latte
        " let g:lightline.colorscheme = 'Tomorrow'
        colorscheme base16-tomorrow
        let g:lightline.colorscheme = 'Tomorrow'
        " colorscheme base16-da-one-paper
        " let g:lightline.colorscheme = 'Tomorrow'
    else
        echo "Changing to dark theme"
        set background=dark   " for the dark version of the theme
        colorscheme dracula
        let g:lightline.colorscheme = 'dracula'
    endif

    try
        call LongLineHighlightOn()
        call lightline#init()
        call lightline#colorscheme()
        call lightline#update()
    catch
    endtry
endfunction

" ----------------------
" ## _TermForceCloseAll_
" ----------------------
" https://www.reddit.com/r/vim/comments/fwedfx/comment/fmnwar1

function! s:TermForceCloseAll() abort
    let term_bufs = filter(range(1, bufnr('$')), 'getbufvar(v:val, "&buftype") == "terminal"')
    for t in term_bufs
        execute "bd! " t
    endfor
endfunction

augroup term_force_close_all
    autocmd!
    autocmd QuitPre * call <sid>TermForceCloseAll()
augroup END

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

" Open netrw
if !has('nvim')
    nnoremap <C-c> :Lexplore 30<CR>
endif

" Move in quickfix list (copen)
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>

" Clear highlighting of 'hlsearch' and call :diffupdate
nnoremap <silent> <leader>h :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><leader>h

" Toggle background theme between light and dark
nnoremap <silent> <M-t> :call ToggleBackground()<CR>

" Set bindings for default Vim autocompletion support
" :help ins-completion
" <C-n>         : start word completion from file
" <C-x><C-o>    : start omni completion
if !has('nvim')
    " Exit pum without inserting with <Esc>
    inoremap <expr> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>"
    " Select with <CR>
    inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
    " Use <Tab> and <S-Tab> to view completion suggestions
    inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : exists("g:loaded_snips")
        \ ? "\<C-r>=TriggerSnippet()\<CR>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : exists("g:loaded_snips")
        \ ? "\<C-r>=BackwardsSnippet()\<CR>" : "\<S-Tab>"
endif

" Fix meta keybindings in Vim
if !has('nvim')
    execute "set <M-a>=\ea"
    execute "set <M-e>=\ee"
    execute "set <M-n>=\en"
    execute "set <M-p>=\ep"
    execute "set <M-s>=\es"
    execute "set <M-t>=\et"
    execute "set <M-u>=\eu"
endif

" ----------------
" # _LATE_IMPORTS_
" ----------------

" ## Import settings not tracked by Git
if !has('nvim') && !empty(glob("$HOME/.vimrc.gitignore"))
    source $HOME/.vimrc.gitignore
elseif has('nvim') && !empty(glob("$HOME/.config/nvim/gitignore.vim"))
    source $HOME/.config/nvim/gitignore.vim
endif
