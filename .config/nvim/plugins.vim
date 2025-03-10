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
source $HOME/.vimrc.plugins

Plug 'HiPhish/rainbow-delimiters.nvim'
Plug 'SirVer/ultisnips' " snippet manager
Plug 'ThePrimeagen/refactoring.nvim'
Plug 'andrewferrier/debugprint.nvim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' } " color theme
Plug 'cdelledonne/vim-cmake'
Plug 'dense-analysis/ale' " configurable async linter/fixer for programming languages
Plug 'honza/vim-snippets' " compilation of useful snippets
Plug 'inkarkat/vim-SyntaxRange'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " fuzzy file finder
Plug 'junegunn/fzf.vim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'lifepillar/pgsql.vim' " support for PostgreSQL
Plug 'liuchengxu/vista.vim' " tags and lsp symbols viewer
Plug 'lukas-reineke/indent-blankline.nvim' " add vertical indent guides
Plug 'mattn/emmet-vim' " good for html tags
Plug 'maximbaz/lightline-ale' " ale integration for lightline
Plug 'neoclide/coc.nvim', { 'branch': 'release' } " load extensions like VSCode and host language servers
Plug 'norcalli/nvim-colorizer.lua' " colorize color names and RGB codes
Plug 'nvim-neorg/neorg', { 'tag': 'v7.0.0', 'do': ':Neorg sync-parsers'} | Plug 'nvim-lua/plenary.nvim' " Neovim org-like format
Plug 'nvim-tree/nvim-tree.lua' " tree-like file browser
Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " better parsing for syntax highlight
Plug 'othree/html5.vim', {'for': ['html', 'html5', 'htm']} " html5 syntax highlight
Plug 'pangloss/vim-javascript' " javascript syntax highlight
Plug 'puremourning/vimspector' " A multi-language debugging system for Vim
Plug 'shime/vim-livedown' " live preview of markdown
Plug 'stsewd/fzf-checkout.vim'
Plug 'tadmccorkle/markdown.nvim'
Plug 'tpope/vim-dadbod' " modern database interface for Vim

call plug#end()


" -------------------
" # _PLUGIN_SETTINGS_
" -------------------

" ## Contents

" _ale_
" _catppuccin_
" _coc_nvim_
" _debugprint_nvim_
" _emmet_vim_
" _fzf_checkout_vim_
" _fzf_vim_
" _gitsigns_nvim_
" _indent_blankline_nvim_
" _markdown_nvim_
" _neorg_
" _nvim_colorizer_lua_
" _nvim_tree_lua_
" _nvim_treesitter_
" _rainbow_delimiters_nvim_
" _refactoring_nvim_
" _ultisnips_
" _vim_dadbod_
" _vim_livedown_
" _vimspector_
" _vista_vim_
" _vim_cmake_

" ---------------
" ## _catppuccin_
" ---------------

" ### Settings
let g:latte = luaeval('require("catppuccin.palettes").get_palette "latte"')
let g:mocha = luaeval('require("catppuccin.palettes").get_palette "mocha"')

lua << EOF
require("catppuccin").setup({
    flavour = "auto", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "mocha",
    },
    transparent_background = false, -- disables setting the background color.
    show_end_of_buffer = true, -- shows the '~' characters after the end of buffers
    term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
        enabled = true, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.10, -- percentage of the shade to apply to the inactive window
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    no_underline = false, -- Force no underline
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
        -- miscs = {}, -- Uncomment to turn off hard-coded styles
    },
    color_overrides = {},
    custom_highlights = {},
    default_integrations = true,
    integrations = {
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        coc_nvim = true,
        indent_blankline = {
            enabled = true,
            scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
            colored_indent_levels = false,
        },
        markdown = true,
        rainbow_delimiters = true
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
})
EOF

" -----------------
" ## _vim_livedown_
" -----------------

" ### Settings
let g:livedown_port = 8001
let g:livedown_browser = "xdg-open"
let g:livedown_open = 1

" ### Keybindings
nmap <leader>tm :LivedownToggle<CR>

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

augroup ale_highlight
    autocmd!
    autocmd ColorScheme *
        \ highlight ALEError ctermbg=White ctermfg=DarkRed |
        \ highlight ALEWarning ctermbg=LightYellow ctermfg=DarkMagenta
augroup END

" Set linters by file type
let g:ale_linters = {
\   'bitbake': [],
\   'c': [],
\   'cpp': [],
\   'css': ['stylelint'],
\   'html': ['tidy'],
\   'javascript': [],
\   'latex': ['chktex'],
\   'python': ['flake8'],
\   'rust': ['analyzer'],
\   'scss': ['stylelint'],
\   'sh': ['shellcheck'],
\   'sql': [],
\   'typescript': []
\}

" Set fixers by file type
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'c': ['clang-format'],
\   'cpp': ['clang-format'],
\   'css': ['stylelint'],
\   'html': ['html-beautify'],
\   'javascript': ['eslint'],
\   'json': ['jq'],
\   'latex': ['chktex'],
\   'python': ['black', 'isort'],
\   'rust': ['rustfmt'],
\   'scss': ['stylelint'],
\   'sh': ['shfmt'],
\   'sql': ['pgformatter'],
\   'typescript': ['eslint']
\}

" Python
let g:ale_python_flake8_options = '--max-line-length 120 --ignore=E501'
let g:ale_python_autopep8_options = '--max-line-length 120'
let g:ale_python_black_options = '--line-length 120 --target-version py310'

" HTML
let g:ale_html_beautify_options = '--indent-size 2 --max-preserve-newlines 2 --wrap-line-length 120'
let g:ale_html_tidy_options = ""

" C/C++
let g:ale_c_clangformat_options = "-style='{BasedOnStyle: WebKit, ColumnLimit: 120, BreakBeforeBraces: Stroustrup, IndentWidth: 4, IndentCaseLabels: false, PointerAlignment: Left, SpaceBeforeAssignmentOperators: true, AllowShortBlocksOnASingleLine: Never, AllowShortFunctionsOnASingleLine: InlineOnly, AlwaysBreakTemplateDeclarations: Yes}'"
" let g:ale_c_clangformat_options = "--assume-filename=$HOME/.config/.clang-format"

let g:ale_cpp_astyle_project_options = ".astyle.ini"
let g:ale_c_astyle_project_options = ".astyle.ini"

let g:ale_c_uncrustify_options = "-c .uncrustify.cfg"

" Rust
let g:ale_rust_analyzer_executable = "$HOME/.config/coc/extensions/coc-rust-analyzer-data/rust-analyzer"
let g:ale_rust_rustfmt_options = "--config wrap_comments=true,format_code_in_doc_comments=true,overflow_delimited_expr=true"

" Bash/Sh
let g:ale_sh_shfmt_options = "-i 4 -fn -sr -ci"

" Javascript
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_javascript_prettier_executable = './node_modules/.bin/prettier'
let g:ale_javascript_eslint_executable = './node_modules/.bin/eslint'

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

augroup coc_fix_on_save
    autocmd!
    autocmd BufWritePre *.html if &ft == "htmldjango" |
        \ CocCommand htmldjango.djlint.format | endif
augroup END

let g:coc_user_config = {}
" CoC extensions to install automatically
let g:coc_global_extensions = [
    \ 'coc-bitbake',
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
    \ 'coc-htmldjango',
    \ 'coc-jedi',
    \ 'coc-json',
    \ 'coc-lists',
    \ 'coc-marketplace',
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
nmap <silent> gt <Plug>(coc-type-definition)
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

" ------------------
" ## _nvim_tree_lua_
" ------------------

" ### Settings
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
                border = "solid",
                width = 30,
                height = 1000,
                row = 1,
                col = 1,
            },
        },
        adaptive_size = true,
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
                autochdir = false, -- Automatically change the directory to the current workspace's root every time
                autodetect = false,
                index = "", -- The name of the main (root) .norg file
            }
        },
    }
}
EOF

" ### Keybindings
augroup neorg_keybindings
    autocmd!
    autocmd FileType norg nnoremap <buffer> <silent> <localleader>nm :Neorg inject-metadata<CR>
    " insert anchor
    autocmd FileType norg nnoremap <buffer> <silent> <localleader>a i<C-v>{<C-v>}<Esc>h"+p
augroup END

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
    -- :TSInstall bibtex c_sharp java latex rust
    ensure_installed = {
        "bash",
        "c",
        "cmake",
        "comment",
        "cpp",
        "css",
        "dockerfile",
        "html",
        "htmldjango",
        "http",
        "javascript",
        "json",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "norg",
        "python",
        "regex",
        "scss",
        "sql",
        "typescript",
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

" ------------
" ## _fzf_vim_
" ------------

" ### Settings
let g:fzf_tags_command = 'ctags -R'
let g:fzf_layout = {'up':'~80%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5} }
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" FZF Buffer Delete
command! BuffersDelete call fzf#run(fzf#wrap({
    \ 'source': s:list_buffers(),
    \ 'sink*': { lines -> s:delete_buffers(lines) },
    \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
\ }))

" FZF List only modified buffers
command! BuffersModified call fzf#run(fzf#wrap({
    \ 'source': s:list_modified_buffers(),
    \ 'sink': { key -> execute('b ' .. key) },
    \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
\ }))

" Don't consider filename as a match in :Rg command
command! -bang -nargs=* Rg call fzf#vim#grep("rg --glob '!.git/**' --glob '!node_modules/**' --hidden --column --line-number --no-heading --color=always --smart-case "
    \ .shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

" :RG command with --max-depth option given as parameter
command! -bang -nargs=1 RGd call fzf#vim#grep2("rg --glob '!.git/**' --glob '!node_modules/**' --hidden --column --line-number --no-heading --color=always --smart-case --max-depth "
    \ .(<q-args>), '', {}, <bang>0)

let s:config="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
command! ConfigEdit call fzf#run(fzf#wrap({
    \ 'source': s:config . ' ls-tree --name-only -r --full-name master $HOME',
    \ 'sink': { key -> execute('e ' . $HOME . '/' . key) },
    \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
\ }))

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

function! s:list_modified_buffers()
  redir => list
  silent ls +
  redir END
  return map(split(list, "\n"), { _, line -> split(line, '"')[1]})
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
nnoremap <leader>fB :BuffersModified<CR>
nnoremap <leader>fg :Rg!<CR>
" Git Bindings
nnoremap <leader>gf :GFiles!?<CR>
nnoremap <leader>gF :GFiles!<CR>
nnoremap <leader>gc :GV!<CR>
nnoremap <leader>gC :GV<CR>

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

nnoremap <leader>gb :GBranches<CR>

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
    \ 'blacklist': [
        \ 'comment',
        \ 'vim',
    \ ],
\ }

" ### Keybindings
nnoremap <Leader>tr :call rainbow_delimiters#toggle(0)<CR>

" ------------------
" ## _markdown_nvim_
" ------------------

" ### Settings
lua << EOF
require('markdown').setup({
    -- Disable all keymaps by setting mappings field to 'false'.
    -- Selectively disable keymaps by setting corresponding field to 'false'.
    mappings = {
        inline_surround_toggle = false, -- (string|boolean) toggle inline style
        inline_surround_toggle_line = false, -- (string|boolean) line-wise toggle inline style
        inline_surround_delete = false, -- (string|boolean) delete emphasis surrounding cursor
        inline_surround_change = false, -- (string|boolean) change emphasis surrounding cursor
        link_add = "gl", -- (string|boolean) add link
        link_follow = "gx", -- (string|boolean) follow link
        go_curr_heading = false, -- (string|boolean) set cursor to current section heading
        go_parent_heading = false, -- (string|boolean) set cursor to parent section heading
        go_next_heading = "]]", -- (string|boolean) set cursor to next section heading
        go_prev_heading = "[[", -- (string|boolean) set cursor to previous section heading
    },
    link = {
        paste = {
            enable = true, -- whether to convert URLs to links on paste
        },
    },
    toc = {
        -- Comment text to flag headings/sections for omission in table of contents.
        omit_heading = "toc omit heading",
        omit_section = "toc omit section",
        -- Cycling list markers to use in table of contents.
        -- Use '.' and ')' for ordered lists.
        markers = { "-" },
    },
    -- Hook functions allow for overriding or extending default behavior.
    -- Called with a table of options and a fallback function with default behavior.
    -- Signature: fun(opts: table, fallback: fun())
    hooks = {
        -- Called when following links. Provided the following options:
        -- * 'dest' (string): the link destination
        -- * 'use_default_app' (boolean|nil): whether to open the destination with default application
        --   (refer to documentation on <Plug> mappings for explanation of when this option is used)
        follow_link = nil,
    },
    on_attach = nil, -- (fun(bufnr: integer)) callback when plugin attaches to a buffer
})
EOF
" ### Keybindings

augroup markdown_keybindings
    autocmd!
    autocmd FileType markdown nnoremap <buffer> <silent> gO :MDToc<CR>
    autocmd FileType markdown nnoremap <buffer> <silent> <localleader>tt :MDTaskToggle<CR>
augroup END

" --------------
" ## _vim_cmake_
" --------------

" ### Settings
let g:cmake_link_compile_commands = 1
let g:cmake_root_markers = ['.git', '.svn']
" let g:cmake_build_options = []
let g:cmake_generate_options = ["-D CMAKE_C_COMPILER=/usr/bin/gcc-12", "-D CMAKE_CXX_COMPILER=/usr/bin/g++-12"]

augroup vim_cmake_group
    autocmd!
    " autoclose vimcmake window after successful build
    " repeat() function causes soft-wrap into two lines for ENTER prompt to show
    autocmd User CMakeBuildSucceeded echo "CMake Build Succeeded!" . repeat(" ", &columns) | CMakeClose!

    " Needed for graceful closing of CMake window
    autocmd FileType vimcmake nnoremap <buffer><silent>qq :CMakeClose!<CR>
augroup END

" ### Keybindings
" Create Release config (default is Debug)   :CMakeGenerate build -DCMAKE_BUILD_TYPE=Release
nnoremap <leader>cg :CMakeGenerate build -DCMAKE_BUILD_TYPE=Debug
nnoremap <leader>cb :CMakeBuild<CR>
nnoremap <leader>co :CMakeOpen<CR>
nnoremap <leader>cr :CMakeRun
