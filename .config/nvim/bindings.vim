" <CR> means carriage return, another saying of <Enter>

let mapleader = "\<Space>"

" quit without saving
nnoremap qq :q!<CR>
" quit after saving
nnoremap qw :wq<CR>
" save with Ctrl + S (might cause problems in some terminals, check my vim alias in .zshrc also)
noremap <C-s> :w<CR>
inoremap <C-s> <ESC>:w<CR>a

" vim-auto-save
noremap <M-s> :AutoSaveToggle<CR>
inoremap <M-s> <ESC>:AutoSaveToggle<CR>a

" NERDTree bindings
nnoremap <silent> <C-c> :NERDTreeToggle<CR>
" " Map to open current file in NERDTree
nnoremap <leader>pv :NERDTreeFind<bar><CR>

nnoremap <Leader>v :Vista!!<CR>

" Copy-paste bindings for system clipboard (+)
nnoremap <Leader>yy "+y
nnoremap <Leader>pp "+p

" Change vim window focus
map <C-h> <C-w>h
map <C-l> <C-w>l
map <C-j> <C-w>j
map <C-k> <C-w>k

" Move between tabs
nnoremap <silent> <C-M-l> :tabn<cr>
nnoremap <silent> <C-M-h> :tabp<cr>

" Resize vim windows
nnoremap <silent> <C-Down> :resize -2<CR>
nnoremap <silent> <C-Up> :resize +2<CR>
nnoremap <silent> <C-Left> :vertical resize -2<CR>
nnoremap <silent> <C-Right> :vertical resize +2<CR>

" COC (language server) bindings
imap <C-k> <Plug>(coc-snippets-expand-jump)
vmap <C-j> <Plug>(coc-snippets-select)
" " Jump bindings, to go back to previous location use Ctrl+O
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" " Set trigger completion functions
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
" " Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" " Use TAB and Shift+TAB to navigate in completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" " Use <CR> to confirm completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" " Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
" " Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
" " Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Use `[c` and `]c` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" ALE bindings (Asynchronous Lint Engine)
nmap <silent> [a <Plug>(ale_previous_wrap)
nmap <silent> ]a <Plug>(ale_next_wrap)

" vim-gitgutter bindings
nmap [h <Plug>(GitGutterPrevHunk)
nmap ]h <Plug>(GitGutterNextHunk)
" " Stage the hunk with <Leader>hs
" " Undo the hunk with <Leader>hu
" " Preview the hunk with <Leader>hp

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" floaterm bindings
let g:floaterm_keymap_toggle = '<C-f>'
let g:floaterm_keymap_next   = '<F9>'
let g:floaterm_keymap_prev   = '<F8>'
let g:floaterm_keymap_new    = '<F10>'

" fzf find bindings
nmap <leader>ff :Files<cr>
nmap <leader>ft :BTags<cr>
nmap <leader>fT :Tags<cr>
nmap <leader>fl :BLines<cr>
nmap <leader>fL :Lines<cr>
nmap <leader>fg :GFiles?<cr>
nmap <leader>fb :Buffers<cr>
nmap <leader>fc :BCommits<cr>
nmap <leader>fC :Commits<cr>

" Clear previous search highlight
nnoremap <leader>h :noh<CR><esc>

" goyo
nnoremap <leader>g :Goyo<CR><esc>

" markdown-preview
nmap <leader>tm <Plug>MarkdownPreviewToggle

" Better multiple lines tabbing with < and >
vnoremap < <gv
vnoremap > >gv

" rainbow_parantheses
nnoremap <leader>tr :RainbowParentheses!!<CR>

" nvim-colorizer
nnoremap <leader>tc :ColorizerToggle<CR>

" auto-pairs
" " <M-p> : Toggle auto-pairs
" " <M-e> : Insert () or {} or [] before something then hit <M-e> to fast wrap
" " <M-n> : Jump to next closed pair

" nerdcommenter
" " [count]<leader>cc          : make lines commented
" " [count]<leader>c<space>    : toggle line's comment status (commented/uncommented)

" vim-surround
" " Works with parentheses(), brackets [], quotes (double or single), XML tags <q> </q>  and more
" " cs'<q>     : To change 'Hello' to <q>Hello</q>
" " ds'        : To remove delimiters from 'Hello'
