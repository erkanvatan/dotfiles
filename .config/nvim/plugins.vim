" If plugin manager vim-plug isn't installed, install it automatically
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    echo "Downloading junegunn/vim-plug to manage plugins..."
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Disable ALE lsp for specific files
"autocmd FileType python let b:ale_disable_lsp = 1

call plug#begin('~/.config/nvim/plugged')

Plug '907th/vim-auto-save'
Plug 'mhinz/vim-startify' "changes default vim starting screen

Plug 'tpope/vim-vinegar' " plugin to enhance netrw
Plug 'ryanoasis/vim-devicons'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'

Plug 'itchyny/lightline.vim' "configurable statusline/tabline
Plug 'maximbaz/lightline-ale'

" git plugins
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

Plug 'tpope/vim-surround' "change surroundings like single or double quotes to different things (cs) or delete them (ds) easily, docs at :help surround
Plug 'preservim/nerdcommenter'

" Web development
Plug 'mattn/emmet-vim' " good for html tags
Plug 'turbio/bracey.vim' " live preview of html/css/js
    " cd to ~/.config/nvim/plugged/bracey.vim and run `npm install --prefix server`
"   dependencies for vim-svelte
Plug 'othree/html5.vim', {'for': ['html', 'html5', 'htm']}
Plug 'pangloss/vim-javascript' " javascript syntax highlighting
" Plug 'evanleck/vim-svelte', {'branch': 'main'} " svelte syntax highlighting
Plug 'HerringtonDarkholme/yats.vim' " typescript syntax highlighting
Plug 'Glench/Vim-Jinja2-Syntax' " Jinja2 syntax for Flask

Plug 'norcalli/nvim-colorizer.lua'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'lukas-reineke/indent-blankline.nvim'

" Syntax highlighting
Plug 'vim-python/python-syntax', { 'for': 'python' }
Plug 'plasticboy/vim-markdown', { 'for': ['markdown', 'md'] }
Plug 'shime/vim-livedown' " live preview of markdown
    " run `npm install -g livedown` after installation
Plug 'dense-analysis/ale'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'rust-lang/rust.vim'


Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'jiangmiao/auto-pairs'

" Snippets
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'

Plug 'voldikss/vim-floaterm' "floating terminal for vim
Plug 'alvan/vim-closetag'  " auto close HTML tags

" Themes
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'lifepillar/vim-solarized8'

Plug 'michaeljsmith/vim-indent-object' "adds an object to select everything at an indent level

Plug 'zef/vim-cycle' "ability to cycle through some group of words, easy edit
Plug 'lambdalisue/suda.vim' "suport for sudo in neovim

" SQL
Plug 'lifepillar/pgsql.vim' "support for PostgreSQL
Plug 'tpope/vim-dadbod' "modern database interface for Vim

" LaTeX
Plug 'lervag/vimtex' "filetype plugin for LaTeX files

" C Language
Plug 'cdelledonne/vim-cmake'

call plug#end()

function! SetupCommandAbbrs(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

" fzf config
let g:fzf_tags_command = 'ctags -R'
let g:fzf_layout = {'up':'~80%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5} }
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

"FZF Buffer Delete
function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bdelete' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BD call fzf#run(fzf#wrap({
  \ 'source': s:list_buffers(),
  \ 'sink*': { lines -> s:delete_buffers(lines) },
  \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
\ }))

" vim-startify config
let g:startify_session_dir = '~/.config/nvim/session'
let g:startify_bookmarks = ['~/.zshrc', '~/.config/nvim/plugins.vim', '~/.config/nvim/bindings.vim']
let g:startify_session_persistence = 1

" nerdcommenter config
"   Add spaces after comment delimiters by default
let g:NERDCreateDefaultMappings = 0
let g:NERDSpaceDelims = 1
autocmd FileType python let g:NERDDefaultAlign = 'left'

" vim-markdown config
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" bracey config
let g:bracey_server_port = 8000
let g:bracey_server_allow_remote_connections = 1

" vim-livedown config
let g:livedown_port = 8001
let g:livedown_browser = "xdg-open"
let g:livedown_open = 1

" ALE config (Asynchronous Lint Engine)
"   auto close error-list when it's the last buffer open
autocmd QuitPre * if empty(&bt) | lclose | endif

let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_fix_on_save = 0
" Show ale signs over gitgutter signs
let g:ale_sign_priority=30
let g:gitgutter_sign_priority=9

"   Don't lint when text is changed
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] [%code%] %s [%severity%]'

let g:ale_open_list = 0
let g:ale_list_window_size = 5
"   Commands to disable ALE fixers temporarily
command! ALEDisableFixersBuffer let b:ale_fix_on_save=0
command! ALEEnableFixersBuffer  let b:ale_fix_on_save=1

highlight ALEError ctermbg=White
highlight ALEError ctermfg=DarkRed
highlight ALEWarning ctermbg=LightYellow
highlight ALEWarning ctermfg=Darkmagenta

"   Set linters by file type
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'typescript': [],
\   'python': ['flake8'],
\   'html': ['tidy'],
\   'sql': [],
\   'css': ['stylelint'],
\   'scss': ['stylelint'],
\   'rust': ['analyzer'],
\   'latex': ['chktex'],
\   'c': ['cc']
\}

"   Set fixers by file type
"   remove trailing lines and trim whitespaces for every file type
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'typescript': ['eslint'],
\   'html': ['html-beautify'],
\   'css': ['stylelint'],
\   'scss': ['stylelint'],
\   'sql': ['pgformatter'],
\   'python': ['autopep8'],
\   'rust': ['rustfmt'],
\   'latex': ['chktex'],
\   'c': ['clang-format']
\}
autocmd FileType python let b:ale_warn_about_trailing_whitespace = 0
"   Disable ale diagnostics for some filetypes
"       Cannot disable eslint for svelte without disabling eslint for
"       javascript and typescript
autocmd FileType svelte let b:ale_linters = {'javascript': [], 'typescript': [], 'svelte': ['stylelint'], 'css': ['stylelint'], 'scss': ['stylelint']}
" autocmd FileType svelte :ALEDisableBuffer

" Disable line too long warning for flake8
let g:ale_python_flake8_options = '--max-line-length 120'
let g:ale_python_autopep8_options = '--max-line-length 120'
let g:ale_html_beautify_options = '--indent-size 2 --max-preserve-newlines 1 --wrap-line-length 120'

let g:ale_c_build_dir_names = ['build', 'bin', 'Debug', 'Release']
let g:ale_c_cc_options = '-std=c99 -Wall -Wpointer-arith -Wshadow -Wstrict-prototypes -Wundef -Wunused-result -Wwrite-strings'
" let g:ale_c_clangformat_options = "-style='{BasedOnStyle: WebKit, ColumnLimit: 120, BreakBeforeBraces: Linux, IndentWidth: 4, IndentCaseLabels: false, PointerAlignment: Right, SpaceBeforeAssignmentOperators: true}'"
let g:ale_c_clangformat_options = "-style='{BasedOnStyle: LLVM, ColumnLimit: 120, BreakBeforeBraces: Allman, IndentWidth: 4, IndentCaseLabels: false, PointerAlignment: Right, SpaceBeforeAssignmentOperators: true, AllowShortBlocksOnASingleLine: Never, AllowShortFunctionsOnASingleLine: None}'"

let g:ale_rust_analyzer_executable = "/home/arensonz/.config/coc/extensions/coc-rust-analyzer-data/rust-analyzer"
let g:ale_rust_rustfmt_options = "--config wrap_comments=true,format_code_in_doc_comments=true,overflow_delimited_expr=true"

let g:ale_javascript_prettier_use_local_config = 1
"let g:ale_javascript_prettier_executable = './node_modules/.bin/prettier'
"let g:ale_javascript_eslint_executable = './node_modules/.bin/eslint'

let g:ale_scss_stylelint_use_global = 1

autocmd FileType json let g:indentLine_conceallevel = 0



" coc config
"   coc extensions to install automatically
let g:coc_user_config = {}
let g:coc_global_extensions = [
    \ 'coc-json',
    \ 'coc-marketplace',
    \ 'coc-git',
    \ 'coc-vimlsp',
    \ 'coc-jedi',
    \ 'coc-eslint',
    \ 'coc-clangd',
    \ 'coc-cmake',
    \ 'coc-snippets',
    \ 'coc-emmet',
    \ 'coc-tsserver',
    \ 'coc-html',
    \ 'coc-bootstrap-classname',
    \ 'coc-cssmodules',
    \ 'coc-svelte',
    \ 'coc-db',
    \ 'coc-vimtex',
    \ 'coc-css'
    \ ]
" change line highlighting from line number only to line only for CocList
augroup mygroup
  autocmd!
  "     Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  "     Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
"   Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
"   Use C to open coc config
call SetupCommandAbbrs('C', 'CocConfig')
"   Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
"   Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
"   Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
"   Close the preview window when completion is done
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" enable CoC diagnostics for some filetypes
function! EnableCocDiagnosticBuffer()
    call coc#config('diagnostic', { 'enable': v:true })
    " silent call coc#rpc#restart()
endfunction

augroup enable_coc_diagnostic
    autocmd!
    autocmd FileType svelte,typescript,sql call EnableCocDiagnosticBuffer()
    autocmd FileType sql :GitGutterSignsDisable
augroup end

" python syntax
let g:python_highlight_all = 1

" rainbow_parentheses config
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
"   Auto activate RainbowParentheses
autocmd FileType * RainbowParentheses

" vim-floaterm config
"   Go back to the NORMAL mode using <C-\><C-N>
let g:floaterm_gitcommit='floaterm'
let g:floaterm_width=0.9
let g:floaterm_height=0.9

" vim-auto-save config
let g:auto_save_silent = 1  " do not display the auto-save notification
let g:auto_save = 0 " auto-save off by default
"   FileTypes to enable auto_save
"autocmd FileType python let b:auto_save = 1

let g:auto_save_events = ["InsertLeave", "TextChanged"] " set events to trigger auto-save

" vim-closetag config
"   These are the file types where this plugin is enabled.
let g:closetag_filetypes = 'html,xhtml,phtml,xml'
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.xml'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'


" emmet-vim config
let g:user_emmet_mode='nv' " only enable emmet in normal mode

" vim-cycle config
autocmd FileType python call AddCycleGroup('python', ['True', 'False'])

" gruvbox config
let g:gruvbox_contrast_light = 'hard'

" vimtex config
let g:tex_flavor='latex'
let g:vimtex_view_method = 'zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'
augroup tex_mappings
    autocmd!
    autocmd FileType tex,latex,context,plaintex setlocal spell  spelllang=tr
augroup END
let g:vimtex_compiler_latexmk = {
            \ 'build_dir' : 'build',
            \ 'options' : [
            \   '-verbose',
            \   '-file-line-error',
            \   '-synctex=1',
            \   '-interaction=nonstopmode',
            \   '-bibtex',
            \ ],
            \}
            " add the following line to options only when you want to use the `minted` syntax
            " highlighting package
            " \   '-shell-escape',

" indent-blankline config
let g:indent_blankline_show_first_indent_level = v:false
let g:indent_blankline_show_current_context = v:false

" netrw config
let g:netrw_keepdir = 0
let g:netrw_winsize = 25
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

" nvim-tresitter config
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "bash", "bibtex", "c", "cmake", "comment", "cpp", "css", "dockerfile", "http", "java", "json", "json5", "latex", "lua", "make", "norg", "python", "regex", "rust", "scss", "typescript", "javascript", "vim" },
  sync_install = true,
  ignore_install = {},
  highlight = {
    enable = true,
    -- list of language that will be disabled
    disable = {"html"},
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF
"   set which filetypes will use treesitter folding
"   if you want to activate folding for the current filetype
"   call :setlocal foldmethod=expr
set foldmethod=manual
autocmd FileType python,c,cpp,xml,html,xhtml setlocal foldmethod=expr
"       start with all folds open
autocmd FileType python,c,cpp,xml,html,xhtml normal zR
set foldexpr=nvim_treesitter#foldexpr()

" vim-cmake config
let g:cmake_link_compile_commands = 1
let g:cmake_root_markers = ['.git', '.svn']

" vim-closetag config
let g:closetag_filetypes = 'html,xhtml,phtml,svelte'
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.svelte'
