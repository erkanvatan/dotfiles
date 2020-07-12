" <CR> means carriage return, another saying of <Enter>

let mapleader = "\<Space>"

nnoremap qq :q!<CR>
nnoremap qw :wq<CR>
nnoremap ww :w<CR>

" NERDTree
nnoremap <silent> <C-c> :NERDTreeTabsToggle<CR>
" " Map to open current file in NERDTree and set size
nnoremap <leader>pv :NERDTreeFind<bar> :vertical resize 45<CR>

nnoremap <Leader>v :Vista!!<CR>

" Copy-paste bindings for system clipboard (+)
nnoremap <Leader>y "+y
nnoremap <Leader>p "+p

" Change vim window focus
map <C-h> <C-w>h
map <C-Left> <C-w>h
map <C-l> <C-w>l
map <C-Right> <C-w>l
map <C-j> <C-w>j
map <C-Down> <C-w>j
map <C-k> <C-w>k
map <C-Up> <C-w>k

" Move between tabs
map <C-s><up> :tabr<cr>
map <C-s><down> :tabl<cr>
map <C-s><left> :tabp<cr>
map <C-s><right> :tabn<cr>

" Resize vim windows
nnoremap <silent> <C-M-j> :resize -2<CR>
nnoremap <silent> <C-M-k> :resize +2<CR>
nnoremap <silent> <C-M-h> :vertical resize -2<CR>
nnoremap <silent> <C-M-l> :vertical resize +2<CR>

" COC (language server) bindings
imap <C-k> <Plug>(coc-snippets-expand-jump)
vmap <C-j> <Plug>(coc-snippets-select)
" " To go back to previous state use Ctrl+O
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
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Floating nvim terminal
let g:floaterm_keymap_toggle = '<F7>'
let g:floaterm_keymap_next   = '<F9>'
let g:floaterm_keymap_prev   = '<F8>'
let g:floaterm_keymap_new    = '<F10>'

" fzf find bindings
nmap ff :Files<cr>
nmap ft :BTags<cr>
nmap fT :Tags<cr>
nmap fl :BLines<cr>
nmap fL :Lines<cr>
nmap fg :GFiles?<cr>
nmap fb :Buffers<cr>
nmap fc :BCommits<cr>
nmap fC :Commits<cr>

" Clear previous search highlight
nnoremap <leader>h :noh<CR><esc>

" goyo
nnoremap <leader>g :Goyo<CR><esc>

" markdown-preview
nmap <leader>m <Plug>MarkdownPreviewToggle

" Better multiple lines tabbing with < and >
vnoremap < <gv
vnoremap > >gv

" rainbow_parantheses
nnoremap <leader>rp :RainbowParentheses!!<CR>

" nvim-colorizer
nnoremap <leader>cr :ColorizerToggle<CR>
