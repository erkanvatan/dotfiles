"If plugin manager vim-plug isn't installed, install automatically
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    echo "Downloading junegunn/vim-plug to manage plugins..."
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'mhinz/vim-startify' "changes default vim starting screen

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
Plug 'ryanoasis/vim-devicons', { 'on': 'NERDTreeToggle' }

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'liuchengxu/vista.vim' "viewer and finder for LSP symbols and tags
Plug 'junegunn/goyo.vim' "distraction-free writing

Plug 'itchyny/lightline.vim' "configurable statusline/tabline
Plug 'maximbaz/lightline-ale'

" git plugins
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

Plug 'tpope/vim-surround' "change surroundings like single or double quotes to different things (cs) or delete them (ds) easily
Plug 'scrooloose/nerdcommenter'

Plug 'norcalli/nvim-colorizer.lua'
Plug 'junegunn/rainbow_parentheses.vim'

" Syntax highlighting
Plug 'sheerun/vim-polyglot' "language pack for vim
Plug 'vim-python/python-syntax', { 'for': 'python' }
Plug 'plasticboy/vim-markdown', { 'for': ['markdown', 'md'] }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'dense-analysis/ale', { 'tag': 'v2.5.0'}

Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'jiangmiao/auto-pairs'

Plug 'honza/vim-snippets'
Plug 'voldikss/vim-floaterm' "floating terminal for vim
"Plug 'alvan/vim-closetag'  " auto close HTML tags

Plug 'morhetz/gruvbox', { 'as': 'gruvbox' } "vim theme

"Plug 'liuchengxu/vim-which-key'
Plug 'jeffkreeftmeijer/vim-numbertoggle' "automatically toggles between hybrid and absolute line numbers

call plug#end()

function! SetupCommandAbbrs(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

" gruvbox config
let g:gruvbox_italic=1 "enables italic support of gruvbox

" goyo config
let g:goyo_width = 120

" vista config
let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 1

" vim-polyglot config
let g:polyglot_disabled = ['python']

" fzf config
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-i': 'split',
  \ 'ctrl-s': 'vsplit' }
let g:fzf_tags_command = 'ctags -R'
let g:fzf_layout = {'up':'~80%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5} }
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" nerdtree config
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "x",
    \ "Staged"    : "✚",
    \ "Untracked" : "o",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "D",
    \ "Dirty"     : "~",
    \ "Clean"     : "*",
    \ 'Ignored'   : '&',
    \ "Unknown"   : "?"
    \ }
" " automatically close nerdtree if it's the last buffer open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" nerdcommenter config
" " Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" vim-markdown config
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" ALE (Asynchronous Lint Engine)
" " auto close error-list when it's the last buffer open
autocmd QuitPre * if empty(&bt) | lclose | endif

let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_fix_on_save = 1

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] [%code%] %s [%severity%]'

let g:ale_open_list = 1
let g:ale_list_window_size = 3
highlight ALEError ctermbg=White
highlight ALEError ctermfg=DarkRed
highlight ALEWarning ctermbg=LightYellow
highlight ALEWarning ctermfg=Darkmagenta

" " Set linters by file type
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'python': ['flake8']
\}
" " Set fixers by file type
" " remove trailing lines and trim whitespaces for every file type
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'python': ['autopep8']
\}
autocmd FileType python let b:ale_warn_about_trailing_whitespace = 0
autocmd FileType json let g:indentLine_conceallevel = 0

" coc config
" " coc extensions to install automatically
let g:coc_user_config = {}
let g:coc_global_extensions = [
    \ 'coc-json',
    \ 'coc-git',
    \ 'coc-vimlsp',
    \ 'coc-tsserver',
    \ 'coc-python',
    \ 'coc-clangd',
    \ 'coc-snippets',
    \ ]

augroup mygroup
  autocmd!
  " " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
" " Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" " Use C to open coc config
call SetupCommandAbbrs('C', 'CocConfig')
" " Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
" " Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" " Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
" " Close the preview window when completion is done
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" python syntax
let g:python_highlight_all = 1

" rainbow_parentheses config
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

" vim-floaterm config
let g:floaterm_gitcommit='floaterm'
let g:floaterm_width=0.8
let g:floaterm_height=0.8
