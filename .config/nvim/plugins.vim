" --------------------
" PLUGINS.VIM CONTENTS
" --------------------

" 01. _PLUGINS_
" 02. _PLUGIN_SETTINGS_

" -----------
" # _PLUGINS_
" -----------

" 1. Download plug.vim and put it in ~/.vim/autoload
"   curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" 2. Download plugins with :PlugInstall
" 3. Downloaded plugins are located in ~/.vim/plugged

" If plugin manager vim-plug isn't installed, install it automatically
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    echo "Downloading junegunn/vim-plug to manage plugins..."
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

    " ## Plugins shared with Vim
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

" ## Extra Vim plugins
Plug 'shime/vim-livedown' " live preview of markdown
"   run `npm install -g livedown` after installation

Plug 'maximbaz/lightline-ale' " ale integration for lightline
Plug 'honza/vim-snippets' " compilation of useful snippets
Plug 'SirVer/ultisnips' " snippet manager
Plug 'dense-analysis/ale' " configurable async linter/fixer for programming languages
Plug 'neoclide/coc.nvim', { 'branch': 'release' } " load extensions like VSCode and host language servers
Plug 'junegunn/gv.vim' " git commit browser
Plug 'lifepillar/pgsql.vim' " support for PostgreSQL
Plug 'tpope/vim-dadbod' " modern database interface for Vim
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " fuzzy file finder
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'liuchengxu/vista.vim' " tags and lsp symbols viewer
Plug 'puremourning/vimspector' " A multi-language debugging system for Vim

" ### Web Development
Plug 'mattn/emmet-vim' " good for html tags
Plug 'othree/html5.vim', {'for': ['html', 'html5', 'htm']} " html5 syntax highlight
Plug 'pangloss/vim-javascript' " javascript syntax highlight
Plug 'Glench/Vim-Jinja2-Syntax' " Jinja2 syntax highlight
Plug 'inkarkat/vim-SyntaxRange'
" Plug 'HerringtonDarkholme/yats.vim' " typescript syntax highlighting

" ## Neovim only plugins
Plug 'norcalli/nvim-colorizer.lua' " colorize color names and RGB codes
Plug 'lukas-reineke/indent-blankline.nvim' " add vertical indent guides
Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
Plug 'nvim-tree/nvim-tree.lua' " tree-like file browser
Plug 'nvim-neorg/neorg', { 'tag': 'v7.0.0', 'do': ':Neorg sync-parsers'} | Plug 'nvim-lua/plenary.nvim' " Neovim org-like format
Plug 'andrewferrier/debugprint.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " better parsing for syntax highlight
Plug 'ThePrimeagen/refactoring.nvim'
Plug 'Badhi/nvim-treesitter-cpp-tools'
Plug 'HiPhish/rainbow-delimiters.nvim'

call plug#end()

" -------------------
" # _PLUGIN_SETTINGS_
" -------------------

" 01. _vim_livedown_
" 02. _lightline_ale_
" 03. _vim_one_
" 04. _base16_vim_
" 05. _vim_snippets_
" 06. _ultisnips_
" 07. _ale_
" 08. _coc_nvim_
" 09. _gv_vim_
" 10. _pgsql_vim_
" 11. _vim_dadbod_
" 12. _emmet_vim_
" 13. _html5_vim_
" 14. _vim_javascript_
" 15. _vim_jinja2_syntax_
" 16. _vim_syntaxrange_
" 17. _yats_vim_
" 18. _nvim_colorizer_lua_
" 19. _indent_blankline_nvim_
" 20. _nvim_web_devicons_
" 21. _nvim_tree_lua_
" 22. _neorg_
" 23. _debugprint_nvim_
" 24. _gitsigns_nvim_
" 25. _nvim_treesitter_
" 26. _refactoring_nvim_
" 27. _nvim_treesitter_cpp_tools_
" 28. _fzf_vim_
" 29. _fzf_checkout_vim_
" 30. _vista_vim_
" 31. _vimspector_
" 32. _rainbow_delimiters_nvim_

" -----------------
" ## _vim_livedown_
" -----------------

" ### Settings
let g:livedown_port = 8001
let g:livedown_browser = "xdg-open"
let g:livedown_open = 1

" ### Keybindings
nmap <leader>tm :LivedownToggle<CR>

" ------------------
" ## _lightline_ale_
" ------------------

" ------------
" ## _vim_one_
" ------------

" ---------------
" ## _base16_vim_
" ---------------

" -----------------
" ## _vim_snippets_
" -----------------

" --------------
" ## _ultisnips_
" --------------

" ### Keybindings
let g:UltiSnipsExpandTrigger="<C-tab>"

" --------
" ## _ale_
" --------

" ### Settings
augroup ale_group
    autocmd!
    " Auto close error-list when it's the last buffer open
    autocmd QuitPre * if empty(&bt) | lclose | endif

    " Ale settings by filetype
    autocmd FileType python let b:ale_warn_about_trailing_whitespace = 0

    " Disable ale_linters by filetype
    autocmd FileType html.javascript.jinja let b:ale_linters =
        \ {'html': [], 'css': ['stylelint'], 'scss': ['stylelint'], 'javascript': ['eslint'], 'typescript': ['eslint']}

    " Disable ALE linting for specific files (CoC)
    autocmd FileType typescript,sql,json,c,cc,c++,cpp let g:ale_lint_on_text_changed = 0
        \ | let g:ale_lint_on_insert_leave = 0
        \ | let g:ale_lint_on_save = 0
        \ | let g:ale_lint_on_enter = 0
augroup END

let g:ale_fix_on_save = 0
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_fix_on_save = 0

" Show ale signs over gitsigns
let g:ale_sign_priority=30

" Don't lint when text is changed
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] [%code%] %s [%severity%]'

let g:ale_open_list = 0
let g:ale_list_window_size = 5

" Commands to disable ALE fixers temporarily
command! ALEDisableFixersBuffer let b:ale_fix_on_save=0
command! ALEEnableFixersBuffer  let b:ale_fix_on_save=1

highlight ALEError ctermbg=White
highlight ALEError ctermfg=DarkRed
highlight ALEWarning ctermbg=LightYellow
highlight ALEWarning ctermfg=Darkmagenta

" Set linters by file type
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
\   'sh': ['shell'],
\   'c': [],
\   'cpp': []
\}

" Set fixers by file type
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
\   'sh': ['shfmt'],
\   'c': ['clang-format'],
\   'cpp': ['clang-format']
\}

" Python
let g:ale_python_flake8_options = '--max-line-length 120 --ignore=E501'
let g:ale_python_autopep8_options = '--max-line-length 120'

" HTML
let g:ale_html_beautify_options = '--indent-size 2 --max-preserve-newlines 2 --wrap-line-length 120'
let g:ale_html_tidy_options = "-config $HOME/projects/web/dotfiles/jinja/.tidyrc"

" C/C++
let g:ale_c_clangformat_options = "-style='{BasedOnStyle: WebKit, ColumnLimit: 120, BreakBeforeBraces: Stroustrup, IndentWidth: 4, IndentCaseLabels: false, PointerAlignment: Left, SpaceBeforeAssignmentOperators: true, AllowShortBlocksOnASingleLine: Never, AllowShortFunctionsOnASingleLine: InlineOnly, AlwaysBreakTemplateDeclarations: Yes}'"
" let g:ale_c_clangformat_options = "--assume-filename=$HOME/.config/.clang-format"

" Rust
let g:ale_rust_analyzer_executable = "$HOME/.config/coc/extensions/coc-rust-analyzer-data/rust-analyzer"
let g:ale_rust_rustfmt_options = "--config wrap_comments=true,format_code_in_doc_comments=true,overflow_delimited_expr=true"

" Javascript
let g:ale_javascript_prettier_use_local_config = 1
"let g:ale_javascript_prettier_executable = './node_modules/.bin/prettier'
"let g:ale_javascript_eslint_executable = './node_modules/.bin/eslint'

" Scss
let g:ale_scss_stylelint_use_global = 1

" ### Functions
function! AleAutofixToggle()
    if g:ale_fix_on_save
        echo "g:ale_fix_on_save = 0"
        let g:ale_fix_on_save = 0
    else
        echo "g:ale_fix_on_save = 1"
        let g:ale_fix_on_save = 1
    endif
endfunction

" ### Keybindings
nmap <silent> [a <Plug>(ale_previous_wrap)
nmap <silent> ]a <Plug>(ale_next_wrap)
noremap <M-a> :call AleAutofixToggle()<CR>

" -------------
" ## _coc_nvim_
" -------------
"  <C-o> to enter normal mode in CocList

" ### Settings
augroup coc_nvim_group
    autocmd!
    " Highlight the symbol and its references when holding the cursor.
    autocmd CursorHold * silent call CocActionAsync('highlight')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    " Close the preview window when completion is done
    autocmd CompleteDone * if pumvisible() == 0 | pclose | endif
    " Enable coc-diagnostic by filetype
    autocmd FileType typescript,sql,json,c,cc,cpp,c++,python call EnableCocDiagnosticBuffer()
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
augroup END

let g:coc_user_config = {}
" CoC extensions to install automatically
let g:coc_global_extensions = [
    \ 'coc-bootstrap-classname',
    \ 'coc-clang-format-style-options',
    \ 'coc-clangd',
    \ 'coc-cmake',
    \ 'coc-css',
    \ 'coc-cssmodules',
    \ 'coc-docker',
    \ 'coc-emmet',
    \ 'coc-eslint',
    \ 'coc-git',
    \ 'coc-html',
    \ 'coc-json',
    \ 'coc-lists',
    \ 'coc-marketplace',
    \ 'coc-pyright',
    \ 'coc-rust-analyzer',
    \ 'coc-sh',
    \ 'coc-snippets',
    \ 'coc-sql',
    \ 'coc-toml',
    \ 'coc-tsserver',
    \ 'coc-vimlsp',
    \ 'coc-yaml',
    \ ]
" coc-clangd
"   Create a file called ".clang-format" at the root of your C project
"   with the following content:
"   DisableFormat: true

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call CocActionAsync('runCommand', 'editor.action.organizeImport')

" ### Functions
function! EnableCocDiagnosticBuffer()
    call coc#config('diagnostic', { 'enable': v:true })
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

function! SetupCommandAbbrs(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction
" Use C to open coc config
call SetupCommandAbbrs('C', 'CocConfig')

" ### Keybindings
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
"
" Exit pum without inserting with <C-e>

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<S-TAB>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <c-M-space> to trigger completion.
"   The suggestion box for function parameters is signatureHelp.
"   If you want to reopen it, you need to trigger triggerCharacters in your function, usually is ( and ,.
"   The triggerCharacters is defined by LS.
inoremap <silent><expr> <c-M-space> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" Jump bindings, to go back to previous location use Ctrl+O
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

" Symbol renaming.
"   If your language server formats code after textEdit, this can cause it to auto
"   format. Check your language server provider (e.g. clangd).
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
nmap <silent> <leader>ri :CocCommand workspace.inspectEdit<CR>
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-d> and <C-u> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
  nnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"
  inoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
  vnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"
endif

" coc-snippets
imap <C-k> <Plug>(coc-snippets-expand-jump)
vmap <C-j> <Plug>(coc-snippets-select)
"   Use <leader>x to convert visual selected code to snippet
xmap <leader>x <Plug>(coc-convert-snippet)


" -----------
" ## _gv_vim_
" -----------

" --------------
" ## _pgsql_vim_
" --------------

" ---------------
" ## _vim_dadbod_
" ---------------

" ### Settings
" Usage
"   :DBList
"   :DBSelect db_id

let g:dadbods = []

command! -nargs=1 DBSelect :call DBSelected(<f-args>)
command! DBList :call DBListed()

" ### Functions
function! DBListed()
    echo "ID | DB Name | URL"
    echo "------------------"
    let i = 0
    for line in g:dadbods
        echo i'|'line.name "\t|" line.url
        let i += 1
    endfor
endfunction

function! DBSelected(dadbodIndex)
    let b:db = g:dadbods[a:dadbodIndex].url
    echomsg 'DB "' . g:dadbods[a:dadbodIndex].name . '" is selected.'
endfunction

" ### Keybindings
" Setup:
"     let b:db = "postgresql://[username[:password]@][host][:port][/dbname]"
" In visual mode:
"     select the query and press <leader>db to execute the query
" In normal mode:
"     press <leader>dbb to execute query on the line
"     press <leader>db + text-object to run the queries by specifying text
"      object
xnoremap <expr> <Plug>(DBExe)     db#op_exec()
nnoremap <expr> <Plug>(DBExe)     db#op_exec()
nnoremap <expr> <Plug>(DBExeLine) db#op_exec() . '_'

xmap <leader>db  <Plug>(DBExe)
nmap <leader>db  <Plug>(DBExe)
omap <leader>db  <Plug>(DBExe)
nmap <leader>dbb <Plug>(DBExeLine)

" --------------
" ## _emmet_vim_
" --------------

" ### Settings
let g:user_emmet_mode='nv' " only enable emmet in normal mode

" ### Keybindings
" All commands and bindings:  https://raw.githubusercontent.com/mattn/emmet-vim/master/TUTORIAL
" Trigger key ,,      you can also use autocomplete to select abbreviation
" Example: Write one of the keywords listed below, go to normal mod and
"          press ,,
" remove a tag                : <C-y>k
" update image's size         : <C-y>i
" make anchor from a URL      : <C-y>a
" make quoted text from a URL : <C-y>A
"
" tag expansion               : div
" nested tag expansion        : div>div1>div2>div3
" creating lists              : div#mylist>li*10>{List Item} (list with 10
"                                                             items)
" creating lists with indices : div#mylist>li*10>{List Item $}
" creating sibling tags       : div+h1+h2
" shortcuts                   : bq, btn, hdr, ftr
" ID expansion                : tag_name#id_name
" class expansion             : tag_name.class_name
" default class expansion     : .class_name (div is assumed as tag)
" multi class expansion       : .class1.class2
" ID & class expansion        : #myid.myclass

let g:user_emmet_leader_key=','

" --------------
" ## _html5_vim_
" --------------

" -------------------
" ## _vim_javascript_
" -------------------

" ----------------------
" ## _vim_jinja2_syntax_
" ----------------------

" ---------------------
" ## _vim_syntax_range_
" ---------------------

" -------------
" ## _yats_vim_
" -------------

" -----------------------
" ## _nvim_colorizer_lua_
" -----------------------

" ### Settings
lua << EOF
require ('colorizer').setup {
    css = { css = true; }; -- Enable parsing rgb(...) functions in css.
    html = { names = false; } -- Disable parsing "names" like Blue or Gray
}
EOF

" ### Keybindings
nnoremap <leader>tc :ColorizerToggle<CR>

"--------------------------
" ## _indent_blankline_nvim_
" --------------------------

" ### Settings
lua << EOF
require'ibl'.setup {
    scope = {
        show_start = false,
        show_end = false
    }
}

local hooks = require 'ibl.hooks'

hooks.register(
    hooks.type.WHITESPACE,
    hooks.builtin.hide_first_space_indent_level
)
EOF

" ----------------------
" ## _nvim_web_devicons_
" ----------------------

" ------------------
" ## _nvim_tree_lua_
" ------------------

" ### Settings
highlight NvimTreeNormalFloat guibg='#282A36'

lua << EOF
-- Disable netrw at the very start of your init.lua (strongly advised)
-- Disabling netrw also disables scp remote editing capability. You can instead use hijack_netrw option
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
    hijack_cursor = true,
    sync_root_with_cwd = true,

    update_focused_file = {
        enable = true,
        update_root = false,
    },

    actions = {
        change_dir = {
            enable = true,
            global = true,
        }
    },

    disable_netrw = false,
    hijack_netrw = true,
    hijack_directories = {
        enable = false,
        auto_open = false,
    },

    sort_by = "name",
    view = {
        float = {
            enable = true,
            quit_on_focus_loss = true,
            open_win_config = {
                border = "rounded",
                width = 40, -- in character cells
                height = 55,
                row = 1,
                col = 0,
            },
        },
        adaptive_size = false,
        preserve_window_proportions = false,
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = false,
    },
    git = {
        enable = false
    },
})
EOF

" ### Keybindings
nnoremap <silent> <C-c> :NvimTreeToggle<CR>
nnoremap <silent> <leader>pv :NvimTreeFindFile!<CR>

" ----------
" ## _neorg_
" ----------

" ### Settings
augroup neorg_group
    autocmd!
    autocmd Bufread,BufNewFile *.norg highlight @neorg.markup.italic gui=italic
    autocmd Bufread,BufNewFile *.norg highlight @neorg.lists.unordered.1.prefix gui=bold guifg=Yellow
    autocmd Bufread,BufNewFile *.norg highlight @neorg.lists.unordered.2.prefix gui=bold guifg=Orange
    autocmd Bufread,BufNewFile *.norg highlight @neorg.lists.unordered.3.prefix gui=bold guifg=SlateBlue
    autocmd Bufread,BufNewFile *.norg highlight @neorg.lists.unordered.4.prefix gui=bold guifg=Yellow
    autocmd Bufread,BufNewFile *.norg highlight @neorg.lists.unordered.5.prefix gui=bold guifg=Orange
    autocmd Bufread,BufNewFile *.norg highlight @neorg.lists.unordered.6.prefix gui=bold guifg=SlateBlue
augroup END

lua << EOF
require('neorg').setup {
    load = {
        ["core.defaults"] = {},
        ["core.keybinds"] = {
            config = {
                hook = function(keybinds)
                    keybinds.unmap("norg", "n", "<C-Space>")
                end,
            },
        },
        ["core.concealer"] = {
            config = {
                icon_preset = "diamond",
            },
        },
        ["core.export"] = {},
        ["core.export.markdown"] = {},
        ["core.qol.toc"] = {},
        ["core.dirman"] = {
            config = {
                workspaces = {
                    personal_ws = "~/Documents/neorg/personal",
                    work_ws = "~/Documents/neorg/work"
                },
                autochdir = false, -- Automatically change the directory to the current workspace's root every time
                autodetect = false,
                index = "", -- The name of the main (root) .norg file
            }
        },
    }
}
EOF

" ### Keybindings
nnoremap <silent> <localleader>nm :Neorg inject-metadata<CR>
nnoremap <silent> <localleader>t :Neorg toc left <CR> :vertical resize 50<CR>
nnoremap <silent> <localleader>a i
" insert anchor
nnoremap <silent> <localleader>a i<C-v>{<C-v>}<Esc>h"+p
" autoindent file
nnoremap <silent> <localleader>i gg=G<C-o>

" --------------------
" ## _debugprint_nvim_
" --------------------

" ### Settings
lua << EOF
require('debugprint').setup()
    create_keymaps = false
EOF

" ### Keybindings
lua << EOF
vim.keymap.set("n", "<Leader>dpp", function()
    return require('debugprint').debugprint()
end, {
    expr = true,
})
vim.keymap.set("n", "<Leader>dpP", function()
    return require('debugprint').debugprint({ above = true })
end, {
    expr = true,
})
vim.keymap.set({"n", "v"}, "<Leader>dpv", function()
    return require('debugprint').debugprint({ variable = true })
end, {
    expr = true,
})
vim.keymap.set({"n", "v"}, "<Leader>dpV", function()
    return require('debugprint').debugprint({ above = true, variable = true })
end, {
    expr = true,
})
vim.keymap.set("n", "<Leader>dpo", function()
    return require('debugprint').debugprint({ motion = true })
end, {
    expr = true,
})
vim.keymap.set("n", "<Leader>dpO", function()
    return require('debugprint').debugprint({ above = true, motion = true })
end, {
    expr = true,
})
EOF

" ------------------
" ## _gitsigns_nvim_
" ------------------

" ### Settings
lua << EOF
require('gitsigns').setup()
EOF

" --------------------
" ## _nvim_treesitter_
" --------------------

" ### Settings
lua << EOF
require'nvim-treesitter.configs'.setup {
    -- Additional parsers:
    -- :TSInstall bibtex c_sharp css http html java latex norg rust scss sql typescript javascript
    ensure_installed = {
        "bash",
        "c",
        "cmake",
        "comment",
        "cpp",
        "dockerfile",
        "json",
        "lua",
        "make",
        "python",
        "regex",
        "vim",
        "vimdoc",
        "yaml"
    },
    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,
    -- Automatically install missing parsers when entering buffer
    auto_install = false,
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
"   WARNING: This causes slowdown in ALEFix
" autocmd FileType python,c,cpp,xml,html,xhtml,lua,vim,norg setlocal foldmethod=expr

"   if you want to activate folding for the current filetype call
"       :setlocal foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" ---------------------
" ## _refactoring_nvim_
" ---------------------

" ### Settings
" Usage: `:Refactor e<TAB>`
lua << EOF
require('refactoring').setup({
    -- prompt for return type
    prompt_func_return_type = {
        cpp = true,
        c = true,
    },
    -- prompt for function parameters
    prompt_func_param_type = {
        cpp = true,
        c = true,
    },
})
EOF

" ### Keybindings
" Keybind: `<leader>rr`

lua << EOF
-- prompt for a refactor to apply when the remap is triggered
vim.keymap.set(
    {"n", "x"},
    "<leader>rr",
    function() require('refactoring').select_refactor() end
)
-- Note that not all refactor support both normal and visual mode
EOF

" ------------------------------
" ## _nvim_treesitter_cpp_tools_
" ------------------------------

" ### Settings
lua << EOF
require 'nt-cpp-tools'.setup({
    preview = {
        quit = 'q', -- optional keymapping for quit preview
        accept = '<tab>' -- optional keymapping for accept preview
    },
    header_extension = 'h', -- optional
    source_extension = 'cpp', -- optional
    custom_define_class_function_commands = { -- optional
        TSCppImplWrite = {
            output_handle = require'nt-cpp-tools.output_handlers'.get_add_to_cpp()
        }
        --[[
        <your impl function custom command name> = {
            output_handle = function (str, context)
                -- string contains the class implementation
                -- do whatever you want to do with it
            end
        }
        ]]
    }
})
EOF

" ------------
" ## _fzf_vim_
" ------------

" ### Settings
let g:fzf_tags_command = 'ctags -R'
let g:fzf_layout = {'up':'~80%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5} }
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" FZF Buffer Delete
command! BD call fzf#run(fzf#wrap({
  \ 'source': s:list_buffers(),
  \ 'sink*': { lines -> s:delete_buffers(lines) },
  \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
\ }))

" Don't consider filename as a match in :Rg command
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case "
    \ .shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

" ### Functions
function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bdelete' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

" ### Keybindings
" Select multiple things with Shift + TAB
" Open entries in split panes with TAB
" Open entries in different tabs with Ctrl + T

" :Maps     : Show list of normal mode bindings

nnoremap <leader>ff :Files!<CR>
nnoremap <leader>ft :BTags!<CR>
nnoremap <leader>fT :Tags!<CR>
nnoremap <leader>fl :BLines!<CR>
nnoremap <leader>fL :Lines<CR>
nnoremap <leader>fb :Buffers!<CR>
nnoremap <leader>fg :Rg!<CR>
" Git Bindings
nnoremap <leader>gf :GFiles!?<CR>
nnoremap <leader>gF :GFiles!<CR>
nnoremap <leader>gc :BCommits!<CR>
nnoremap <leader>gC :Commits!<CR>

" Change default bindings
let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-s': 'split',
    \ 'ctrl-v': 'vsplit'
    \ }

" ---------------------
" ## _fzf_checkout_vim_
" ---------------------

" ### Keybindings
" ctrl + d to delete the branch under cursor
" alt + enter to track a remote branch locally

nnoremap <leader>gc :GBranches<CR>

" --------------
" ## _vista_vim_
" --------------

" ### Settings
let g:vista_default_executive = 'coc' " TODO: check other executives
let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 1
let g:vista_sidebar_width = 60
let g:vista_echo_cursor = 0

" ### Keybindings
nnoremap <silent> <C-t> :Vista!!<CR>

" ---------------
" ## _vimspector_
" ---------------

" ### Settings
let g:vimspector_enable_mappings = 'HUMAN'
" ### Keybindings
" :h vimspector-human-mode

" mnemonic 'di' = 'debug inspect'
" use change window focus keys to close the balloon
" for normal mode - the word under the cursor
nmap <Leader>di <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
xmap <Leader>di <Plug>VimspectorBalloonEval


" ----------------------------
" ## _rainbow_delimiters_nvim_
" ----------------------------

" ### Settings
let g:rainbow_delimiters = {
    \ 'strategy': {
        \ '': rainbow_delimiters#strategy.global,
        \ 'vim': rainbow_delimiters#strategy.local,
    \ },
    \ 'query': {
        \ '': 'rainbow-delimiters',
        \ 'lua': 'rainbow-blocks',
    \ },
    \ 'priority': {
        \ '': 110,
        \ 'lua': 210,
    \ },
    \ 'highlight': [
        \ 'RainbowDelimiterRed',
        \ 'RainbowDelimiterOrange',
        \ 'RainbowDelimiterYellow',
        \ 'RainbowDelimiterCyan',
        \ 'RainbowDelimiterGreen',
        \ 'RainbowDelimiterViolet',
        \ 'RainbowDelimiterBlue',
    \ ],
\ }

" Link highlight groups to Dracula colors if Dracula is installed
if hlexists('DraculaRed')
    highlight link RainbowDelimiterRed DraculaFg
    highlight link RainbowDelimiterOrange DraculaOrange
    highlight link RainbowDelimiterYellow DraculaYellow
    highlight link RainbowDelimiterCyan DraculaCyan
    highlight link RainbowDelimiterGreen DraculaGreen
    highlight link RainbowDelimiterViolet DraculaPink
endif
" ### Keybindings
nnoremap <silent> <Leader>tr :call rainbow_delimiters#toggle(0)<CR>
